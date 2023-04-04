//
//  TasksView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct TasksView: View {
    var project: Project
    @Binding var task: Task
    @State var isActive = false
    @State var onThisView = true
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
    @State var curruntAddTaskOffset: CGFloat = 0
    @State var lastAddTaskOffset: CGFloat = 0
    @GestureState var gestureAddTaskOffset: CGFloat = 0
    @State var currentTask: Int = 0
    var gradient1 = Gradient(colors:[Color("GradientColor1"), Color("GradientColor2"), Color("GradientColor3"), Color("GradientColor4"), Color("GradientColor1")])
    
    var gradient2 = Gradient(colors:[Color("GradientColor4"), Color("GradientColor1"), Color("GradientColor2"), Color("GradientColor3"), Color("GradientColor4")])

    @State private var progression: CGFloat = 0
    @State var currentEditOffset: CGFloat = 0
    @State var lastEditOffset: CGFloat = 0
    @GestureState var gestureEditOffset: CGFloat = 0
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
                                
                                Text(verbatim: "awesomeuser@edu.hse.ru") // Хардкод
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
                                
                            }.simultaneousGesture(TapGesture().onEnded{
                                onThisView = false
                            })
                            .onAppear {
                                onThisView = true
                            }
                            
                        }
                        .padding()
                        .padding(.horizontal, 15)
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack {
                            Text("\(currentIndex < project.statuses.count ? project.statuses[currentIndex].name: "Add new status")")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color("Headings"))
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        .offset(y: searchIsActive ? -(height / 2) : 0)
                        HStack(spacing: 15) {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                            
                            TextField("Enter the task name...", text: $searchQuery, onEditingChanged: { search in
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
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundColor(project.statuses.count == currentIndex ? Color.black : Color.gray)
                        }
                        .padding(.bottom)
                        
                        TabView(selection: $currentIndex) {
                            ForEach(Array((project.statuses + [Status(id: UUID(), image: "", name: "Add New")]).enumerated()), id: \.offset) { offset, element in
                                ScrollView(.vertical, showsIndicators: false) {
                                    VStack {
                                    if currentIndex == project.statuses.count || offset == project.statuses.count {
                                        HStack {
                                            VStack {
                                                ZStack {
                                                    Image(systemName: "plus")
                                                        .resizable()
                                                        .font(Font.title.weight(.ultraLight))
                                                        .frame(width: 60, height: 60)
                                                    
                                                    animatebleGradient(fromGradient: gradient1, toGradient: gradient2, progress: progression)
                                                        .onAppear{
                                                            
                                                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses:true)) {
                                                                self.progression = 1
                                                            }
                                                            
                                                        }
                                                    
                                                    
                                                }
                                                .frame(width: width / 1.05, height: height / 2)
                                                .foregroundColor(Color("MainColor"))
                                                Spacer()
                                            }
                                        }
                                        .onTapGesture {
                                            withAnimation {
                                                curruntAddStatusOffset = -(height)
                                                showAdditionalStatuses = true
                                            }
                                        }
                                    } else if projects[project.idx!].statuses[currentIndex].tasks.isEmpty {
                                        Text("There are no tasks in this status yet")
                                            .font(.body)
                                            .fontWeight(.light)
                                            .foregroundColor(Color.gray)
                                            .italic()
                                    } else {
                                        ForEach(projects[project.idx!].statuses[currentIndex].tasks) { task in
                                            NavigationLink(
                                                destination:
                                                    TaskManagmentView(), isActive: $isActive) {
                                                        TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus, currentEditOffset: $currentEditOffset)
                                                    }
                                                    .simultaneousGesture(TapGesture().onEnded{
                                                        onThisView = false
                                                    })
                                                    .onAppear {
                                                        onThisView = true
                                                    }
                                                    .foregroundColor(.black)
                                            
                                        }
                                    }
                                }
                                    .padding(.bottom, height / 3)
                                }
//                                .tag(offset)
                                
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
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 5) : height > 700 && height < 800 ? (height / 5.7) : height > 800 && height < 900 ? (height / 7) : (height / 7) : height)
                        
                    } else if !searchQuery.isEmpty {
                        NoResultsView(searchQuery: $searchQuery)
                            .offset(y: searchIsActive ? height > 600 && height < 700 ? (height / 5) : height > 700 && height < 800 ? (height / 5.7) : height > 800 && height < 900 ? (height / 7) : (height / 7) : height)
                    }
                    
                        
                    HStack {
                        if currentIndex != project.statuses.count {
                            Button(action: {
                                withAnimation(Animation.easeIn(duration: 0.2)){
                                    showAddTaskView = true
                                    curruntAddTaskOffset = -height
                                    
                                }
                                
                            }, label: {
                                CustomAddButton()
                            })
                            .offset(x: customAddButtonOffset(height: height)[0], y: customAddButtonOffset(height: height)[1])
                        }
                        Button(action: {
                            withAnimation(Animation.easeIn(duration: 0.2)){
                                if statuses.count + 1 <= 5 {
                                    if height > 500 && height < 700 {
                                        curruntOffset = -(height / 3)
                                    } else if height < 800 && height > 700 {
                                        curruntOffset = -(height / 2.3)
                                    } else if height > 800 && height < 900 {
                                        curruntOffset = -(height / 2.8)
                                    } else {
                                        curruntOffset = -(height / 3)
                                    }
                                } else {
                                    if height > 500 && height < 700 {
                                        curruntOffset = -(height / 2.3)
                                    } else if height < 800 && height > 700 {
                                        curruntOffset = -(height / 2.9)
                                    } else if height > 800 && height < 900 {
                                        curruntOffset = -(height / 2.8)
                                    } else {
                                        curruntOffset = -(height / 2.6)
                                    }
                                }
                                showBottomBar = true
                                
                            }
                            
                        }, label: {
                            CustomBottomButton()
                        })
                        .offset(x: customBottomButtonOffset(height: height)[0], y: customBottomButtonOffset(height: height)[1])
                        
                    }
                    
                    
                    VStack {
                        BottomSheetView(currentProjectIdx: project.idx!, curruntAddStatusOffset: $curruntAddStatusOffset, currentStatus: $currentStatus, index: $currentIndex, showAdditionalStatuses: $showAdditionalStatuses)
                            .offset(y: height)
                            .offset(y: statuses.count + 1 <= 5 ? (-curruntOffset > 0 ? -curruntOffset <= (height / 2.5) ? curruntOffset : -(height / 2.5) : 0) : (-curruntOffset > 0 ? -curruntOffset <= (height / 2.2) ? curruntOffset : -(height / 2.2) : 0))
                            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                out = value.translation.height
                                onChange()
                            }).onEnded({ value in
                                let maxHeight = height
                                withAnimation {
                                    showBottomBar = false
                                    if -curruntOffset > 200 && -curruntOffset < maxHeight / 1.5 {
                                        if statuses.count + 1 <= 5 {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 3
                                            } else if height < 800 && height > 700 {
                                                curruntOffset = -maxHeight / 2.3
                                            } else if height > 800 && height < 900{
                                                curruntOffset = -maxHeight / 2.8
                                            } else {
                                                curruntOffset = -maxHeight / 3
                                            }
                                        } else {
                                            if height > 600 && height < 700 {
                                                curruntOffset = -maxHeight / 2.3
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
                    
                    AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus, currentOffset: $curruntAddStatusOffset)
                        .offset(y: height)
                        .offset(y: -curruntAddStatusOffset > 0 ? -curruntAddStatusOffset <= (height + 10) ? curruntAddStatusOffset : -(height + 10) : 0)
                        .gesture(DragGesture().updating($gestureAddStatusOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showAdditionalStatuses = false
                                if -curruntAddStatusOffset > height / 1.4 && -curruntAddStatusOffset < maxHeight + height / 1.3 {
                                    curruntAddStatusOffset = -maxHeight
                                }
                                else {
                                    curruntAddStatusOffset = 0
                                }
                            }
                            lastAddStatusOffset = curruntAddStatusOffset
                        }))
                    
                    AddTaskView(currentStatus: currentStatus, project: project, showAddTaskView: $showAddTaskView, curruntAddTaskOffset: $curruntAddTaskOffset)
                        .offset(y: height)
                        .offset(y: -curruntAddTaskOffset > 0 ? -curruntAddTaskOffset <= (height + 10) ? curruntAddTaskOffset : -(height + 10) : 0)
                        .gesture(DragGesture().updating($gestureAddTaskOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            let maxHeight = height
                            withAnimation {
                                showAddTaskView = false
                                if -curruntAddTaskOffset > height / 1.4 && -curruntAddTaskOffset < maxHeight + height / 1.3 {
                                    curruntAddTaskOffset = -maxHeight
                                }
                                else {
                                    curruntAddTaskOffset = 0
                                }
                            }
                            lastAddTaskOffset = curruntAddTaskOffset
                        }))
                    EditTaskView(showEditOffset: $showEditView, task: $task, currentEditOffset: $currentEditOffset)
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
        .navigationBarHidden((showAdditionalStatuses || curruntAddStatusOffset != 0 || curruntAddTaskOffset != 0 || currentEditOffset != 0) || !onThisView ? true : false)
    
}

    func onChange(){
        DispatchQueue.main.async {
            self.curruntOffset = gestureOffset + lastOffset
            if showBottomBar {
                if statuses.count + 1 <= 5 {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 3) + gestureOffset + lastOffset
                    } else if height < 800 && height > 700{
                        curruntOffset = -(height / 2.3) + gestureOffset + lastOffset
                    } else if height > 800 && height < 900 {
                        curruntOffset = -(height / 2.8) + gestureOffset + lastOffset
                    } else {
                        curruntOffset = -(height / 3) + gestureOffset + lastOffset
                    }
                } else {
                    if height > 500 && height < 700 {
                        curruntOffset = -(height / 2.3) + gestureOffset + lastOffset
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
            self.curruntAddTaskOffset = gestureAddTaskOffset + lastAddTaskOffset
            if showAddTaskView {
                curruntAddTaskOffset = -height + gestureAddTaskOffset + lastAddTaskOffset
            }
            if showEditView {
                currentEditOffset = -height + gestureEditOffset + lastEditOffset
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(project: projects[0], task: .constant(projects[0].statuses[0].tasks[0]))
    }
}
