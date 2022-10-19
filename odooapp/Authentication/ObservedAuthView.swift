//
//  ObservedAuthView.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI


extension AuthView {
    class Observed: ObservableObject {

        
//      сохранить логин при выходе из приложения
        @AppStorage("auth") var authenticated = false {
            willSet { objectWillChange.send() }
        }
        @AppStorage("user") var email = "email"
        
        init() {
            print("logged on: \(authenticated)")
            print("current user: \(email)")
        }
        
        func toggleAuthentication() {
            withAnimation {
                authenticated.toggle()
            }
        }
        
        @Published var user = User()
        
        func logIn() {
            print("call log in")
            toggleAuthentication()
        }
        
        func logOut() {
            print("call log out")
            toggleAuthentication()
        }
    }
}
