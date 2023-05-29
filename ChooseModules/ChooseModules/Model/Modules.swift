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
    let modules: [String]
}

extension Modules { // Хардкор
    
    static let sampleData: [Modules] = [
        Modules(name: "CRM", notifications: 0, view: CRMModule.StatusView(name: " ", email: " ", shared: CRMLogic())),
        Modules(name: "Recruitment", notifications: 1, view: RecruitmentModule.ViewOfJobs(shared: LogicR(), userName: "", userEmail: "")),
    ]
    
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
    
    func fetchCloudValues() -> [String] {
        var modules: ImplementedModules = ImplementedModules(modules: [""])
                // 1
                activateDebugMode()
                
                // 2
                
                RemoteConfig.remoteConfig().fetch { [weak self] _, error in
                    if let error = error {
                        print("Uh-oh. Got an error fetching remote values \(error.localizedDescription)")
                      // In a real app, you would probably want to call the loading
                      // done callback anyway, and just proceed with the default values.
                      // I won't do that here, so we can call attention
                      // to the fact that Remote Config isn't loading.
                      return
                    }

                    // 3
                    RemoteConfig.remoteConfig().activate { _, _ in
                      print("Retrieved values from the cloud!")
                        let implementedModules = RemoteConfig.remoteConfig()
                            .configValue(forKey: "implementedModulesIOS")
                            .stringValue ?? "undefined"
                        let data = implementedModules.data(using: .utf8)
                        
                        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [""])
                        print(modules)
//                        var arr: [String] = []
//                        for module in modules.modules {
//                            arr.append(module["nameEn"] ?? " ")
//                        }
//                        print(arr)
                    }
                  }
                
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
            return [""]
    }
    
    func getModules() -> [String] {
        var modules: ImplementedModules = ImplementedModules(modules: [""])
        let implementedModules = RemoteConfig.remoteConfig()
            .configValue(forKey: "implementedModulesIOS")
            .stringValue ?? "undefined"
        let data = implementedModules.data(using: .utf8)
        
        modules = (try? JSONDecoder().decode(ImplementedModules.self, from: data!)) ?? ImplementedModules(modules: [""])
//        print(modules)
//        var arr: [String] = []
//        for module in modules.modules {
//            arr.append(module["nameEn"] ?? " ")
//        }
        return modules.modules
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

class ModelChoose {
    
    func getFirstLetter(str: String) -> String {
        let separatedNames = str.components(separatedBy: " ")
        var initials = ""

        if let firstName = separatedNames.first, let lastName = separatedNames.dropFirst().first {
            if let firstInitial = firstName.first, let lastInitial = lastName.first {
                initials = "\(firstInitial)"
            }
        }
        return initials
    }
    
}
