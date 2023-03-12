//
//  Modules.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI

struct Modules: Identifiable, Hashable {
    
    let id: UUID
    var name: String
    var notifications: Int
    
    init(id: UUID = UUID(), name: String, notifications: Int) {
        
            self.id = id
            self.name = name
            self.notifications = notifications
        
        }
}

extension Modules { // Хардкор
    
    static let sampleData: [Modules] = [
        Modules(name: "CRM", notifications: 0),
        Modules(name: "Recruitment", notifications: 1),
        Modules(name: "P", notifications: 0),
        Modules(name: "QQ", notifications: 1)
    ]
    
}


