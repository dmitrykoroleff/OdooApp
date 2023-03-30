//
//  NoteModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 04.02.2023.
//

import Foundation

struct Note: Identifiable {
    var id: UUID
    var user: User
    var text: String
    var editTime: String
}


var notes: [Note] = [
    Note(id: UUID(), user: testUser, text: "Someting", editTime: "17 hours ago"),
    Note(id: UUID(), user: testUser, text: "Someting", editTime: "11 days ago"),
    Note(id: UUID(), user: testUser, text: "Someting", editTime: "1 year ago"),
]
