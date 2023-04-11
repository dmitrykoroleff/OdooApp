//
//  Modules.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
import CRMModule
import RecruitmentModule

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

extension Modules { // Хардкор
    
    static let sampleData: [Modules] = [
        Modules(name: "CRM", notifications: 0, view: CRMModule.StatusView()),
        Modules(name: "Recruitment", notifications: 1, view: RecruitmentModule.RecruitmentView()),
    ]
    
}


