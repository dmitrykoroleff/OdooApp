//
//  CustomAddButtonView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct CustomAddButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 55, height: 55)
                .foregroundColor(.white)
                .shadow(color: (Color("MainColor")), radius: 4)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 30, height: 30)
                .fontWeight(.light)
                .foregroundColor(Color("MainColor"))
        }
    }
}

struct CustomAddButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAddButton()
    }
}
