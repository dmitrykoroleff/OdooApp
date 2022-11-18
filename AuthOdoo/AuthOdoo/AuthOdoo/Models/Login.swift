//
//  Login.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 16.11.2022.
//

import Foundation
public struct Login: Equatable {
    let serverUrl: String
    let database: String
    let username: String
    let password: String

    public init(serverUrl: String, database: String, username: String, password: String) {
        self.serverUrl = serverUrl
        self.database = database
        self.username = username
        self.password = password
    }
}
