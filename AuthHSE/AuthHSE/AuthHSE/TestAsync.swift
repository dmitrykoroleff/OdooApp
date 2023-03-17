//
//  TestAsync.swift
//  AuthHSE
//
//  Created by Nikita Rybakovskiy on 14.03.2023.
//

import Foundation

class TestAsync {
    init() {
        
    }
    
    func testAuth(server: String, login: String, password: String) async throws -> String {
        var cookie = "default"
        
        struct MyJsonObject: Encodable {
            let db: String
            let login: String
            let password: String
        }
        struct SuccessInfo: Decodable {
            let success: String
        }
        
        
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
        
        let myJsonObject = MyJsonObject(db: database, login: login, password: password)
//        let parameters: [String: Any] = [
//            "db": database,
//            "login": login,
//            "password": password
//        ]
        
        let params = try JSONEncoder().encode(myJsonObject)
        

        let url = URL(string: "https://\(serverUrl)/web/session/authenticate")!

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = params
//        Task {
//            let (data, response) = try await URLSession.shared.upload(for: urlRequest, from: params)
//
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
//
//            let successInfo = try JSONDecoder().decode(SuccessInfo.self, from: data)
//
//            print(String(data: data, encoding: .utf8) ?? "default value")
//            print("Success: \(successInfo.success)")
        //        }
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
//        let decodedFood = try JSONDecoder().decode(Food.self, from: data)
        print("Async decoded data", data)
        cookie = "new"
        
        return cookie
    }
    
}
