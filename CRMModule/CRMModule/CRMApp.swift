//
//  CRMApp.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

@main
struct CRMApp: App {
    var body: some Scene {
        WindowGroup {
            StatusView(taskCards: TaskCard.sampleWebsiteRequest)
        }
    }
}
