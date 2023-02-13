//
//  CookieFile.swift
//  AuthHSE
//
//  Created by Данила on 29.01.2023.
//

import Foundation
import SwiftUI



class CookieFile: ObservableObject {
    
    @AppStorage("auth") var authenticated = false {
        willSet { objectWillChange.send() }
    }
    
    @Published var isPresent: Bool = false
    @Published var goodAuth: Bool = false
    @Published var sessionID: String = ""
    func setSessionID(sid: String) {
        if self.sessionID.isEmpty {
            DispatchQueue.main.async {
                self.sessionID = sid
                self.goodAuth = true
                self.authenticated.toggle()
            }
        }
    }
    
    func show() {
        isPresent = true
    }
    func dismiss() {
        DispatchQueue.main.async {
            self.isPresent = false
        }
    }
    
    func logOut() {
        self.authenticated.toggle()
    }
    
}


