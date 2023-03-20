//
//  DropDownOptionsModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import Foundation

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}
