//
//  ViewModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 31.01.2023.
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


func search(cards: [UserCard],status: String, searchQuery: String) -> [UserCard] {
    let results = someDict[status]!.filter { $0.fullName.lowercased().contains(searchQuery.lowercased())
    }

    return results
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
