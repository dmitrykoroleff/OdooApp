//
//  PersonCard.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 31.01.2023.
//

import SwiftUI

struct UserCardView: View {
    
    @State var userCard: UserCard
    var statusImage: String
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                
                Text(userCard.fullName)
                    .foregroundColor(Color(hex: 0x282F33))
                //.font(Font.custom("Inter", size: 16))
                    .font(.system(size: 18, weight: .semibold))
                
                
                
                
                Spacer()
                HStack {
                    ForEach(1..<4, id: \.self) { number in
                        image(for: number, rating: userCard.rating)
                            .foregroundColor(number > userCard.rating ? Color.black : Color.yellow)
//                            .fontWeight(.light)
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

struct PersonCard_Previews: PreviewProvider {
    static var previews: some View {
        UserCardView(userCard: UserCard(fullName: "Arina Shoshina", userStatus: "websiteRequest"), statusImage: statuses[0].image)
    }
}
