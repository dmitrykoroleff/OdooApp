//
//  ApplicationError.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import Foundation

class ApplicationError: Error {

    var title: String
    var description: String

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
