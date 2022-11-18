//
//  LoginViewModel.swift
//  odooapp
//
//  Created by Dmitry Korolev on 05.11.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var server: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
}
