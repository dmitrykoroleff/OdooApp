//
//  GeneralInformationView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct GeneralInformationView: View {
    @State var task: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        VStack {

            Text("General Information")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor"))
            VStack(alignment: .leading) {
                HStack() {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(generalInformation, id: \.self) { generalInformation in
                            Text(generalInformation)
                        }
                    }
                    .frame(width: width/3)
                    Divider()
                    VStack(alignment: .leading, spacing: 10) {
                        
                        ForEach(generalInformation, id: \.self) {generalInformation in
                            if generalInformation == "Priority" {
                                HStack {
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star.fill")
                                    Image(systemName: "star")
                                        .foregroundColor(.black)
                                }
                                .foregroundColor(.yellow)
                            } else {
                                Text(task.generalInformation[generalInformation] ?? "")
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
            
           
            Spacer()
        }
    }
}

struct GeneralInformationView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInformationView(task: testTask)
    }
}
