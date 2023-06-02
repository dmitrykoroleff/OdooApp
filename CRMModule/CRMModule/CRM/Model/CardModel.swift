//
//  CardModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct TaskCard: Identifiable, Hashable {
    
    let id: UUID
    var fullName: String
    var rating: Int = 0
    var taskStatus: String
    
    init(id: UUID = UUID(), fullName: String, taskStatus: String) {
        self.id = id
        self.fullName = fullName
        self.taskStatus = taskStatus
        
    }
    
    func getTaskStatus() -> String {
        switch taskStatus {
            case "Website request":
                return "globe"
            case "In communication":
                return "bubble.left.and.bubble.right"
            case "Testing period":
                return "gearshape"
            case "Student":
                return "graduationcap"
            default:
                return "unknown"
        }
    }
}

extension TaskCard { // Хардкор
    
    static let sampleWebsiteRequest: [TaskCard] = [
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Website request")
    ]
    
    static let sampleTestingPeriod: [TaskCard] = [
        TaskCard(fullName: "Съемка фильмов", taskStatus: "Testing period"),
        TaskCard(fullName: "Съемка комедии", taskStatus: "Testing period"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Testing period")
    ]
    
    static let sampleInCommunication: [TaskCard] = [
        TaskCard(fullName: "Съемка интервью", taskStatus: "In communication"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "In communication"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "In communication"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "In communication"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "In communication")
    ]
    
    static let sampleStudent: [TaskCard] = [
        TaskCard(fullName: "Съемка интервью", taskStatus: "Student"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Student"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Student"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Student"),
        TaskCard(fullName: "Съемка интервью", taskStatus: "Student")
    ]
    
}

//var taskCards: [TaskCard] = (0..<10).map({ _ in
//    TaskCard(fullName: "Arina Shoshina", taskStatus: "Website request")
//})
//
//var taskCards_inCommunication: [TaskCard] = (0..<10).map({ _ in         //Просто для теста
//    TaskCard(fullName: "Arina Shoshina", taskStatus: "In communication")
//})
//
//var taskCards_testingPeriod: [TaskCard] = (0..<10).map({ _ in         //Просто для теста
//    TaskCard(fullName: "Arina Shoshina", taskStatus: "Testing period")
//})
//
//var taskCards_student: [TaskCard] = (0..<3).map({ _ in         //Просто для теста
//    TaskCard(fullName: "Arina Shoshina", taskStatus: "Student")
//})


var someDict: [String : [TaskCard]] = [
    "Website request": TaskCard.sampleWebsiteRequest,
    "In communication": TaskCard.sampleInCommunication,
    "Testing period": TaskCard.sampleTestingPeriod,
    "Student": TaskCard.sampleStudent
]

func getAllTasks() -> [TaskCard] {
    var res: [TaskCard] = []
    for key in someDict.keys {
        res += someDict[key]!
    }
    return res
    
}
