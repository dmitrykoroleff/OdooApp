//
//  CustomBackButton.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 04.02.2023.
//

import SwiftUI

struct CustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                    Image("ic_back") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        
                    }
                }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
