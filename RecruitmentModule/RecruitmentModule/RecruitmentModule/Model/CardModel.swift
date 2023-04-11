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
            case "Initial Qualification":
                return "globe"
            case "Contract Proposal":
                return "bubble.left.and.bubble.right"
            case "Second Interview":
                return "gearshape"
            case "First Interview":
                return "graduationcap"
            default:
                return "unknown"
        }
    }
}
// Надо подумать как лучше форомить статусы и связать их с пользователем

var userCards: [UserCard] = (0..<10).map({ ind in
    UserCard(fullName: "\(ind)", userStatus: "Website request")
})

var userCardsinCommunication: [UserCard] = (0..<10).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "In communication")
})

var userCardstestingPeriod: [UserCard] = (0..<10).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "Testing period")
})

var userCardsstudent: [UserCard] = (0..<3).map({ _ in         //Просто для теста
    UserCard(fullName: "Arina Shoshina", userStatus: "Student")
})


var someDict: [String : [UserCard]] = [
    "Website request": userCards,
    "In communication": userCardsinCommunication,
    "Testing period":userCardstestingPeriod,
    "Student":userCardsstudent
]

