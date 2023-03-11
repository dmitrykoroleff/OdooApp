//
//  GetModules.swift
//  AuthHSE
//
//  Created by Nikita Rybakovskiy on 11.03.2023.
//

import Foundation
class AppModel {
    
    var cookie: String
    
    public init(cookie: String) {
        self.cookie = cookie
    }
    
    // Список всех модулей
    @discardableResult
    public func getAllModules(completion: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionTask? {
        let session = URLSession.shared
        let url = URL(string: "https://odoo.miem.tv/web/dataset/search_read")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")
        request.setValue(self.cookie, forHTTPHeaderField: "Cookie")
        
        var params: [String: Any] = [
            "fields": [
                "id", "name", "child_id", "parent_id", "groups_id"
            ],
            "model": "ir.ui.menu"
        ]
        
        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "call",
            "params": params
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
    
    // Информация о юзере
    @discardableResult
    public func getUserInfo(completion: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionTask? {
        let session = URLSession.shared
        let url = URL(string: "https://odoo.miem.tv/web/dataset/search_read")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")
        request.setValue(self.cookie, forHTTPHeaderField: "Cookie")
        
        var params: [String: Any] = [
            "domain": [],
            "fields": [
                "id", "user_id", "x_favourite_modules"
            ],
            "model": "res.users.settings"
        ]
        
        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "call",
            "params": params
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
    
    // список всех групп
    @discardableResult
    public func getGroupList(completion: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionTask? {
        let session = URLSession.shared
        let url = URL(string: "https://odoo.miem.tv/web/dataset/search_read")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")
        request.setValue(self.cookie, forHTTPHeaderField: "Cookie")
        
        var params: [String: Any] = [
            "domain": [],
            "fields": [
                "id", "name", "users"
            ],
            "model": "res.groups"
        ]
        
        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "call",
            "params": params
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
    
    
    // обновлять избранные модули юзера на бэке
    @discardableResult
    public func updateFavouriteModules(id: Int, completion: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionTask? {
        let session = URLSession.shared
        let url = URL(string: "https://odoo.miem.tv/web/dataset/search_read")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json-rpc", forHTTPHeaderField: "Content-Type")
        request.setValue(self.cookie, forHTTPHeaderField: "Cookie")
        
        var params: [String: Any] = [
            "domain": [],
            "method": "write",
            "model": "res.users.settings",
            "args": [id, ["x_favourite_modules": [79, 170]]]
        ]
        
        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "call",
            "params": params
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
    
    
    // Обраюотчик результата
    public func hanldingResult() -> Bool {
        var resultLogIn: Bool = false
        getAllModules() { result in

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
            }
        }
        
        return resultLogIn
    }
    
}
