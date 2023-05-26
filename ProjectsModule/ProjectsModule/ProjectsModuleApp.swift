//
//  project_managementApp.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

@main
public struct project_managementApp: App {
    public init() {}
    public var body: some Scene {
        WindowGroup {
            InitView()
                .onAppear{
                    createTestData()
                }
               
        }
    }
}
