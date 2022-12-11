//
//  ContentView.swift
//  odooapp
//
//  Created by Melanie Kofman on 11.11.2022.
//

import SwiftUI
import AuthHSE

// MARK: remove available
// @available(iOS 15.0, *)
struct AppView: View {
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        AuthHSE.AuthView()
    }

}

// MARK: remove available
// @available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
