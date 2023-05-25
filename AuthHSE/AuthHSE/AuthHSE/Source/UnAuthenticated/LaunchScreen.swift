//
//  LaunchScreen.swift
//  AuthHSE
//
//  Created by Nikita Rybakovskiy on 25.05.2023.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
                    Color("MainColor")
                    
                    Image("mainLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                }
        .ignoresSafeArea(.all)

    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
