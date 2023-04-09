//
//  TaskModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import Foundation

struct Task: Identifiable {
    var id: UUID
    var name: String
    var price: String
    var generalInformation: [String: String]
    var rating: Int
    
}

let generalInformation = [
    "Custumer",
    "Email",
    "Phone",
    "Sales person",
    "Sales team",
    "Expected closing",
    "Priority",
    "Tags"
]

var testTask = Task(id: UUID(), name: "Cъемка интервью", price: "0.00 руб at 91.67%",
                    generalInformation: [
    "Costumer" : "УЛ СВТ",
    "Email" : "aashoshina@miem.hse.ru",
    "Phone" : "+79013686745",
    "Sales person" : "",
    "Sales team" : "",
    "Expected closing" : "10/06/2022  19:33:34", //
    "Priority" : "",
    "Tags" : ""
], rating: 2)

struct Schedule: Identifiable {
    var id: UUID = UUID()
    var user: User
    var text: String
    var dueTime: String
    var type: String
}

var scheduleTasks: [Schedule] = [
    Schedule(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "ToDo"),
    Schedule(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "Call"),
    Schedule(user: testUser, text: "Someting", dueTime: "Due in 4 days", type: "Call"),
]

var activityTypes: [String] = ["Email", "Call", "Meeting", "To Do", "Reminder", "Upload document"]
var assignedTo: [String] = ["Arina Shoshina", "Arina Shoshina", "Arina Shoshina"]
