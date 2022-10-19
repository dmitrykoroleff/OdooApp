//
//  MainScreen.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Text("page1 pressed ")
        }
    }
    

}
struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
//        AuthView()
        MainScreen().environmentObject(ViewRouter())
    }
}


