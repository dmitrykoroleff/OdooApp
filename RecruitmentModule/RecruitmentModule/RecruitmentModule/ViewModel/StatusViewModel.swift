//
//  SwiftUIView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

func image(for number: Int, rating: Int) -> Image {
    if number > rating {
        return Image(systemName: "star")
    } else {
        return Image(systemName: "star.fill")
    }
}

func search(tasks: [TaskCard], searchQuery: String) -> [TaskCard] {
    let results = tasks.filter{$0.fullName.lowercased().contains(searchQuery.lowercased())
    }

    return results
}

func find(value searchValue: Status, in array: [Status]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == searchValue {
            return index
        }
    }
 
    return nil
}
