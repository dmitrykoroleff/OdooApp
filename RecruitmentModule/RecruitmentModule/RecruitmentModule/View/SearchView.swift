//
//  SearchView.swift
//  CRM
//
//  Created by Dmitry Korolev on 14/3/2023.
//

import SwiftUI

struct SearchView: View {
    var taskCards: [TaskCard]
    @Binding var searchQuery: String
    @State var off: CGFloat = 0
    @State var bott = false
    @ObservedObject var shared = LogicR()
    var currentIndex: Int
    var element: Status
    
    var body: some View {

       NavigationView {
           if currentIndex < statusesRecr.count {
               ForEach(0..<shared.getCountStatus(status: statusesRecr[currentIndex].name), id: \.self) { user in
                   NavigationLink(destination: UserView(user: testUser, name: shared.names, job: shared.job, phone: shared.phone, department: shared.department, recruiter: shared.recruiter, hireDate: shared.hireDate, eSalary: shared.eSalary, pSalary: shared.pSalary, description: shared.descrip, appreciation: shared.appreciation, deadline: shared.deadline, summary: shared.activeSummary, index: shared.stageId[statusesRecr[currentIndex].name]?[user] ?? 0, shared: shared)) {
                       UserTestCard(index: shared.stageId[statusesRecr[currentIndex].name]?[user] ?? 0, array: shared.names, appreciation: shared.appreciation, shared: LogicR(), curruntOffset: $off, showBottomBar: $bott, statusImage: element.image).environmentObject(LogicR())
                   }
                   .foregroundColor(.black)
                   
               }
               .padding(.top, 5)
           }
        }
    }
}
//
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView(taskCards: TaskCard.sampleWebsiteRequest, searchQuery: .constant(""))
//    }
//}
