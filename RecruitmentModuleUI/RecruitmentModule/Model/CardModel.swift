//
//  CardModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 31.01.2023.
//

import Foundation

struct UserCard: Identifiable, Hashable {
    
    let id: UUID
    var fullName: String
    var rating: Int = 0
    var userStatus: String
    
    init(id: UUID = UUID(), fullName: String, userStatus: String) {
        self.id = id
        self.fullName = fullName
        self.userStatus = userStatus
        
    }
    
    func getUserStatus() -> String {
        switch userStatus {
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
// Надо подумать как лучше форомить статусы и связать их с пользователем

var userCards: [UserCard] = (0..<10).map({ _ in
    UserCard(fullName: "Arina Shoshina", userStatus: "Website request")
})

var userCards_inCommunication: [UserCard] = (0..<10).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "In communication")
})

var userCards_testingPeriod: [UserCard] = (0..<10).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "Testing period")
})

var userCards_student: [UserCard] = (0..<3).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "Student")
})


var someDict: [String : [UserCard]] = [
    "Website request": userCards,
    "In communication": userCards_inCommunication,
    "Testing period":userCards_testingPeriod,
    "Student":userCards_student
]

