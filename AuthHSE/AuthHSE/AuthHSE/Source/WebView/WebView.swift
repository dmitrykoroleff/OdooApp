//
//  WebView.swift
//  AuthHSE
//
//  Created by Данила on 29.01.2023.
//

import Foundation
import SwiftUI
import WebKit
import Alamofire

struct Webview: UIViewControllerRepresentable {
    let url: URL
    @ObservedObject var modelCookie: CookieFile
//    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }
    func makeUIViewController(context: Context) -> WebviewController {
        let webviewController = WebviewController(modelCookie: modelCookie)
        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)
        return webviewController
    }

    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
    }
}

class WebviewController: UIViewController, WKNavigationDelegate {
    @ObservedObject var modelCookie: CookieFile
    lazy var webview: WKWebView = WKWebView()
    lazy var progressbar: UIProgressView = UIProgressView()
    var str1: String = "https://profile.miem.hse.ru/auth/realms/MIEM/protocol/openid-connect/auth?"
    var str2: String = "response_type=token&client_id=odoo.miem.tv&redirect_uri=https://odoo.miem.tv/auth_oauth/"
    var str3: String = "signin&scope=profile&state=%7B%22d%22%3A+%22crm%22%2C+%22p%22%3A+4%2C+%22r%22%3A+%22https%253A%252F%252Fodoo.miem.tv%252Fweb%22%7D"
    init(modelCookie: CookieFile) {
        self.modelCookie = modelCookie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webview.navigationDelegate = self
        self.view.addSubview(self.webview)

        self.webview.frame = self.view.frame
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.webview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        self.webview.addSubview(self.progressbar)
        self.setProgressBarPosition()

        webview.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }

    func URLWeb(webView: WKWebView) -> String {
        if (webView.url?.host)! == "odoo.miem.tv" && modelCookie.sessionID.isEmpty {
            webView
            let aString = webview.url!.absoluteString
            let newUrl = aString.replacingOccurrences(of: "#", with: "?", options: .literal, range: nil)
            self.modelCookie.getUrl(url: newUrl)
            webview.stopLoading()
            let url = URL(string: newUrl)
            var cookies = readCookie(forURL: url!)
            let json: [String: Any] = ["id": 100,
                                       "jsonrpc": "2.0",
                                       "method": "call",
                                       "params": [
                                            "domain": [],
                                            "fields": ["id", "user_id", "x_favourite_modules"],
                                            "model": "res.users.settings"]]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            executeURLRequest(url: url!) { result in
                if case .success(_) = result {
                    _ = URLSession.shared
                    var request = URLRequest(url: url!)
                    request.httpMethod = "POST"
                    request.httpBody = jsonData
                    let ur1 = "https://odoo.miem.tv/"
                    let ur2 = "web/dataset/search_read"
                    AF.request("\(ur1)\(ur2)", method: .post, parameters: json, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
                        switch response.result {
                            case .success(let data):
                                do {
                                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                                        print("Error: Cannot convert data to JSON object")
                                        return
                                    }
                                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                                    else {
                                        print("Error: Cannot convert JSON object to Pretty JSON data")
                                        return
                                    }
                                    guard String(data: prettyJsonData, encoding: .utf8) != nil else {
                                        print("Error: Could print JSON in String")
                                        return
                                    }
                                    print("RESULT: ", jsonObject["error"])
                                    print("RESULT2: ", jsonObject["result"])
                                    print("RESULT3: ", jsonObject)
                                } catch {
                                    print("Error: Trying to convert JSON data to string")
                                    return
                                }
                            case .failure(let error):
                                print(error)
                        }
                    }
                    cookies = self.readCookie(forURL: url!)
                    for cookie in cookies {
                        if cookie.name == "session_id" {
                            if !cookie.value.isEmpty {
//                                self.modelCookie.authenticated.toggle()
                                self.modelCookie.setSessionID(sid: cookie.value)
                                self.deleteCookies(forURL: URL(string: self.str1+self.str2+self.str3)!)
                                self.modelCookie.dismiss()
                            }
                        }
                    }
                }
            }
        }
        return ""
        }

    enum Result {
        case success(HTTPURLResponse, Data)
        case failure(Error)
    }
    func readCookie(forURL url: URL) -> [HTTPCookie] {
        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: url) ?? []
        return cookies
    }
    func deleteCookies(forURL url: URL) {
        let cookieStorage = HTTPCookieStorage.shared

        for cookie in readCookie(forURL: url) {
            cookieStorage.deleteCookie(cookie)
        }
    }
    func executeURLRequest(url: URL, inSession session: URLSession = .shared, completion: @escaping (Result) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
//            if let response = response {
//                if response.url!.absoluteString == "https://odoo.miem.tv/ru/web/login?oauth_error=2" {
//                    completion(.failure(Error.self as! Error))
//                    return
//                }
//            }
            if let response = response as? HTTPURLResponse,
                let data = data {
                if response.url!.absoluteString == "https://odoo.miem.tv/ru/web/login?oauth_error=2" {
                    return
                }
                completion(.success(response, data))
                return
            }

            if let error = error {
                completion(.failure(error))
                return
            }

            let error = NSError(domain: "com.cookiesetting.test", code: 101, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
            completion(.failure(error))
        }
        task.resume()
    }
    func setProgressBarPosition() {
        let sessionId = URLWeb(webView: self.webview)

        self.progressbar.translatesAutoresizingMaskIntoConstraints = false

        self.webview.removeConstraints(self.webview.constraints)
        self.webview.addConstraints([
            self.progressbar.topAnchor.constraint(equalTo: self.webview.topAnchor, constant: self.webview.scrollView.contentOffset.y * -1),
            self.progressbar.leadingAnchor.constraint(equalTo: self.webview.leadingAnchor),
            self.progressbar.trailingAnchor.constraint(equalTo: self.webview.trailingAnchor)
        ])
    }

    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?, change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressbar.alpha = 0.0
                }, completion: { _ in
                    self.progressbar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressbar.isHidden = false
                self.progressbar.alpha = 1.0
                progressbar.setProgress(Float(self.webview.estimatedProgress), animated: true)
            }

        case "contentOffset":
            self.setProgressBarPosition()

        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
