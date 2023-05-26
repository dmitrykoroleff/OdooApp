//
//  SearchView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct SearchView: View {
    var projectss: [Project]
    @State var currProjects = projects
    @Binding var searchQuery: String
    @Binding var task: Task
    @State var showEditView = false
    @State var currentProject: Int = 0
    @State var currentEditOffset: CGFloat = 0
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array(searchProject(projects: projects, searchQuery: searchQuery).enumerated()), id: \.offset) { offset, project in
                NavigationLink(destination: TasksView(project: project, task: $task)) {
                    ProjectCardView(showEditView: $showEditView, currentEditOffset: $currentEditOffset, currentProject: $currentProject, currProjects: $currProjects, idx: offset, project: project)
                }
                .foregroundColor(.black)
            }
            .onAppear {
                self.currProjects = projects
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(projectss: projects, searchQuery: .constant(""), task: .constant(projects[0].statuses[0].tasks[0]))
    }
}

