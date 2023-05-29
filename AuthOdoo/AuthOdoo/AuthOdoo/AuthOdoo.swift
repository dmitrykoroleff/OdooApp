//
//  Auth_new.swift
//  AuthOdoo
//
//  Created by Nikita Rybakovskiy on 03.12.2022.
//

import Foundation
import Alamofire
import SwiftUI
public class Auth: ObservableObject {
    
    @AppStorage("prod") var prod = "" {
        willSet { objectWillChange.send() }
    }
    @AppStorage("name") var nameUser = "" {
        willSet { objectWillChange.send() }
    }
    @AppStorage("email") var emailuser = "" {
        willSet { objectWillChange.send() }
    }
    
    public init() {

    }

    @discardableResult
    public func authenticate(server: String, login: String, password: String, completion: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionTask? {
        
        let parsedServer = server.components(separatedBy: "://")
        var serverUrl: String
        
        if parsedServer.indices.contains(1) {
            serverUrl = String(parsedServer[1])
        } else {
            serverUrl = server
        }
        
        let parsedUrl = serverUrl.split(separator: ".")[0]
        var database: String

        switch parsedUrl.lowercased() {
        case "odoo":
            database = "crm"
        default:
            database = String(parsedUrl)
        }
        let parameters: [String: Any] = [
            "db": database,
            "login": login,
            "password": password
        ]

        let session = URLSession.shared
        self.authSessionId(serverUrl: serverUrl)
        self.prod = serverUrl
        self.nameUser = "Admin"
        self.emailuser = "Admin"
        let url = URL(string: "https://\(serverUrl)/web/session/authenticate")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")

        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "params": parameters
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestDictionary)
        } catch {
            print(error)
        }
        let task = session.dataTask(with: request, completionHandler: { data, response, error in

            guard error == nil, let data = data else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode
            else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                guard let responseObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    throw URLError(.badServerResponse)
                }
                completion(.success(responseObject))
            } catch let parseError {
                completion(.failure(parseError))
            }
        })
        task.resume()

        return task
    }

    //    server: "demo3.odoo.com", login: "admin", password: "admin"
    public func testAuthenticate(server: String, login: String, password: String) -> Bool {
        var resultLogIn: Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        authenticate(server: server, login: login, password: password) { result in

            switch result {
            case .failure(let error):
                print("error = \(error)")
                resultLogIn = false

            case .success(let value):
                if let errorDictionary = value["error"] as? [String: Any] {
                    print("error logging in (bad userid/password?): \(errorDictionary)")
                    resultLogIn = false
                } else if let resultDictionary = value["result"] as? [String: Any] {
                    print("successfully logged in, refer to resultDictionary for details: \(resultDictionary)")
                    resultLogIn = true
                } else {
                    print("we should never get here")
                    print("responseObject = \(value)")
                }
                semaphore.signal()
            }
        }
        semaphore.wait()
        return resultLogIn
    }
    
    
    func authSessionId(serverUrl: String) {
        let ur1 = "https://\(serverUrl)/"
        let ur2 = "web/dataset/search_read"
        AF.request("\(ur1)\(ur2)", method: .get, encoding: JSONEncoding.default).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}
