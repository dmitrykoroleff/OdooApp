//
//  SearchView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct SearchView: View {
    var projects: [Project]
    @Binding var searchQuery: String
    @State var showEditView = false
    @State var currentProject: Int = 0
    @State var currentEditOffset: CGFloat = 0
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(searchProject(projects: projects, searchQuery: searchQuery)) { project in
                NavigationLink(destination: TasksView(project: project)) {
                    ProjectCardView(showEditView: $showEditView, currentEditOffset: $currentEditOffset, currentProject: $currentProject, project: project)
                }
                .foregroundColor(.black)
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(projects: projects, searchQuery: .constant(""))
    }
}

