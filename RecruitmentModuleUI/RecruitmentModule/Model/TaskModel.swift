//
//  TaskModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 06.02.2023.
//

import Foundation

struct Task: Identifiable {
    var id: UUID = UUID()
    var user: User
    var text: String
    var dueTime: String
    var type: String
}


var tasks: [Task] = [
    Task(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "ToDo"),
    Task(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "Call"),
    Task(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "Call"),
]

var activityTypes: [String] = ["Email", "Call", "Meeting", "To Do", "Reminder", "Upload document"]
var assignedTo: [String] = ["Arina Shoshina", "Arina Shoshina", "Arina Shoshina"]
