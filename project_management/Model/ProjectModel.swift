//
//  ProjectModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI
import Foundation

struct Project: Indexable, Identifiable, Equatable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    var id = UUID()
    var idx: Int?
    var name: String
    var company: String
    var date: String?
    var type: [String]
    var statuses: [Status] = [
        Status(id: UUID(), image: "flag.checkered.circle", name: "New"),
        Status(id: UUID(), image: "brain.head.profile" //Пока так, надо найти с круглыми чатами
               , name: "In progress"),
        Status(id: UUID(), image: "flag.checkered.2.crossed", name: "Done"),
        Status(id: UUID(), image: "multiply.circle", name: "Cancelled"),
//        Status(id: UUID(), image: "", name: "Add new"),
    ]

    
    init(id: UUID = UUID(), idx: Int? = nil, name: String, company: String = "", date: String? = nil, type: [String]) {
        self.id = id
        self.name = name
        self.company = company
        self.date = date
        self.type = type
        
        
        if idx == nil {
            if projects.isEmpty {
                self.idx = 0
            } else {
                self.idx = projects.count
            }
        } else {
            self.idx = idx
        }
    }
    
}


var projects: [Project] = [
    Project(idx: 0, name: "Office Design", company: "YourCompany, Joel Willis",date: "02/01/2023", type: ["External"]),
    Project(idx: 1, name: "Renovations",date: "03/09/2023", type: ["External", "Internal"]),
    Project(idx: 2, name: "Research & Develop", type: ["Internal"])
]

func createTestData() {
    projects[0].statuses[0].tasks = [
        Task(text: "Meeting Room Furnitures", company: "YourCompany, Joel Willis", status: projects[0].statuses[0]),
        Task(text: "Customer review", company: "YourCompany, Joel Willis", subTasks: (0..<5).map({_ in
            Task(text: "Text", status: projects[0].statuses[0])
        }), status: projects[0].statuses[0]),
        Task(text: "Office planning", status: projects[0].statuses[0])
    ]
    
    projects[0].statuses[1].tasks = [
        Task(text: "Room2: Decoration", company: "YourCompany, Joel Willis", isFavorite: true, status: projects[0].statuses[1]),
        Task(text: "Room1: Decoration", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "Yesterday", status: projects[0].statuses[1]),
        Task(text: "Black chairs for manager", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "In 9 days", status: projects[0].statuses[1])
    ]
    
    projects[2].statuses[0].tasks = [
        Task(text: "Meeting Room Furnitures", company: "YourCompany, Joel Willis", status: projects[0].statuses[0]),
        Task(text: "Customer review", company: "YourCompany, Joel Willis", subTasks: (0..<5).map({_ in
            Task(text: "Text", status: projects[0].statuses[0])
        }), status: projects[0].statuses[0]),
        Task(text: "Office planning", status: projects[0].statuses[0])
    ]
    
    projects[2].statuses[1].tasks = [
        Task(text: "Room2: Decoration", company: "YourCompany, Joel Willis", isFavorite: true, status: projects[0].statuses[1]),
        Task(text: "Room1: Decoration", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "Yesterday", status: projects[0].statuses[1]),
        Task(text: "Black chairs for manager", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "In 9 days", status: projects[0].statuses[1])
    ]
}

