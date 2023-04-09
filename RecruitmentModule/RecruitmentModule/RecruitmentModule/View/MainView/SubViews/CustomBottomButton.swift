//
//  CustomBottomButton.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 02.02.2023.
//

import SwiftUI

struct CustomBottomButton: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    var body: some View {
        HStack {
            VStack {
                ForEach(0..<2) {_ in
                    Rectangle()
                        .frame(width: 16.5, height: 16.5)
                        .cornerRadius(3)
                        .foregroundColor(Color("MainColor", bundle: bundle))
                }
            }
            VStack {
                Rectangle()
                    .frame(width: 16.5, height: 16.5)
                    .cornerRadius(3)
                    .foregroundColor(Color("MainColor", bundle: bundle))
                    .rotationEffect(.degrees(45))
                Rectangle()
                    .frame(width: 16.5, height: 16.5)
                    .cornerRadius(3)
                    .foregroundColor(Color("MainColor", bundle: bundle))
            }
        }
        .background(
            Rectangle()
                .frame(width: 55, height: 55)
                .cornerRadius(8)
                .foregroundColor(.white)
                .shadow(radius: 4)
        )
    }
}

struct CustomBottomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomButton()
    }
}
