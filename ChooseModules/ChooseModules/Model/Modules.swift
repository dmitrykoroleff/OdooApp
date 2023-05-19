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
import FirebaseStorage

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
    let modules: [[String:String]]
}

extension Modules { // Хардкор
    
    static let sampleData: [Modules] = [
        Modules(name: "CRM", notifications: 0, view: CRMModule.StatusView()),
        Modules(name: "Recruitment", notifications: 1, view: RecruitmentModule.RecruitmentView()),
    ]
    
}


class RCValues {
    
   init() {
        fetchCloudValues()
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
        var modules: ImplementedModules = ImplementedModules(modules: [["":""]])
        // 1
        activateDebugMode()
        
        // 2
        
        
        print("Retrieved values from the cloud!")
        let implementedModules = RemoteConfig.remoteConfig()
            .configValue(forKey: "implementedModules")
            .stringValue ?? "undefined"
        let data = implementedModules.data(using: .utf8)
        
        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [["":""]])
        
        var arr: [String] = []
        for module in modules.modules {
            arr.append(module["nameEn"]!)
        }
        
        return arr
    }
}


class StorageValues {
    
    init() {
         getModulesIcons()
     }
    
    func getModulesIcons() -> [UIImage] {
        
        let storage = Storage.storage().reference()
        var images: [UIImage] = []
        storage.child("module_icons/").listAll(completion: { (result, error) in
            
            if let error = error {
                return
            }
            
            if let result = result {
                print("items")
                for item in result.items {
                    print(item)
                    item.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            // Uh-oh, an error occurred!
                        } else {
                            // Data for "images/island.jpg" is returned
                            let image = UIImage(data: data!)
                            print(image)
                            images.append(image!)
                            //                            semaphore.signal()
                            
                        }
                    }
                    
                    item.downloadURL { url, error in
                        if let error = error {
                            // Handle any errors
                        } else {
                            // Get the download URL for 'images/stars.jpg'
                            print(url)
                        }
                    }
                }
            }
        })
        return images
    }
}
