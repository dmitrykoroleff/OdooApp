//
//  User.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import Foundation

struct User {
    let id = UUID().uuidString
    let email: String
    let name: String
    
    init(email: String? = nil,
         name: String? = nil) {
        self.email = email ?? ""
        self.name = name ?? ""
    }
    
    
}
