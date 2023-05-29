//
//  SummaryView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct SummaryView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @State var task: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var index: Int = 0
    var description: [Int: String] = [:]
    var shared: CRMLogic
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {

            Text("Internal Notes")
                .font(.system(size: 14))
                .foregroundColor(Color("MainColor", bundle: bundle))
            Spacer()
                .frame(height: height/50)
            Text("\(shared.goodDecription(inputString: description[index] ?? " "))") // hardcode
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: width * 0.78)
        }
    }
}

//struct SummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryView(task: testTask)
//    }
//}
