//
//  Token.swift
//  AuthHSE
//
//  Created by Melanie Kofman on 12.12.2022.
//

import Foundation
struct Token {
    func tokenHSEtoOdoo(accessToken: String, sessionState: String) {
        let url = URL(string: "https://odoo.miem.tv/web?")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let parameters: [String: Any] = [
            "access_token": accessToken,
            "session_state": sessionState,
            "token_type": "Bearer",
            "expires_in": "900"
        ]

        let requestDictionary: [String: Any] = [
            "jsonrpc": "2.0",
            "params": parameters
        ]

        let task = session.dataTask(with: request) { data, response, error in

            guard error == nil, let data = data else {
//                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode
            else {
//                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                guard let responseObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {

                    throw URLError(.badServerResponse)
                }
                print("responsed \(responseObject)")
//                completion(.success(responseObject))
            } catch let parseError {
//                completion(.failure(parseError))
            }
        }
        task.resume()

    }
}
