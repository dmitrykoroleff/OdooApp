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

class RCValues {
    
   init() {
//        fetchCloudValues()
    }
    
//    func loadDefaultValues() {
//        let appDefaults: [String: Any?] = [
//            "appPrimaryColor": "#FBB03B"
//        ]
//        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
//    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() -> Void {
//        var modules: ImplementedModules = ImplementedModules(modules: [["":""]])
                // 1
                activateDebugMode()
        
                
                // 2
                
//                RemoteConfig.remoteConfig().fetch { _, error in
//                    if let error = error {
//                        print("Uh-oh. Got an error fetching remote values \(error.localizedDescription)")
//                      // In a real app, you would probably want to call the loading
//                      // done callback anyway, and just proceed with the default values.
//                      // I won't do that here, so we can call attention
//                      // to the fact that Remote Config isn't loading.
//                      return
//                    }

                    // 3
//                    RemoteConfig.remoteConfig().activate { _, _ in
//                      print("Retrieved values from the cloud!")
////                        let implementedModules = RemoteConfig.remoteConfig()
////                            .configValue(forKey: "implementedModules")
////                            .stringValue ?? "undefined"
////                        let data = implementedModules.data(using: .utf8)
////                        let fff = RemoteConfig.remoteConfig().configValue(forKey: "isHseAuthEnabled")
////                        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [["":""]])
////                        print(modules)
////                        var arr: [String] = []
////                        for module in modules.modules {
////                            arr.append(module["nameEn"] ?? " ")
////                        }
////                        print(arr)
//                    }
//                  }
        
        DispatchQueue.main.async {
            RemoteConfig.remoteConfig().fetchAndActivate()
        }
        
        
                
//                RemoteConfig.remoteConfig().activate()
        //        print("Retrieved values from the cloud!")
        //        let implementedModules = RemoteConfig.remoteConfig()
        //            .configValue(forKey: "implementedModules")
        //            .stringValue ?? "undefined"
        //        let data = implementedModules.data(using: .utf8)
        //
        //        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [["":""]])
        //        print(modules)
        //        var arr: [String] = []
        //        for module in modules.modules {
        //            arr.append(module["nameEn"] ?? " ")
        //        }
        //        print(arr)
//        return RemoteConfig.remoteConfig().configValue(forKey: "isHseAuthEnabled").boolValue
        
    }
    
    func getTarget() -> Bool {
        return RemoteConfig.remoteConfig().configValue(forKey: "isHseAuthEnabled").boolValue
    }
    
}
