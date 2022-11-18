//
//  AppState.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 16.11.2022.
//


import SwiftUI
import Combine

struct AppState: Equatable {
    var userContext = UserContext()
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserContext: Equatable {
        var serverVersion: String = ""
    }
}

extension AppState {
    struct UserData: Equatable {
        var user: User = .init()
    }
}

extension AppState {
    struct ViewRouting: Equatable {

    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system
}

