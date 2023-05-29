//
//  ProjectsView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI
import Profile
struct ProjectsView: View {
    let bundle = Bundle(identifier: "ProjectsModule.ProjectsModule")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var currProjects = projects
    @Binding var project: Project
    @Binding var task: Task
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var curruntAddStatusOffset: CGFloat = 0
    @State var lastAddStatusOffset: CGFloat = 0
    @GestureState var gestureAddStatusOffset: CGFloat = 0
    @State var isActive = false
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var searchIsActive = false
    @State var showBottomBar = false
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var searchQuery = ""
    @State var showEditView = false
    @State var currentEditOffset: CGFloat = 0
    @State var lastEditOffset: CGFloat = 0
    @GestureState var gestureEditOffset: CGFloat = 0
    @State var currentProject: Int = 0
    @State var currentIndex: Int = 0
    @State var showAddTaskView = false
    @State var curruntAddTaskOffset: CGFloat = 0
    @State var showingAlert = true
    @State var ok: Bool = true
    var body: some View {
        NavigationView {
            GeometryReader {_ in
                ZStack {
                    
                    VStack(alignment: .center) {
                        Image("logo", bundle: bundle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 22)
                            .offset(y: height < 700 ? 24 : 0)
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text("Hello, ")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                
                                Text(verbatim: "awesomeuser@edu.hse.ru") // Хардкод
                                    .foregroundColor(Color("Headings"))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                            }
                            
                            Spacer()
                            
                           
                            NavigationLink(destination: Profile.ProfileView(name: "", email: "")) {
                                ZStack {
                                        
                                        Circle()
                                            .foregroundColor(Color("MainColor"))
                                            .frame(width: 40, height: 40)
                                        
                                        Text("A") // Хардкод
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                        
                                }
                            }
                            
                        }
                        .padding()
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack {
                            Text("Projects") //hardcode
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Headings"))
                            Spacer()
                        }
                        .padding(.horizontal)
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack(spacing: 15) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                            
                            TextField("Enter project's name...", text: $searchQuery, onEditingChanged: { search in
                                withAnimation {
                                    searchIsActive = search
                                }
                            })
                            
                        }
                        .frame(width: !searchIsActive ? width - 60 : width - 100, height: 50)
                        .background {
                            ZStack {
                                Color.white
                                HStack(spacing: 20) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke()
                                        .frame(width: !searchIsActive ? width - 60 : width - 100, height: 50)
                                    
                                    if searchIsActive {
                                        
                                        Button {
                                            withAnimation {
                                                searchQuery = ""
                                                searchIsActive = false
                                                UIApplication.shared.endEditing()
                                            }
                                            HapticManager.instance.impact(style: .soft)
                                            
                                        } label: {
                                            Image("delete", bundle: bundle)
                                                .resizable()
                                            
                                        }
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                        
                                    }
                                    
                                }
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 30)
                        .offset(y: searchIsActive ? height > 600 && height < 700 ? -(height / 6) : height > 700 && height < 800 ? -(height / 7) : height > 800 && height < 850 ? -(height / 7.3) : height > 850 && height < 900 ? -(height / 8) : -(height / 9) : 0)
                        
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack {
                                    if !projects.isEmpty {
                                        ForEach(Array(projects.enumerated()), id: \.offset) { offset, project in
                                            NavigationLink(destination: TasksView(project: project, task: $task)) {
                                                ProjectCardView(showEditView: $showEditView, currentEditOffset: $currentEditOffset, currentProject: $currentProject, currProjects: $currProjects, idx: offset, project: project)
                                            }
                                            .foregroundColor(.black)
                                        }
                                    }
                                }
                                .padding(.bottom, height / 3)
                            }
                            .onAppear {
                                self.currProjects = projects
                            }
                        .offset(y: searchIsActive ? -(height / 8) : 0)
                    }
                    .padding(.horizontal, 20)
                    .frame(width: width)
                    .blur(radius: projects.isEmpty ? 7 : 0)
                    if projects.isEmpty {
                        Label("No internet connection", systemImage: "icloud.slash")
                    }
                    
                    if searchProject(projects: projects, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty{
                        SearchView(projectss: projects, searchQuery: $searchQuery, task: $task)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4.8) : height > 700 && height < 800 ? (height / 4.6) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
                    } else if !searchQuery.isEmpty {
                        NoResultsView(searchQuery: $searchQuery)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4) : height > 700 && height < 800 ? (height / 4.3) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            if currentIndex != projects[project.idx!].statuses.count {
                                Button(action: {
                                    withAnimation(Animation.easeIn(duration: 0.2)){
                                        showBottomBar = true
                                        curruntOffset = -height

                                        
                                    }
                                    HapticManager.instance.impact(style: .light)
                                    
                                }, label: {
                                    CustomAddButton()
                                })
                                .offset(y: customAddButtonOffset(height: height)[1])
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 0.2)){
                                    self.mode.wrappedValue.dismiss()
                                    
                                }
                                HapticManager.instance.impact(style: .light)
                                
                            }, label: {
                                CustomBottomButton()
                            })
                            .offset(y: customBottomButtonOffset(height: height)[1])
                            
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    AddProjectView(currProjects: $currProjects, showBottomSheet: $showBottomBar, currentOffset: $curruntOffset)
                        .offset(y: height)
                        .offset(y: -curruntOffset > 0 ? -curruntOffset <= (height + 10) ? curruntOffset : -(height + 10) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showBottomBar = false
                                if -curruntOffset > height / 1.4 && -curruntOffset < maxHeight + height / 1.3 {
                                    curruntOffset = -maxHeight
                                }
                                else {
                                    curruntOffset = 0
                                }
                            }
                            lastOffset = curruntOffset
                        }))
                    
                    EditProjectView(showEditProjectView: $showEditView, currentEditOffset: $currentEditOffset, project: $project, currentProject: currentProject)
                        .offset(y: height)
                        .offset(y: -currentEditOffset > 0 ? -currentEditOffset <= (height + 10) ? currentEditOffset : -(height + 10) : 0)
                        .gesture(DragGesture().updating($gestureEditOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showEditView = false
                                if -currentEditOffset > height / 1.4 && -currentEditOffset < maxHeight + height / 1.3 {
                                    currentEditOffset = -maxHeight
                                }
                                else {
                                    currentEditOffset = 0
                                }
                            }
                            lastEditOffset = currentEditOffset
                        }))
                    
                }
            }

        }
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Warning!"), message: Text("Модуль находится в демо версии."), dismissButton: .default(Text("OK!")))
                }
        
    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if showBottomBar {
                curruntOffset = -height + gestureOffset + lastOffset
            }
            self.currentEditOffset = gestureEditOffset + lastEditOffset
            if showEditView {
                currentEditOffset = -height + gestureEditOffset + lastEditOffset
            }
            
            
        }
        
    }


}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView(project: .constant(projects[0]), task: .constant(projects[0].statuses[0].tasks[0]))
    }
}
