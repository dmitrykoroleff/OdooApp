//
//  GeneralInformationView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct GeneralInformationView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @State var task: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var index: Int = 0
    var partnerName: [Int: String] = [:]
    var email: [Int: String] = [:]
    var phone: [Int: String] = [:]
    var salesPerson: [Int: String] = [:]
    var salesTeam: [Int: String] = [:]
    var dateClose: [Int: String] = [:]
    var body: some View {
        VStack {

            Text("General Information")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor", bundle: bundle))
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
                            } else if generalInformation == "Custumer" {
                                Text(partnerName[index] ?? "")
                            } else if generalInformation == "Email" {
                                Text(email[index] ?? "")
                            } else if generalInformation == "Phone" {
                                Text(phone[index] ?? "")
                            } else if generalInformation == "Sales person" {
                                Text(salesPerson[index] ?? "")
                            } else if generalInformation == "Sales team" {
                                Text(salesTeam[index] ?? "")
                            } else if generalInformation == "Expected closing" {
                                Text(dateClose[index] ?? "")
                            } else { Text(" ") }
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
