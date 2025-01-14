//
//  UserTestCard.swift
//  RecruitmentModule
//
//  Created by Данила on 09.04.2023.
//

import SwiftUI

struct UserTestCard: View {
    var index: Int
    var array: [Int: String]
    var appreciation: [Int: String]
    @ObservedObject var shared: LogicR
    @Binding var curruntOffset: CGFloat
    @Binding var showBottomBar: Bool
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var statusImage: String
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(array[index]!)")
                .foregroundColor(Color(hex: 0x282F33))
                //.font(Font.custom("Inter", size: 16))
                .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                if appreciation[index]! == "1" {
                    HStack {
                        Image(systemName: "star.fill")
                        Image(systemName: "star")
                        Image(systemName: "star")
//                                                .foregroundColor(.black)
                    }.foregroundColor(.yellow)
                } else if appreciation[index]! == "2" {
                    HStack {
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star")
//                                                .foregroundColor(.black)
                    }.foregroundColor(.yellow)
                } else if appreciation[index]! == "3" {
                    HStack {
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
//                                                .foregroundColor(.black)
                    }.foregroundColor(.yellow)
                }
                else {
                    HStack {
                        Image(systemName: "star")
                        Image(systemName: "star")
                        Image(systemName: "star")
//                                                .foregroundColor(.black)
                    }.foregroundColor(.yellow)
                }
                Spacer()
            }
            .frame(height: 60)
            
            Spacer()
            VStack {
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        withAnimation(Animation.easeIn(duration: 0.2)) {
                            if statusesRecr.count + 1 <= 5 {
                                if height > 500 && height < 700 {
                                    curruntOffset = -(height / 3)
                                } else if height < 800 && height > 700 {
                                    curruntOffset = -(height / 2.9)
                                } else if height > 800 && height < 900 {
                                    curruntOffset = -(height / 3.6)
                                } else {
                                    curruntOffset = -(height / 3.5)
                                }
                            } else {
                                if height > 500 && height < 700 {
                                    curruntOffset = -(height / 3)
                                } else if height < 800 && height > 700 {
                                    curruntOffset = -(height / 2.9)
                                } else if height > 800 && height < 900 {
                                    curruntOffset = -(height / 2.6)
                                } else {
                                    curruntOffset = -(height / 2.6)
                                }
                            }
                            showBottomBar = true
                        }
                    }
                } label: {
                    VStack {
                        ZStack {
                            Circle()
                                .stroke(.black, lineWidth: 1)
                                .frame(width: 30, height: 30)
                            Image(systemName: statusImage)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                .frame(width: 319, height: 90)
                .opacity(0.8)
        )
        .frame(width: 289, height: 90)
        .padding([.leading, .trailing])
    }
}

//struct UserTestCard_Previews: PreviewProvider {
//    static var previews: some View {
//        UserTestCard(shared: LogicR())
//    }
//}
