//
//  SearchTaskView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct SearchTaskView: View {
    var projectTasks: [Task]
    @Binding var searchQuery: String
    @State var showEditView = false
    @State var currentTask: Int = 0
    @State var currentStatus: Status
    @State var currentEditOffset: CGFloat = 0
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                if searchQuery.isEmpty {
                    ForEach(projectTasks) { task in
                        NavigationLink(
                            destination:
                                TaskManagmentView()) {
                                    TaskCardView(task: task, currTasks: $currentStatus.tasks, showEditView: $showEditView, currentTask: currentTask, currentStatus: currentStatus, currentEditOffset: $currentEditOffset)
                                }
                                .foregroundColor(.black)
                    }
                } else {
                    ForEach(searchTask(tasks: projectTasks, searchQuery: searchQuery)) { task in
                        NavigationLink(
                            destination:
                                TaskManagmentView()) {
                                    TaskCardView(task: task, currTasks: $currentStatus.tasks, showEditView: $showEditView, currentTask: currentTask, currentStatus: currentStatus, currentEditOffset: $currentEditOffset)
                                }
                                .foregroundColor(.black)
                    }
                }
            }

        }
    }
}

struct SearchTaskView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTaskView(projectTasks: projects[0].statuses[0].tasks, searchQuery: .constant(""), currentStatus: statuses[0])
    }
}
