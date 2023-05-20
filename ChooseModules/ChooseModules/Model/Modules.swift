//
//  Modules.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
import CRMModule
import RecruitmentModule
import FirebaseRemoteConfig

struct Modules: Identifiable, Equatable {
    static func == (lhs: Modules, rhs: Modules) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    
    let id: UUID
    var name: String
    var notifications: Int
    var view: any View
    
    init(id: UUID = UUID(), name: String, notifications: Int, view: any View) {
        
        self.id = id
        self.name = name
        self.notifications = notifications
        self.view = view
        
    }
}

struct ImplementedModules: Decodable {
    let modules: [String]
}

extension Modules { // Хардкор
    
    static let sampleData: [Modules] = [
        Modules(name: "CRM", notifications: 0, view: CRMModule.StatusView()),
        Modules(name: "Recruitment", notifications: 1, view: RecruitmentModule.StatusView()),
    ]
    
}


class RCValues {
    
   init() {
        let result = fetchCloudValues()
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
    
    func fetchCloudValues() -> [String] {
        var modules: ImplementedModules = ImplementedModules(modules: [""])
        // 1
        activateDebugMode()
        
        // 2
        RemoteConfig.remoteConfig().fetch { [weak self] _, error in
            if let error = error {
                print("Uh-oh. Got an error fetching remote values \(error)")
                return
            }
            
            // 3
            RemoteConfig.remoteConfig().activate()
            
            print("Retrieved values from the cloud!")
            let implementedModules = RemoteConfig.remoteConfig()
                .configValue(forKey: "implementedModules")
                .stringValue ?? "undefined"
            let data = implementedModules.data(using: .utf8)
            
            modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [""])
            print(modules.modules)
            
        }
        return modules.modules
    }
}
