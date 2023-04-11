//
//  SummaryView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 04.02.2023.
//

import SwiftUI

struct SummaryView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var user: User
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var description: [Int: String] = [:]
    var index: Int
    var body: some View {
        VStack {
            Text("Application Summary")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor", bundle: bundle))
            Spacer()
                .frame(height: height/50)
            Text("\(description[index]!)") // hardcode
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: width * 0.78)
            Spacer()
        }
    }
}

//struct SummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryView(user: testUser)
//    }
//}
