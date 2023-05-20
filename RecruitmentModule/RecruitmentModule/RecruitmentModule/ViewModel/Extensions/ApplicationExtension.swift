//
//  ApplicationExtension.swift
//  CRM
//
//  Created by Dmitry Korolev on 28/3/2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
