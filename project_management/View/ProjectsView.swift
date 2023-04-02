//
//  ProjectsView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct ProjectsView: View {
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
    
    @State var currentProject: Int = 0
    var body: some View {
        NavigationView {
            GeometryReader {_ in
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
                            
                           
                            NavigationLink(destination: ProfileView()) {
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
                        .onAppear{
                            createTestData()
                        }
                        .offset(y: searchIsActive ? -(height / 8) : 0)
                    }
                    .frame(width: width)
                    .blur(radius: projects.isEmpty ? 7 : 0)
                    if projects.isEmpty {
                        Label("No internet connection", systemImage: "icloud.slash")
                    }
                    
//                    if searchProject(projects: projects, searchQuery: searchQuery) != [] || searchIsActive && searchQuery.isEmpty{
////                        SearchView(projects: projects, searchQuery: $searchQuery)
////                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4.8) : height > 700 && height < 800 ? (height / 4.6) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
//                    } else if !searchQuery.isEmpty {
//                        NoResultsView(searchQuery: $searchQuery)
//                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4) : height > 700 && height < 800 ? (height / 4.3) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
//                    }
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.2)){
                            if statuses.count + 1 <= 5 {
                                if height > 500 && height < 700 {
                                    curruntOffset = -(height / 3)
                                } else if height < 800 && height > 700 {
                                    curruntOffset = -(height / 2.9)
                                } else if height > 800 && height < 900 {
                                    curruntOffset = -(height / 3.6)
                                } else {
                                    curruntOffset = -(height / 3.5)
                                }
                            } else {
                                if height > 500 && height < 700 {
                                    curruntOffset = -(height / 3)
                                } else if height < 800 && height > 700 {
                                    curruntOffset = -(height / 2.9)
                                } else if height > 800 && height < 900 {
                                    curruntOffset = -(height / 2.6)
                                } else {
                                    curruntOffset = -(height / 2.6)
                                }
                            }
                            showBottomBar = true
                            
                        }
                        
                    }, label: {
                        CustomAddButton()
                    })
                    .offset(x: width * 0.325, y: (height * 0.435))
                    
                    
                    
                }
            }

        }
        
    }
    
    func onChange(){
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if showBottomBar {
                if statuses.count + 1 <= 5 {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else if height < 800 && height > 700{
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else if height > 800 && height < 900 {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    } else {
                        curruntOffset = -(height / 3.6) + gestureOffset + lastOffset
                    }
                } else {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 3) + gestureOffset + lastOffset
                    } else if height < 800 && height > 700{
                        curruntOffset = -(height / 1.5) + gestureOffset + lastOffset
                    } else if height > 800 && height < 900 {
                        curruntOffset = -(height / 2.6) + gestureOffset + lastOffset
                    } else {
                        curruntOffset = -(height / 2.6) + gestureOffset + lastOffset
                    }
                }
            }
            
        }
    }


}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
