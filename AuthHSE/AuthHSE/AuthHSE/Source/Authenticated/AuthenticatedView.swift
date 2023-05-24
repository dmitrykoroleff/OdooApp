//
//  AuthenticatedView.swift
//  AuthHSE
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI
import ChooseModules

struct AuthenticatedView: View {
    @ObservedObject private var model: AuthenticatedViewModel
    
    init(model: AuthenticatedViewModel) {
        self.model = model
    }
    
    var body: some View {
//        TabView {
            // MARK: insert here choose module
        ChooseModules.ChooseModuleView(email: CookieFile().emailuser, name: CookieFile().nameUser)
                .tabItem {
                    Image(systemName: "person")
                    Text("module")
                }
            
//        }
    }
}
