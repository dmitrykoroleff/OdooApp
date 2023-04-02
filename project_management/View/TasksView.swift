//
//  TasksView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct TasksView: View {
    var project: Project
    @State var isActive = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var showBottomBar = false
    @State var showAddTaskView = false
    @State var searchIsActive = false
    @State var showAdditionalStatuses = false
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var offSet: CGFloat = 0
    @State var searchQuery = ""
    @State var currentStatus: Status = statuses[0]
    @State var showEditView = false
    @State var curruntOffset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var curruntAddStatusOffset: CGFloat = 0
    @State var lastAddStatusOffset: CGFloat = 0
    @GestureState var gestureAddStatusOffset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    @State var currentTask: Int = 0
    var body: some View {
        NavigationView {
            GeometryReader {_ in
                ZStack(alignment: .bottomTrailing) {
                    VStack(alignment: .center) {
                        
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
                            Text("\(statuses[currentIndex].name)") //hardcode
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
                            
                            TextField("Enter student name...", text: $searchQuery, onEditingChanged: { search in
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
                        HStack {
                            ForEach(Array(project.statuses.enumerated()), id: \.offset) { offset, element in
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(offset == currentIndex ? Color.black : Color.gray)

                            }
                        }
                        .padding(.bottom)
                        
                        TabView(selection: $currentIndex) {
                            ForEach(Array(project.statuses.enumerated()), id: \.offset) { offset, element in
                                ScrollView(.vertical, showsIndicators: false) {
                                    if projects[project.idx!].statuses[currentIndex].tasks.isEmpty {
                                        Text("Задач в данном статусе нет")
                                            .font(.body)
                                            .fontWeight(.light)
                                            .foregroundColor(Color.gray)
                                    } else {
                                        ForEach(projects[project.idx!].statuses[currentIndex].tasks) { task in
                                            NavigationLink(
                                                destination:
                                                    TaskManagmentView(), isActive: $isActive) {
                                                        TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
                                                    }
                                                    .foregroundColor(.black)
                                        }
                                    }
                                }
                                
                            }
                            
//                            ScrollView(.vertical, showsIndicators: false) {
//                                if projects[project.idx!].statuses[1].tasks.isEmpty {
//                                    Text("Задач в данном статусе нет")
//                                        .font(.body)
//                                        .fontWeight(.light)
//                                        .foregroundColor(Color.gray)
//                                } else {
//                                    ForEach(projects[project.idx!].statuses[1].tasks) { task in
//                                        NavigationLink(
//                                            destination:
//                                                TaskManagmentView(), isActive: $isActive) {
//                                                    TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
//                                                }
//                                                .foregroundColor(.black)
//                                    }
//                                }
//                            }
//                            .tag(1)
//
//                            ScrollView(.vertical, showsIndicators: false) {
//                                if projects[project.idx!].statuses[2].tasks.isEmpty {
//                                    Text("Задач в данном статусе нет")
//                                        .font(.body)
//                                        .fontWeight(.light)
//                                        .foregroundColor(Color.gray)
//                                } else {
//                                    ForEach(projects[project.idx!].statuses[2].tasks) { task in
//                                        NavigationLink(
//                                            destination:
//                                                TaskManagmentView(), isActive: $isActive) {
//                                                    TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
//                                                }
//                                                .foregroundColor(.black)
//                                    }
//                                }
//                            }
//                            .tag(2)
//
//                            ScrollView(.vertical, showsIndicators: false) {
//                                if projects[project.idx!].statuses[3].tasks.isEmpty {
//                                    Text("Задач в данном статусе нет")
//                                        .font(.body)
//                                        .fontWeight(.light)
//                                        .foregroundColor(Color.gray)
//                                } else {
//                                    ForEach(projects[project.idx!].statuses[3].tasks) { task in
//                                        NavigationLink(
//                                            destination:
//                                                TaskManagmentView(), isActive: $isActive) {
//                                                    TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
//                                                }
//                                                .foregroundColor(.black)
//                                    }
//                                }
//                            }
//                            .tag(3)
                            
                            Text("Add new")
                                .tag(project.statuses.count)
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        
//                        TabView {
//
//                            ForEach(projects[project.idx!].statuses.indices, id: \.self) { index in
//                                ScrollView(.vertical, showsIndicators: false) {
//                                    if projects[project.idx!].statuses[index].tasks.isEmpty {
//                                        Text("Задач в данном статусе нет")
//                                            .font(.body)
//                                            .fontWeight(.light)
//                                            .foregroundColor(Color.gray)
//                                    } else {
//                                        ForEach(projects[project.idx!].statuses[index].tasks) { task in
//                                            NavigationLink(
//                                                destination:
//                                                    TaskManagmentView(), isActive: $isActive) {
//                                                        TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
//                                                    }
//                                                    .foregroundColor(.black)
//                                        }
//                                    }
//                                    }
//                                .edgesIgnoringSafeArea(.bottom)
//                            }
//
//                        }
                        .tabViewStyle(.page)
                        .offset(y: searchIsActive ? -(height / 8) : 0)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                    .frame(width: width)
                    
                    if searchTask(tasks: getAllTasks(project: project), searchQuery: searchQuery) != [] || (searchIsActive && searchQuery.isEmpty){
                        SearchTaskView(projectTasks: getAllTasks(project: project), searchQuery: $searchQuery, currentStatus: currentStatus)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4.8) : height > 700 && height < 800 ? (height / 4.4) : height > 800 && height < 900 ? (height / 7) : (height / 5) : height)
                        
                    } else if !searchQuery.isEmpty {
                        NoResultsView(searchQuery: $searchQuery)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 4) : height > 700 && height < 800 ? (height / 4.3) : height > 800 && height < 900 ? (height / 5.7) : (height / 5) : height)
                    }
                    
                        
                        HStack {
                            
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 0.2)){
                                    showAddTaskView.toggle()
                                    
                                }
                                
                            }, label: {
                                CustomAddButton()
                            })
                            .offset(x: -(width/1.5), y: (height / 5000))
                            
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
                                CustomBottomButton()
                            })
                            .offset(x: -(width / 8), y: (-height/5))
                            
                        }
                    
                    
                    VStack {
                        BottomSheetView(curruntAddStatusOffset: $curruntAddStatusOffset, currentStatus: $currentStatus, index: $currentIndex, showAdditionalStatuses: $showAdditionalStatuses)
                            .offset(y: height)
                            .offset(y: statuses.count + 1 <= 5 ? (-curruntOffset > 0 ? -curruntOffset <= (height / 3.5) ? curruntOffset : -(height / 3.5) : 0) : (-curruntOffset > 0 ? -curruntOffset <= (height / 2.5) ? curruntOffset : -(height / 2.5) : 0))
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({ value in
                                let maxHeight = height
                                withAnimation {
                                    showBottomBar = false
                                    if -curruntOffset > 150 && -curruntOffset < maxHeight / 1.5 {
                                        if statuses.count + 1 <= 5 {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3.6
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 3.6
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 3.6
                                            } else {
                                                curruntOffset = -maxHeight / 3.6
                                            }
                                        } else {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 1.5
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 2.6
                                            } else {
                                                curruntOffset = -maxHeight / 2.6
                                            }
                                        }
                                    }
                                    else {
                                        curruntOffset = 0
                                    }
                                }
                                lastOffset = curruntOffset
                            }))
                    }
                    
                }
                
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                .font(.system(size: 16, weight: .bold))
        })
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 22)
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
            self.curruntAddStatusOffset = gestureAddStatusOffset + lastAddStatusOffset
            if showAdditionalStatuses {
                curruntAddStatusOffset = -height + gestureAddStatusOffset + lastAddStatusOffset
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(project: projects[0])
    }
}
