//
//  ApplicationConfigLoader.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import Foundation

struct ApplicationConfigLoader {
    static func load() throws -> ApplicationConfig {
        let configFilePath = Bundle.main.path(forResource: "config", ofType: "json")
        print("configFilePath   \(String(describing: configFilePath))")
        let jsonText = try String(contentsOfFile: configFilePath!)
        let jsonData = jsonText.data(using: .utf8)!
        let decoder = JSONDecoder()

        let data =  try decoder.decode(ApplicationConfig.self, from: jsonData)
        return data
    }
}
