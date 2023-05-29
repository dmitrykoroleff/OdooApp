//
//  NoteModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import Foundation

struct Note: Identifiable {
    var id: UUID
    var task: String
    var text: String
    var editTime: String
}


var notes: [Note] = [
    Note(id: UUID(), task: "testTask", text: "Someting", editTime: "17 hours ago"),
    Note(id: UUID(), task: "testTask", text: "Someting", editTime: "11 days ago"),
    Note(id: UUID(), task: "testTask", text: "Someting", editTime: "1 year ago"),
]
