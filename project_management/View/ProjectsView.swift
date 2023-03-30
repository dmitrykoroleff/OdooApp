//
//  ProjectsView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct ProjectsView: View {
    
    @State var isActive = false
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var searchIsActive = false
    @State var showBottomSheet = false
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var searchQuery = ""
    @State var showEditView = false
    
    @State var currentProject: Int = 0
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center) {
                    Image("logo")
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
                            
                            Text(verbatim: "aashoshina@miem.hse.ru") // Хардкод
                                .foregroundColor(Color("Headings"))
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
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
                                        
                                    } label: {
                                        Image("delete")
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
                    
                    VStack {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(projects) { project in
                                NavigationLink(destination: TasksView(project: project)) {
                                    ProjectCardView(showEditView: $showEditView, currentProject: $currentProject, project: project)
                                }
                                .foregroundColor(.black)
                            }
                        }
                        
                    }
                    .offset(y: searchIsActive ? -(height / 8) : 0)
                }
                .frame(width: width)
                .blur(radius: projects.isEmpty ? 7 : 0)
                if projects.isEmpty {
                    Label("No internet connection", systemImage: "icloud.slash")
                }
                
                if searchProject(projects: projects, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty{
                    SearchView(projects: projects, searchQuery: $searchQuery)
                        .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4.8) : height > 700 && height < 800 ? (height / 4.6) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
                } else if !searchQuery.isEmpty {
                    NoResultsView(searchQuery: $searchQuery)
                        .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4) : height > 700 && height < 800 ? (height / 4.3) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
                }
                
                //if ...
                if !showBottomSheet && !searchIsActive {
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.2)){
                            showBottomSheet.toggle()
                            
                        }
                        
                    }, label: {
                        CustomAddButton()
                    })
                    .offset(x: width * 0.325, y: (height * 0.435))
                } else if showBottomSheet {
                    AddProjectView()
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: offSet)
                    .offset(y: height*0.05)
                    //                .offset(y: showBottomSheet ? 0: height)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                }
                if showEditView {
                    EditProjectView()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: offSet)
                        .offset(y: height*0.05)
                        //                .offset(y: showBottomSheet ? 0: height)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                }
            }

        }
        
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.height > 0 {
            offSet = value.translation.height
        }
    }

    func onEnded(value: DragGesture.Value) {
        if value.translation.height > 0 {
            withAnimation(Animation.easeIn(duration: 0.2)) {
                offSet = 0
                showBottomSheet.toggle()
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
