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
    var body: some View {
        VStack {
//            VStack(spacing: 10) {
//                Image("logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 64, height: 22)
//                Spacer()
//                    .frame(height: height/80)
//                Text(user.name)
//                    .font(.system(size: 20, weight: .bold))
//                Text(user.email)
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//                    .underline()
//                Text(user.phone)
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//                Spacer()
//            }
//            .frame(height: height/6)
            Text("Application Summary")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor", bundle: bundle))
            Spacer()
                .frame(height: height/50)
            Text("As an employee of our company, you will collaborate with each department to create and deploy disruptive products. Come work at a growing company that offers great benefits with opportunities to moving forward and learn alongside accomplished leaders. We're seeking an experienced and outstanding member of staff.") // hardcode
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: width * 0.78)
            Spacer()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(user: testUser)
    }
}
