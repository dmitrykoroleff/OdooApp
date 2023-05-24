//
//  UnauthenticatedViewModel.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import Foundation
import SwiftCoroutine
import AppAuth
import AuthOdoo
import FirebaseRemoteConfig

class UnauthenticatedViewModel: ObservableObject {

    private let config: ApplicationConfig
    private let state: ApplicationStateManager
    private let appauth: AppAuthHandler
    private let onLoggedIn: () -> Void

    @Published var error: ApplicationError?

    init(
        config: ApplicationConfig,
        state: ApplicationStateManager,
        appauth: AppAuthHandler,
        onLoggedIn: @escaping () -> Void) {

        self.config = config
        self.state = state
        self.appauth = appauth
        self.onLoggedIn = onLoggedIn
        self.error = nil
    }

    /*
     * Run front channel operations on the UI thread and back channel operations on a background thread
     */
    func buttonFeatureToggle() -> Bool {
        let remoteConfig = RemoteConfig.remoteConfig()
        let isHseAuthEnabled = remoteConfig
            .configValue(forKey: "isHseAuthEnabled")
            .boolValue
        print("response from fb \(isHseAuthEnabled)")
        return isHseAuthEnabled
        
    }
    
    func startLogin() {

        DispatchQueue.main.startCoroutine {

            do {

                // Get metadata if required
                var metadata: OIDServiceConfiguration?
                if metadata == nil {
                    try DispatchQueue.global().await {
                        metadata = try self.appauth.fetchMetadata().await()
                    }
                }

                // Then redirect on the UI thread
                self.error = nil
                let authorizationResponse = try self.appauth.performAuthorizationRedirect(
                    metadata: metadata!,
                    clientID: self.config.clientID,
                    viewController: self.getViewController()
                ).await()

                if authorizationResponse != nil {

                    // Redeem the code for tokens
                    var tokenResponse: OIDTokenResponse?
                    try DispatchQueue.global().await {

                        tokenResponse = try self.appauth.redeemCodeForTokens(
                            clientID: self.config.clientID,
                            authResponse: authorizationResponse!

                        ).await()
                    }

                    // Update application state, then move the app to the authenticated view
                    self.state.metadata = metadata
                    self.state.saveTokens(tokenResponse: tokenResponse!)
                    self.onLoggedIn()
                }

            } catch {

                let appError = error as? ApplicationError
                if appError != nil {
                    self.error = appError!
                }
            }
        }
    }

    func logInOdooNew(serverURL: String, username: String, password: String) -> Bool {
        return AuthOdoo.Auth().testAuthenticate(server: serverURL, login: username, password: password)
    }

    private func getViewController() -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
    
    
}