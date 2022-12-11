//
//  AuthenticatedView.swift
//  AuthHSE
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI

// MARK: remove available
// @available(iOS 15.0, *)
struct AuthenticatedView: View {
    @ObservedObject private var model: AuthenticatedViewModel

    init(model: AuthenticatedViewModel) {
        self.model = model
    }

    var body: some View {
        TabView {
            UserView(logOut: self.model.startLogout)
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
    }
}
