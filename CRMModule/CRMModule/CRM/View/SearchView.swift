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
    var body: some View {
        
       NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                    ForEach(searchQuery.isEmpty ? getAllTasks() ?? [] : search(tasks: getAllTasks(), searchQuery: searchQuery)) { task in
                        NavigationLink(destination: TaskView(task: testTask, shared: CRMLogic())) {
                            TaskCardView(taskCard: task,curruntOffset: .constant(0), showBottomBar: .constant(false), statusImage: statuses[0].image)
                        }
                        .foregroundColor(.black)
                    }
                
                .padding(.top, 5)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(taskCards: TaskCard.sampleWebsiteRequest, searchQuery: .constant(""))
    }
}
