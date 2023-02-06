//
//  GeneralInfoView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 03.02.2023.
//

import SwiftUI

struct JobView: View {
    @State var user: User
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        
            VStack {
//                VStack(spacing: 10) {
//                    Image("logo")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 64, height: 22)
//                    Spacer()
//                        .frame(height: height/80)
//                    Text(user.name)
//                        .font(.system(size: 20, weight: .bold))
//                    Text(user.email)
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                        .underline()
//                    Text(user.phone)
//                        .font(.system(size: 14))
//                        .foregroundColor(.gray)
//                    Spacer()
//                }
//                .frame(height: height/6)
                Text("Job")
                    .font(.system(size: 14))
                    .foregroundColor(Color("MainColor"))
                VStack(alignment: .leading) {
                    HStack() {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(jobs, id: \.self) { job in
                                Text(job)
                            }
                        }
                        .frame(width: width/3)
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            
                            ForEach(jobs, id: \.self) {job in
                                if job == "Appecietion" {
                                    HStack {
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star.fill")
                                        Image(systemName: "star")
                                            .foregroundColor(.black)
                                    }
                                    .foregroundColor(.yellow)
                                } else {
                                    Text(user.jobs[job]!)
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(width: width - width/8, height: height/3)
                }
                .font(.system(size: 12))
                
                Spacer()
                    .frame(height: height/20)
                
                Text("Contract")
                    .font(.system(size: 14))
                    .foregroundColor(Color("MainColor"))
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Expected Salary")
                            Text("Proposed Salary")
                            
                        }
                        .frame(width: width/3)
                        Divider()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("0.00")
                            Text("0.00")
                        }
                        Spacer()
                    }
                    .frame(width: width - width/8,height: height/10)
                }
                .font(.system(size: 12))
                Spacer()
            }
        
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView(user: testUser)
    }
}
