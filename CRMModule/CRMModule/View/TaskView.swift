//
//  TaskView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct TaskView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var currentIndex = 0
    var task: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var showBottomSheet = false
    @State var showAddSchedule = false
    @State var curruntAddScheduleOffset: CGFloat = 0
    @State var lastAddScheduleOffset: CGFloat = 0
    @GestureState var gestureAddScheduleOffset: CGFloat = 0
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(spacing: 10) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 22)
                    Spacer()
                        .frame(height: height/80)
                    Text(task.name)
                        .font(.system(size: 20, weight: .bold))
                    Text(task.price)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .underline()
                    Spacer()
                }
                .frame(height: height/6)
                Spacer()
                TabView {
                    GeneralInformationView(task: task)
                    SummaryView(task: testTask)
                    
                    VStack(alignment: .center) {
                        Text("Log note")
                            .font(.system(size: 14))
                            .foregroundColor(Color("MainColor"))
                        List {
                            ForEach(notes) { note in
                                NoteView(note: note)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            
                                        } label: {

                                            Label {
                                                Text("Cancel")
                                                    .font(.system(size: 6))
                                            } icon: {
                                                Image(systemName: "trash")
                                            }
                                            .labelStyle(VerticalLabelStyle())
                                            //Does't work :(
                                            
                                        }
                                        .tint(Color("MainColor"))
                                        Button(role: .cancel) {
                                            
                                        } label: {
                                            Label("Edit", systemImage: "square.and.pencil")
                                        }
                                        
                                    }
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: height*0.55)
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)){
                                showBottomSheet.toggle()
                            }
                        }, label: {
                            Text("Add new log note")
                                .underline()
                                .foregroundColor(Color("MainColor"))
                        })
                        Spacer()
                        
                    }
                    
                    ScheduleListView(scheduleTasks: scheduleTasks, showAddSchedule: $showAddSchedule, curruntAddScheduleOffset: $curruntAddScheduleOffset)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .onAppear {
                    setupAppearance()
                }
            }
            .padding(.vertical, 60)
            
            AddScheduleView(showAddSchedule: $showAddSchedule)
                .offset(y: height)
                .offset(y: showAddSchedule ? -curruntAddScheduleOffset > 0 ? -curruntAddScheduleOffset <= (height - 25) ? curruntAddScheduleOffset : -(height - 25) : 0 : 0)
                .gesture(DragGesture().updating($gestureAddScheduleOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                }).onEnded({ value in
                    let maxHeight = height
                    withAnimation {
                        showAddSchedule = false
                        if -curruntAddScheduleOffset > 150 && -curruntAddScheduleOffset < maxHeight / 1.5 {
                            if height > 600 && height < 700 {
                                curruntAddScheduleOffset = -maxHeight / 3
                            } else if height < 800 && height > 700 {
                                curruntAddScheduleOffset = -maxHeight / 1.5
                            } else if height > 800 && height < 900{
                                curruntAddScheduleOffset = -(maxHeight - 30)
                            } else {
                                curruntAddScheduleOffset = -maxHeight / 2
                            }
                        }
                        else {
                            curruntAddScheduleOffset = 0
                        }
                    }
                    lastAddScheduleOffset = curruntAddScheduleOffset
                }))
            
           
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .bold))
        })
        .navigationBarHidden(showBottomSheet || showAddSchedule ? true : false)
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.curruntAddScheduleOffset = gestureAddScheduleOffset + lastAddScheduleOffset
            if showAddSchedule {
                if height > 500 && height < 700 {
                    curruntAddScheduleOffset = -(height / 3) + gestureAddScheduleOffset + lastAddScheduleOffset
                } else if height < 800 && height > 700{
                    curruntAddScheduleOffset = -(height / 1.5) + gestureAddScheduleOffset + lastAddScheduleOffset
                } else if height > 800 && height < 900 {
                    curruntAddScheduleOffset = -(height - 30) + gestureAddScheduleOffset + lastAddScheduleOffset
                } else {
                    curruntAddScheduleOffset = -(height / 2.5) + gestureAddScheduleOffset + lastAddScheduleOffset
                }
            }
        }
    }
    
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: testTask)
    }
}
