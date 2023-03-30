//
//  CustomProgressBarVIew.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 01.02.2023.
//

import SwiftUI

struct CustomProgressBarView: View {
    @State private var value: CGFloat = 10.0
    @State private var inputState: String = ""
    @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [.red, .green, .blue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    var body: some View {
        let customStyle = CustomProgressStyle()
        
        ProgressView(value: value/100)
            .padding(.vertical)
            .progressViewStyle(customStyle)
            .frame(width: 400, height: 10)
    }
}



struct CustomProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBarView()
    }
}





struct CustomProgressStyle: ProgressViewStyle {
    var cornerRadius: CGFloat = 5
    var height: CGFloat = 10
    var width: CGFloat = 287
    var animation: Animation = .easeInOut
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return HStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle()
                        .fill()
                        .frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                        .animation(animation)
                        .foregroundColor(Color(hex: 0xA24747, alpha: 1))
                }
                .frame(width: width)
            }
            .frame(height: height)
            .background(Color(hex: 0x8F8F8F, alpha: 0.2))
            .cornerRadius(cornerRadius)
            
//            .overlay(
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .stroke(lineWidth: 1)
//            )
            
            Text("\(Int(fractionCompleted*100))")
                .font(.system(size: 12))
                .fontWeight(.semibold)
            
        }
    }
}
