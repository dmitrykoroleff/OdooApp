//
//  CustomAddButtonView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct CustomAddButton: View {
    let bundle = Bundle(identifier: "ProjectsModule.ProjectsModule")
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 55, height: 55)
                .foregroundColor(.white)
                .shadow(color: (Color("MainColor")), radius: 4)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("MainColor"))
        }
    }
}

struct CustomAddButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAddButton()
    }
}
