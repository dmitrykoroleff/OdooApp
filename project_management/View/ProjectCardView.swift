//
//  ProjectCardView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct ProjectCardView: View {
    @Binding var showEditView: Bool
    @State var favorite = true
    
    @Binding var currentEditOffset: CGFloat
    @Binding var currentProject: Int
    
    var project: Project
    var colors = [Color.red, Color.purple]
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            HStack {
//                Rectangle()
//                    .frame(width: 5)
                VStack(alignment: .leading) {
                    Text(project.name)
                        .font(.headline)
                    if project.company != "" {
                        Label(project.company, systemImage: "person")
                            .font(.subheadline)
                    }
                    if project.date != nil {
                        Label(project.date!, systemImage: "clock")
                            .font(.subheadline)
                    }
                    HStack {
                        ForEach(project.type, id: \.self) {type in
                            Circle()
                                .fill(type == "External" ? .red: .purple)
                                .frame(width: 8, height: 8)
                            Text(type)
                                .font(.system(size: 14))
                        }
                    }
                    .offset(y: -6)
                }
                Spacer()
                VStack {
                    Menu {
                        
                        Button("Cancel", role: .destructive) {
                            
                        }
                        
                        Button {
                            currentProject = project.idx!
                            showEditView = true
                            currentEditOffset = -height
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button {
                            currentProject = project.idx!
                            projects.remove(at: currentProject)
                            reindex(source: &projects, count: projects.count)
                        } label: {
                            Label("Delete", systemImage: "delete.left")
                        }
                        
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .imageScale(.large)
                        
                    }
                    .frame(width: 20, height: 20)
                    .foregroundColor(.primary)
                    .offset(y: -20)
                  
                    
                    
                    Button(action: {
                        withAnimation(Animation.linear(duration: 0.2)) {
                            favorite.toggle()
                        }
                    }, label: {
                        Image(systemName: favorite ? "star.fill": "star")
                            .foregroundColor(favorite ? .yellow: .black)
                })
                }
            }
            HStack {
//                Text("\(countTasks(tasks: project.statuses.tasks)) Tasks")
//                    .foregroundColor(Color("MainColor"))
                Image(systemName: "clock")
                    .opacity(0.4)
                Spacer()
                Circle()
                    .fill(.orange)
                    .frame(width: 15)
                    .opacity(0.7)
                    .background(content: {
                        Circle()
                            .stroke()
                            .foregroundColor(.orange)
                    })
                Image("admin")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
            }
        }
        .padding()
        .frame(width: width * 0.8, height: 140)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
            
        )
        .padding(1)
    }
    
    func countTasks(tasks: [String: [Task]]) -> Int {
        var res = 0
        for key in tasks.keys {
            res += tasks[key]!.count
        }
        return res
    }
    
    func rearrangeIdx() {
        for i in 0..<projects.count {
            projects[i].idx = i
        }
    }
    
}

struct ProjectCardView_Previews: PreviewProvider {
    @State static var project = projects[1]
    @State static var show = false
    @State static var curr = 0
//    @State static var currentProject = 0
    static var previews: some View {
        ProjectCardView(showEditView: $show, currentEditOffset: .constant(0), currentProject: $curr, project: project)
    }
}
