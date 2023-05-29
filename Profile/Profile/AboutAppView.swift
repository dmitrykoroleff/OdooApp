//
//  AboutAppView.swift
//  Profile
//
//  Created by Dmitry Korolev on 7/4/2023.
//

import SwiftUI

struct AboutAppView: View {
//    let bundle = Bundle(identifier: "Profile.Profile")
    let bundle = Bundle(identifier: "odoo.miem.ios.Profile")
//    let bundle =  Bundle.main.bundlePath
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Some information about the app")
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                .font(.system(size: 16, weight: .bold))
        })
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Image("logo", bundle: bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 22)
            }
        }
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}
