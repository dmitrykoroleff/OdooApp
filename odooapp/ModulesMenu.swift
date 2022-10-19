//
//  ModulesMenu.swift
//  odooapp
//
//  Created by Melanie Kofman on 10.10.2022.
//

import SwiftUI

struct ModulesMenu: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        Text("choose modules!")
    }
}

struct ModulesMenu_Previews: PreviewProvider {
    static var previews: some View {
        ModulesMenu().environmentObject(ViewRouter())
    }
}
