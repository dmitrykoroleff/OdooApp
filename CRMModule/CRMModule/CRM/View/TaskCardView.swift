//
//  TaskCardView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct TaskCardView: View {
    @State var taskCard: TaskCard
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
                    
                    Text(taskCard.fullName)
                        .foregroundColor(Color(hex: 0x282F33))
                    //.font(Font.custom("Inter", size: 16))
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.horizontal)
                    
                    
                    
                    
                    Spacer()
                    HStack {
                        ForEach(1..<4, id: \.self) { number in
                            image(for: number, rating: taskCard.rating)
                                .foregroundColor(number > taskCard.rating ? Color.black : Color.yellow)
                                .onTapGesture {
                                    if taskCard.rating == number {
                                        taskCard.rating = 0
                                    } else {
                                        taskCard.rating = number
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
                            if statuses.count + 1 <= 5 {
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
        TaskCardView(taskCard: TaskCard(fullName: "Arina Shoshina", taskStatus: "websiteRequest"), curruntOffset: .constant(0), showBottomBar: .constant(false), statusImage: statuses[0].image)
    }
}
