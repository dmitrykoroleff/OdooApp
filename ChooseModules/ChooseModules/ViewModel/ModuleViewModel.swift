//
//  ModuleViewModel.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI

func generateColorFor(text: String, colors: [Color]) -> Int {
    let num = Int(((text.first?.asciiValue ?? Character("A").asciiValue)!)) % colors.count
    return num
}


func search(modules: [Modules], searchQuery: String) -> [Modules] {
    let results = modules.filter { $0.name.lowercased().contains(searchQuery.lowercased())
    }

    return results
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
