//
//  UserCardList.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 31.01.2023.
//

import SwiftUI

struct UserCardList: View {
    var userCards: [UserCard]
    var width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            List(userCards) { userCard in
                
                ZStack {
                    NavigationLink(destination: {
                        EmptyView()
                    }, label: {
                    })
                    .opacity(0)
                    .buttonStyle(PlainButtonStyle())
                    
//                    UserCardView(index: 0, userCard: userCard, shared: LogicR(), statusImage: statuses[0].image).environmentObject(LogicR())
                    UserCardView(userCard: userCard, shared: LogicR(), statusImage: statuses[0].image).environmentObject(LogicR())
                }
            }
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct UserCardList_Previews: PreviewProvider {
    static var previews: some View {
        UserCardList(userCards: userCards)
    }
}


