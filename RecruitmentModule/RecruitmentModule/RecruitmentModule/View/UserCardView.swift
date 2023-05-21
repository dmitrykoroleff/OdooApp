//
//  TaskCardView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct UserCardView: View {
    @State var userCard: TaskCard
    @Binding var curruntOffset: CGFloat
    @Binding var showBottomBar: Bool
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var statusImage: String
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                .frame(width: width - 60, height: 90)
                .opacity(0.8)
            
            HStack {
                VStack(alignment: .center) {
                    
                    Text(userCard.fullName)
                        .foregroundColor(Color(hex: 0x282F33))
                    //.font(Font.custom("Inter", size: 16))
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.horizontal)
                    
                    
                    
                    
                    Spacer()
                    HStack {
                        ForEach(1..<4, id: \.self) { number in
                            image(for: number, rating: userCard.rating)
                                .foregroundColor(number > userCard.rating ? Color.black : Color.yellow)
                                .onTapGesture {
                                    if userCard.rating == number {
                                        userCard.rating = 0
                                    } else {
                                        userCard.rating = number
                                    }
                                }
                                .animation(.easeIn(duration: 0.15))
                        }
                        Image(systemName: "clock")
                    }
                    Spacer()
                }
                .frame(height: 60)
                
                Spacer()
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
            .frame(width: width - 60, height: 90)
        }
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardView(userCard: TaskCard(fullName: "Arina Shoshina", taskStatus: "websiteRequest"), curruntOffset: .constant(0), showBottomBar: .constant(false), statusImage: statusesRecr[0].image)
    }
}
