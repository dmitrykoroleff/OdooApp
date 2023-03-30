//
//  TasksView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct TasksView: View {
    @StateObject var project: Project
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
    
    @State var currentTask: Int = 0
    var body: some View {
        NavigationView {
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
                        Text(currentStatus.name) //hardcode
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
                    
                    //
                    VStack {

                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(project.tasks[currentStatus.name] ?? []) { task in
                                NavigationLink(
                                    destination:
                                        TaskManagmentView(), isActive: $isActive) {
                                        TaskCardView(task: task, showEditView: $showEditView, currentTask: $currentTask, currentStatus: $currentStatus)
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .edgesIgnoringSafeArea(.bottom)
                        
                    }
                    .offset(y: searchIsActive ? -(height / 8) : 0)
                    .edgesIgnoringSafeArea(.bottom)
                }
                .frame(width: width)
                .offset(y: showBottomBar ? height*0.045: 0)

                
               
                    
                if !showBottomBar && !searchIsActive && !showAdditionalStatuses && !showAddTaskView {
                    
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
                                showBottomBar.toggle()
                                
                            }
                            
                        }, label: {
                            CustomBottomButton()
                        })
                        .offset(x: -(width / 8), y: (height / 5000))
                        
                    }
                } else if  showBottomBar {
                    //Bottom bar
                    VStack {
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(Color("MainColor").opacity(0.5))
                                .frame(height: UIScreen.main.bounds.height)
                                .background(Color.white)
                                .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
                                .cornerRadius(35)
                            
                            Button(action: {
                                withAnimation(Animation.easeOut(duration: 0.2)){
                                    showBottomBar.toggle()
                                }
                            }, label: {})
                                .buttonStyle(.plain)
                                .frame(width: width, height: height)
                            VStack(spacing: 20) {
                                
                                Image(systemName: "minus")
                                    .resizable()
                                    .imageScale(.large)
                                    .frame(width: 34, height: 3)
                                    .foregroundColor(Color("MainColor"))
                                
                                
                                HStack {
                                    Text("Change status")
                                        .font(.system(size: 20, weight: .bold))
                                    Spacer()
                                }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        
                                        ForEach(statuses) { status in
                                            Button(action: {
                                                withAnimation(Animation.easeIn(duration: 0.2)) {
                                                    currentStatus = status
                                                }
                                            }, label: {
                                                VStack {
                                                    if status.image == "globe" {
                                                        ZStack {
                                                            Circle()
                                                                .stroke(.black, lineWidth: 1)
                                                                .frame(width: 30, height: 30)
                                                            Image(systemName: status.image)
                                                        }
                                                    } else {
                                                        Image(systemName: status.image)
                                                            .font(.system(size:25))
                                                            .frame(width: 50, height: 50)
                                                    }
                                                    Text(status.name)
                                                        .font(.system(size: 14))
                                                }
                                                .foregroundColor(.black)
                                            })
                                            
                                        }
                                        Button(action: {
                                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                                showAdditionalStatuses.toggle()
                                                showBottomBar.toggle()
                                            }
                                        }, label: {
                                            VStack {
                                                Image(systemName: "plus")
                                                    .font(.system(size: 25))
                                                    .fontWeight(.light)
                                                    .frame(width: 50, height: 50)
                                                Text("Add status")
                                                    .font(.system(size: 14))
                                            }
                                            .foregroundColor(.black)
                                        })
                                        
                                    }
                                }
                                Spacer()
                            }
                            .padding()
                            
                        }
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: offSet)
                    .offset(y: height*0.75)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                } else if showAdditionalStatuses {
                    //Status Sheet
                    AddStatusView(showView: $showAdditionalStatuses, currentStatus: $currentStatus)
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: offSet)
                        .offset(y: height*0.05)
                    //                    .offset(y: showBottomBar ? 0: height)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                } else if showAddTaskView {
                    AddTaskView()
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: offSet)
                    .offset(y: height*0.05)
                    //                .offset(y: showBottomSheet ? 0: height)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                }
                if showEditView {
                    EditTaskView()
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: offSet)
                        .offset(y: height*0.05)
                        //                .offset(y: showBottomSheet ? 0: height)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                }
                
            }
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
        .navigationBarHidden((isActive || searchIsActive || showAdditionalStatuses || showAddTaskView || showEditView) ? true : false)
    
}

func onChanged(value: DragGesture.Value) {
    if value.translation.height > 0 {
        offSet = value.translation.height
    }
}

func onEnded(value: DragGesture.Value) {
    if value.translation.height > 0 {
        withAnimation(Animation.easeIn(duration: 0.2)) {
            showBottomBar.toggle()
            offSet = 0
        }
        
    }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(project: projects[0])
    }
}
