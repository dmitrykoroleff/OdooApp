//
//  AuthView.swift
//  AuthHSE
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI

public struct AuthView: View {
    @StateObject private var observed = Observed()
    @StateObject private var auth = CookieFile()
    @EnvironmentObject var viewRouter: ViewRouter
//    var bool = CookieFile().getError()
    public init() { }
    public var body: some View {
        if !auth.authenticated {
            UnauthenticatedView(model: observed.getUnauthenticatedViewModel())
        } else {
            AuthenticatedView(model: observed.getAuthenticatedViewModel())
        }
    }
}

struct UserView: View {
    @StateObject var auth = CookieFile()
    var logOut: () -> Void

    init(logOut: @escaping () -> Void) {
        self.logOut = logOut
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                VStack {
                    Button("Выход", action: auth.logOut)
                }
            }
            .navigationTitle("Профиль")
        }
    }
}

// @available(iOS 15.0, *)
struct ModulesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                VStack {
                    Button("Page1", action: {print("one")})
                        .buttonStyle(.bordered)
                    Button("Page2", action: {print("two")})
                        .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Модули")
        }
    }
}


// struct preview_AuthView: PreviewProvider {
//    static var previews: some View {
//        AuthView()
//    }
// }
