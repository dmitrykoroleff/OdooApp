//
//  ModelProfile.swift
//  Profile
//
//  Created by Данила on 24.05.2023.
//

import Foundation


class ModelProfile {
    func getInitials(str: String) -> String {
        let separatedNames = str.components(separatedBy: " ")
        var initials = ""

        if let firstName = separatedNames.first, let lastName = separatedNames.dropFirst().first {
            if let firstInitial = firstName.first, let lastInitial = lastName.first {
                initials = "\(firstInitial)\(lastInitial)"
            }
        }
        return initials
    }
}
