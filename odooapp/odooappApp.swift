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
//    RCValues().fetchCloudValues()
      
    return true
  }
}

@main
struct OdooappApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView()
                .onAppear{
//                    RCValues().fetchCloudValues()
                }
        }
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
            
            RemoteConfig.remoteConfig().fetchAndActivate()
//                RemoteConfig.remoteConfig().fetch { [weak self] _, error in
//                    if let error = error {
//                        print("Uh-oh. Got an error fetching remote values \(error.localizedDescription)")
//                      // In a real app, you would probably want to call the loading
//                      // done callback anyway, and just proceed with the default values.
//                      // I won't do that here, so we can call attention
//                      // to the fact that Remote Config isn't loading.
//                      return
//                    }
//
//                    // 3
//                    RemoteConfig.remoteConfig().activate { _, _ in
//                      print("Retrieved values from the cloud!")
////                        let implementedModules = RemoteConfig.remoteConfig()
////                            .configValue(forKey: "implementedModules")
////                            .stringValue ?? "undefined"
////                        let data = implementedModules.data(using: .utf8)
//
////                        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [["":""]])
////                        print(modules)
////                        var arr: [String] = []
////                        for module in modules.modules {
////                            arr.append(module["nameEn"] ?? " ")
////                        }
////                        print(arr)
//                    }
//                  }
                
        //        RemoteConfig.remoteConfig().activate()
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
//            return [""]
    }
    
}
