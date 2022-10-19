//
//  ContentView.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI

struct UserView: View {
    var logOut: ()-> Void
    init(logOut: @escaping ()-> Void) {
        self.logOut = logOut
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                VStack {
                    Button("Выход", action: logOut)
                }
            }
            .navigationTitle("Профиль")
        }
    }

    
    
}

struct ModulesView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                VStack{
                    Button("Page1", action: {print("one")})
                        .buttonStyle(.bordered)
                    Button("Page2", action: {print("two")})
                        .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Модули")
        }
    }
}

struct AuthView: View {
    
    @StateObject private var observed = Observed()
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        if observed.authenticated {
//            VStack {
//                Text("Вошли как \(observed.email)")
//
//
//            }
            
            TabView {
                UserView(logOut: observed.logOut)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Профиль")
                    }
                ModulesView()
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("Меню")
                    }
            }
            
            
            
        } else {
            VStack {
                Button("Войти через ХСЕ", action: observed.logIn)
                    .padding()
                    .buttonStyle(.bordered)
            }
            .transition(.offset(x:0, y:850))
        }
            
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
