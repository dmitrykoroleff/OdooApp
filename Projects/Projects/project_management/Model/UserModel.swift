//
//  UserModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import Foundation

struct Task: Indexable, Identifiable, Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID()
    var projectIdx: Int
    var idx: Int?
    var text: String
    var company: String?
    var tags: [String]?
    var dueTime: String?
    var subTasks: [Task]?
    var isFavorite: Bool = false
    var status: Status
    
    init(id: UUID = UUID(), projectIdx: Int = 0, idx: Int? = nil, text: String, company: String = "", tags: [String]? = nil, dueTime: String? = nil, subTasks: [Task]? = nil, isFavorite: Bool = false, status: Status) {
        self.id = id
        self.projectIdx = projectIdx
        self.text = text
        self.company = company
        self.tags = tags
        self.dueTime = dueTime
        self.subTasks = subTasks
        self.isFavorite = isFavorite
        self.status = status
        
        if idx == nil {
            if self.status.tasks.isEmpty {
                self.idx = 0
            } else {
                self.idx = self.status.tasks.count
            }
        } else {
            self.idx = idx
        }
    }
}

var tasks: [Task] = [
    
    Task(text: "QQ", status: statuses[0])
]
