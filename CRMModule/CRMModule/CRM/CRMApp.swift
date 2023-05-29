//
//  CRMApp.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

@main
public struct CRMApp: App {
    public init() {}
    public var body: some Scene {
        WindowGroup {
//            StatusView(currentIndex: 0, taskCards: TaskCard.sampleWebsiteRequest)
            StatusView(name: " ", email: " ", shared: CRMLogic())
        }
    }
}
