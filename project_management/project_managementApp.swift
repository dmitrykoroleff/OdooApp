//
//  project_managementApp.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

@main
struct project_managementApp: App {
    var body: some Scene {
        WindowGroup {
            ProjectsView(project: .constant(projects[0]), task: .constant(tasks[0]))
               
        }
    }
}
