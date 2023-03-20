//
//  SwiftUIView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

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

func search(tasks: [TaskCard], searchQuery: String, currentStatus: String) -> [TaskCard] {
    let results = someDict[currentStatus]!.filter { $0.fullName.lowercased().contains(searchQuery.lowercased())
    }

    return results
}
