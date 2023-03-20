//
//  TaskCardView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct TaskCardView: View {
    @State var taskCard: TaskCard
    var statusImage: String
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                
                Text(taskCard.fullName)
                    .foregroundColor(Color(hex: 0x282F33))
                //.font(Font.custom("Inter", size: 16))
                    .font(.system(size: 18, weight: .semibold))
                
                
                
                
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
            VStack {
                ZStack {
                    Circle()
                        .stroke(.black, lineWidth: 1)
                        .frame(width: 30, height: 30)
                    Image(systemName: statusImage)
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

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(taskCard: TaskCard(fullName: "Arina Shoshina", taskStatus: "websiteRequest"), statusImage: statuses[0].image)
    }
}
