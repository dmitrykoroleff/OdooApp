//
//  odooappApp.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI

@main
struct odooappApp: App {
    @StateObject var viewRouter = ViewRouter()
    var body: some Scene {
        WindowGroup {
//            AuthView()
            AuthView()
                .onOpenURL { url in
                                    print(url.absoluteString)
                                }
        }
    }
}
