//
//  Choose_ModuleApp.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
import RecruitmentModule
@main
public struct ChooseModuleApp: App {
    public init() {
        
    }
    public var body: some Scene {
        WindowGroup {
//            ChooseModuleView(modules: Modules.sampleData)
            ChooseModuleView(email: " ", name: " ", auth: false).onAppear{ LogicR().getData() }
        }
    }
}
