//
//  Auth_new.swift
//  AuthOdoo
//
//  Created by Nikita Rybakovskiy on 03.12.2022.
//

import Foundation
public class Auth {
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
        let task = session.dataTask(with: request) { data, response, error in

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
        }
        task.resume()

        return task
    }

    //    server: "demo3.odoo.com", login: "admin", password: "admin"
    public func testAuthenticate(server: String, login: String, password: String) {
        authenticate(server: server, login: login, password: password) { result in

            switch result {
            case .failure(let error):
                print("error = \(error)")

            case .success(let value):
                if let errorDictionary = value["error"] as? [String: Any] {
                    print("error logging in (bad userid/password?): \(errorDictionary)")
                } else if let resultDictionary = value["result"] as? [String: Any] {
                    print("successfully logged in, refer to resultDictionary for details: \(resultDictionary)")
                } else {
                    print("we should never get here")
                    print("responseObject = \(value)")
                }
            }
        }
    }
}
