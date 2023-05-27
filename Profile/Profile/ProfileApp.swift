//
//  ProfileApp.swift
//  Profile
//
//  Created by Dmitry Korolev on 7/4/2023.
//

import SwiftUI

@main
public struct ProfileApp: App {
    public init() {}
    public var body: some Scene {
        WindowGroup {
            ProfileView(name: "", email: "", auth: false)
        }
    }
}
