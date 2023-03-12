//
//  AuthenticatedView.swift
//  AuthHSE
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI
//import ChooseModule
import ChooseModules

struct AuthenticatedView: View {
    @ObservedObject private var model: AuthenticatedViewModel
    
    init(model: AuthenticatedViewModel) {
        self.model = model
    }
    
    var body: some View {
        
        TabView {
            // MARK: insert here choose module
//            ChooseModule.ChooseModuleView()
            ChooseModules.ChooseModuleView()
                .tabItem {
                    Image(systemName: "person")
                    Text("module")
                }
            //MARK: remove dev
            UserView(logOut: self.model.startLogout)
                .tabItem {
                    Image(systemName: "person")
                    Text("dev logout")
                }
        }
    }
}
