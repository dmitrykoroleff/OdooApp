//
//  ProjectViewModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


func generateColorFor(text: String, colors: [Color]) -> Int {
    let num = Int(((text.first?.asciiValue ?? Character("A").asciiValue)!)) % colors.count
    return num
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

func image(for number: Int, rating: Int) -> Image {
    if number > rating {
        return Image(systemName: "star")
    } else {
        return Image(systemName: "star.fill")
    }
}


func searchProject(projects: [Project], searchQuery: String) -> [Project] {
    let results = projects.filter { $0.name.lowercased().contains(searchQuery.lowercased())
    }

    return results
}

func searchTask(tasks: [Task], searchQuery: String) -> [Task] {
    let results = tasks.filter { $0.text.lowercased().contains(searchQuery.lowercased())
    }

    return results
}

//func find(value searchValue: Status, in array: [Status]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == searchValue {
//            return index
//        }
//    }
// 
//    return nil
//}
