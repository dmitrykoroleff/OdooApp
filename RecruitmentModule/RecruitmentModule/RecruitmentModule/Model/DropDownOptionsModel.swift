//
//  DropDownOptionsModel.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 06.02.2023.
//

import Foundation

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
