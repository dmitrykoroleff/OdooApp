//
//  Test.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 01.02.2023.
//

import SwiftUI

struct UserCardScrollView: View {
    var userCards: [UserCard]
    var width = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(userCards) { userCard in
                    NavigationLink(destination: EmptyView()) {
                        UserCardView(userCard: userCard, statusImage: statuses[0].image)
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct UserCardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardScrollView(userCards: userCards)
    }
}
