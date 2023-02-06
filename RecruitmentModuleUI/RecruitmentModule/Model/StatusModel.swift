//
//  StatusModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 02.02.2023.
//

import SwiftUI

struct Status: Identifiable {
    var id: UUID
    var image: String
    var name: String
}

var statuses: [Status] = [
    Status(id: UUID(), image: "globe", name: "Website request"),
    Status(id: UUID(), image: "bubble.left.and.bubble.right" //Пока так, надо найти с круглыми чатами
           , name: "In communication"),
    Status(id: UUID(), image: "gearshape", name: "Testing period"),
    Status(id: UUID(), image: "graduationcap", name: "Student"),
]

enum userStatus: String {
    case websiteRequest = "globe"
    case inCommunication = "bubble.left.and.bubble.right"
    case testingPeriod = "gearshape"
    case student = "graduationcap"
}


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
