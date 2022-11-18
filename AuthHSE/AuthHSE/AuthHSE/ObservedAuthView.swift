//
//  ObservedAuthView.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI

// MARK: remove available
// @available(iOS 15.0, *)
extension AuthView {
    class Observed: ObservableObject {
        
//      сохранить логин при выходе из приложения
        @AppStorage("auth") var authenticated = false {
            willSet { objectWillChange.send() }
        }
        @AppStorage("user") var email = "email"
        
//        private let config = try! ApplicationConfigLoader.load()
        private let config = ApplicationConfig()
        private let state = ApplicationStateManager()
        private let appauth: AppAuthHandler
        private var unauthenticatedModel: UnauthenticatedViewModel?
        private var authenticatedModel: AuthenticatedViewModel?
        
        init() {
            appauth = AppAuthHandler(config: self.config)
            print("logged on: \(authenticated)")
            print("current user: \(email)")
        }
        
        func toggleAuthentication() {
            withAnimation {
                authenticated.toggle()
            }
        }
        
        func getUnauthenticatedViewModel() -> UnauthenticatedViewModel {

            if self.unauthenticatedModel == nil {
                self.unauthenticatedModel = UnauthenticatedViewModel(
                    config: self.config,
                    state: self.state,
                    appauth: self.appauth,
                    onLoggedIn: self.logIn)
            }

            return self.unauthenticatedModel!
        }
        
        /*
         * Create on first use because Swift does not like passing the callback from the init function
         */
        func getAuthenticatedViewModel() -> AuthenticatedViewModel {

            if self.authenticatedModel == nil {
                self.authenticatedModel = AuthenticatedViewModel(
                    config: self.config,
                    state: self.state,
                    appauth: self.appauth,
                    onLoggedOut: self.logOut)
            }

            return self.authenticatedModel!
        }
        
        func logIn() {
            print("call log in")
            toggleAuthentication()
        }
        
        func logOut() {
            print("call log out")
            toggleAuthentication()
        }
    }
}
