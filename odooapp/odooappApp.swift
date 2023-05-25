//
//  odooappApp.swift
//  odooapp
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI
import FirebaseCore
import FirebaseRemoteConfig


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
 
            RCValues().fetchCloudValues()
    
        
        return true
    }
}

@main
struct OdooappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
}

class RCValues {
    
    init() {
        //        fetchCloudValues()
    }
    
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() -> Void {
    
        // 1
        activateDebugMode()
        
        // 2
        
        RemoteConfig.remoteConfig().fetchAndActivate()
    }
    
    
}
