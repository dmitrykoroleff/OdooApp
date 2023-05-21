//
//  StatusModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct Status: Identifiable, Equatable {
    var id: UUID
    var image: String
    var name: String
}

var statusesRecr: [Status] = [
    Status(id: UUID(), image: "globe", name: "👔Manager"),
    Status(id: UUID(), image: "bubble.left.and.bubble.right" //Пока так, надо найти с круглыми чатами
           , name: "🙈Student"),
    Status(id: UUID(), image: "gearshape", name: "Testing period"),
    Status(id: UUID(), image: "graduationcap", name: "Student"),
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
