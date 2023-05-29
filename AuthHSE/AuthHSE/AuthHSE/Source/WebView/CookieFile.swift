//
//  CookieFile.swift
//  AuthHSE
//
//  Created by Данила on 29.01.2023.
//

import Foundation
import Alamofire
import SwiftUI

public class CookieFile: ObservableObject {
    
    public init() { }
    
    @AppStorage("auth") var authenticated = false {
        willSet { objectWillChange.send() }
    }
    
    @AppStorage("url") var urlGet = "" {
        willSet { objectWillChange.send() }
    }
    @AppStorage("auth") var validUrl = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("name") var nameUser = "" {
        willSet { objectWillChange.send() }
    }
    @AppStorage("email") var emailuser = "" {
        willSet { objectWillChange.send() }
    }
    
    
    @Published var isPresent: Bool = false
    @Published var goodAuth: Bool = false
    @Published var sessionID: String = ""
    func setSessionID(sid: String) {
        if self.sessionID.isEmpty {
            DispatchQueue.main.async {
                self.sessionID = sid
                self.goodAuth = true
                self.authenticated.toggle()
                self.validUrl = true
            }
        }
    }
    
    func show() {
        isPresent = true
    }
    func dismiss() {
        DispatchQueue.main.async {
            self.isPresent = false
        }
    }
    private func readCookie(forURL url: URL) -> [HTTPCookie] {
        let cookieStorage = HTTPCookieStorage.shared
        let cookies = cookieStorage.cookies(for: URL(string: urlGet)!) ?? []
        return cookies
    }
    private func deleteCookies(forURL url: URL) {
        let cookieStorage = HTTPCookieStorage.shared

        for cookie in readCookie(forURL: url) {
            cookieStorage.deleteCookie(cookie)
        }
    }
    func logOut() {
        deleteCookies(forURL: URL(string: urlGet)!)
        self.authenticated.toggle()
    }
    
    func getUrl(url: String) {
        self.urlGet = url
    }
    
    public func getError() {
        let json: [String: Any] = ["id": 100,
                                   "jsonrpc": "2.0",
                                   "method": "call",
                                   "params": [
                                    "domain": [],
                                    "fields": ["id", "name", "child_id", "parent_id", "groups_id"],
                                    "model": "ir.ui.menu"]]
//        let url = URL(string: self.urlGet)
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
//        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//            guard let data = data else { return }
//            print(data)
            let ur1 = "https://erp.miem.hse.ru/"
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
//                        print(jsonObject)
                        if jsonObject["error"] != nil  {
                            self.validUrl = false
                        }
                        
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
                    self.validUrl = false
                }
            }
//        }
        
    }
    
    enum Result {
        case success(HTTPURLResponse, Data)
        case failure(Error)
    }
}
