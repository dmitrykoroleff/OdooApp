//
//  StatusModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI
import Foundation

struct Status: Identifiable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: UUID
    var idx: Int?
    var projectIdx: Int?
    var image: String
    var name: String
    
    var tasks: [Task] = []
    
    init(id: UUID, idx: Int? = nil, projectIdx: Int? = nil, image: String, name: String) {
        
        self.id = id
        self.idx = idx
        self.projectIdx = projectIdx
        self.image = image
        self.name = name
        
        
    }
}

var statuses: [Status] = [
    Status(id: UUID(), image: "flag.checkered.circle", name: "New"),
    Status(id: UUID(), image: "brain.head.profile" //Пока так, надо найти с круглыми чатами
           , name: "In progress"),
    Status(id: UUID(), image: "flag.checkered.2.crossed", name: "Done"),
    Status(id: UUID(), image: "multiply.circle", name: "Cancelled"),
]

let additionStatuses: [[Status]] = [
    [
        Status(id: UUID(), image: "airplane", name: ""),
        Status(id: UUID(), image: "phone", name: ""),
        Status(id: UUID(), image: "calendar", name: ""),
        Status(id: UUID(), image: "chart.line.uptrend.xyaxis", name: ""),
    ],
    [
        Status(id: UUID(), image: "heart", name: ""),
        Status(id: UUID(), image: "lightbulb", name: ""),
        Status(id: UUID(), image: "hand.thumbsup", name: ""),
        Status(id: UUID(), image: "arrow.triangle.2.circlepath", name: ""),
    ],
    [
        Status(id: UUID(), image: "star", name: ""),
        Status(id: UUID(), image: "bell", name: ""),
        Status(id: UUID(), image: "pencil.line", name: ""),
        Status(id: UUID(), image: "trash", name: ""),
    ]
]

func getAllTasks(project: Project) -> [Task] {
    var tasks: [Task] = []
    for status in projects[project.idx!].statuses {
        tasks.insert(contentsOf: status.tasks, at: 0)
    }
    return tasks
    
}
