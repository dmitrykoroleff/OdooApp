//
//  project_managementApp.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

@main
struct ProjectManagementApp: App {
    var body: some Scene {
        WindowGroup {
            InitView()
                .onAppear{
                    createTestData()
                }
               
        }
    }
}
