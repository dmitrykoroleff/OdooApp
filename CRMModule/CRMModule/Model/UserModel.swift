//
//  UserModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 13/3/2023.
//

import Foundation

struct User: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var phone: String
    var jobs: [String: String]
    var rating: Int
    
}

let jobs = [
    "Applied job",
    "Department",
    "Recruter's project",
    "Person's group",
    "Tags",
    "Recruter",
    "Hire date",
    "Appecietion",
    "Source",
    "Test task"
]

var testUser = User(id: UUID(),name: "Arina Shoshina", email: "aashoshina@miem.hse.ru", phone: "+79013686745",
                    jobs: [
    "Applied job" : "УЛ СВТ",
    "Department" : "",
    "Recruter's project" : "",
    "Person's group" : "",
    "Tags" : "",
    "Recruter" : "Королев Денис Александрович", //
    "Hire date" : "10/06/2022 19:33:34",
    "Source" : "",
    "Test task" : ""
], rating: 2)
