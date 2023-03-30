//
//  ProjectModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI
import Foundation

class Project: Identifiable, ObservableObject {
    var id = UUID()
    var idx: Int?
    var name: String
    var company: String
    var date: String?
    var type: [String]
    
    @Published var tasks: [String : [ProjectTask]]
    
    init(id: UUID = UUID(), idx: Int? = nil, name: String, company: String = "", date: String? = nil, type: [String], tasks: [String : [ProjectTask]]) {
        self.id = id
        self.name = name
        self.company = company
        self.date = date
        self.type = type
        self.tasks = tasks
        
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

extension Project: Equatable {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.idx == rhs.idx &&
            lhs.name == rhs.name
            lhs.company == rhs.company &&
            lhs.date == rhs.date
            lhs.type == rhs.type
    }
}

class ProjectTask: Identifiable, ObservableObject {
    var id = UUID()
//    var idx: Int?
    var text: String
    var company: String
    var tags: [String]?
    var dueTime: String?
    var subTasks: [ProjectTask]?
    var isFavorite: Bool = false
    var status: String = "New"
    
    init(id: UUID = UUID(),  text: String, company: String = "", tags: [String]? = nil, dueTime: String? = nil, subTasks: [ProjectTask]? = nil, isFavorite: Bool = false, status: String = "New") {
        self.id = id
        self.text = text
        self.company = company
        self.tags = tags
        self.dueTime = dueTime
        self.subTasks = subTasks
        self.isFavorite = isFavorite
        self.status = status
    }
}



var projects: [Project] = [
    Project(idx: 0, name: "Office Design", company: "YourCompany, Joel Willis",date: "02/01/2023", type: ["External"], tasks: someDict),
    Project(idx: 1, name: "Renovations",date: "03/09/2023", type: ["External", "Internal"], tasks: [:]),
    Project(idx: 2, name: "Research & Develop", type: ["Internal"], tasks: someDict)
]

//var projects: [Project] = []

var projectTasks: [ProjectTask] = [
    ProjectTask(text: "Meeting Room Furnitures", company: "YourCompany, Joel Willis"),
    ProjectTask(text: "Customer review", company: "YourCompany, Joel Willis", subTasks: (0..<5).map({_ in
        ProjectTask(text: "Text")
    })),
    ProjectTask(text: "Office planning")
]

var inProgress: [ProjectTask] = [
    ProjectTask(text: "Room2: Decoration", company: "YourCompany, Joel Willis", isFavorite: true),
    ProjectTask(text: "Room1: Decoration", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "Yesterday"),
    ProjectTask(text: "Black chairs for manager", company: "YourCompany, Joel Willis", tags: ["New Feature"], dueTime: "In 9 days")
]


var someDict: [String : [ProjectTask]] = [
    "New": projectTasks,
    "In progress": inProgress,
    "Done":[],
    "Cancelled":[]
]
