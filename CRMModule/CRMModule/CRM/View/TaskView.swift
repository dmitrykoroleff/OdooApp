//
//  TaskView.swift
//  CRM
//
//  Created by Dmitry Korolev on 7/3/2023.
//

import SwiftUI

struct TaskView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var currentIndex = 0
    var task: Task
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    @State var showAddSchedule = false
    @State var showAddLogNoteSheet = false
    @State var curruntAddScheduleOffset: CGFloat = 0
    @State var lastAddScheduleOffset: CGFloat = 0
    @GestureState var gestureAddScheduleOffset: CGFloat = 0
    @State var curruntAddLogNoteOffset: CGFloat = 0
    @State var lastAddLogNoteOffset: CGFloat = 0
    @GestureState var gestureAddLogNoteOffset: CGFloat = 0
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                VStack(spacing: 10) {

                    Spacer()
                    
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
                
                HStack(spacing: 10) {
                    ForEach(Array(0...3), id: \.self) { index in
                        Circle()
                            .fill(Color.black.opacity(currentIndex == index ? 1 : 0.1))
                            .frame(width: 8, height: 8)
                            .animation(.spring(), value: currentIndex == index)
                    }
                    
                }
                .offset(y: height < 700 ? -10 : -20)
                
                TabView(selection: $currentIndex) {
                    GeneralInformationView(task: task)
                        .tag(0)
                    SummaryView(task: testTask)
                        .tag(1)
                    
                    VStack(alignment: .center) {
                        Text("Log note")
                            .font(.system(size: 14))
                            .foregroundColor(Color("MainColor", bundle: bundle))
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
                                        .tint(Color("MainColor", bundle: bundle))
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
                                curruntAddLogNoteOffset = -(height + 60)
                                showAddLogNoteSheet = true
                            }
                        }, label: {
                            Text("Add new log note")
                                .underline()
                                .foregroundColor(Color("MainColor", bundle: bundle))
                        })
                        Spacer()
                        
                    }
                    .tag(2)
                    
                    ScheduleListView(scheduleTasks: scheduleTasks, showAddSchedule: $showAddSchedule, curruntAddScheduleOffset: $curruntAddScheduleOffset)
                        .tag(3)
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.vertical, 60)
            
            AddLogNoteView(showAddLogNoteSheet: $showAddLogNoteSheet, currentOffset: $curruntAddLogNoteOffset)
                .offset(y: height)
                .offset(y: -curruntAddLogNoteOffset > 0 ? -curruntAddLogNoteOffset <= (height - 50) ? curruntAddLogNoteOffset : -(height - 50) : 0)
                .gesture(DragGesture().updating($gestureAddLogNoteOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                }).onEnded({ value in
                    let maxHeight = height
                    withAnimation {
                        showAddLogNoteSheet = false
                        if -curruntAddLogNoteOffset > height / 1.4 && -curruntAddLogNoteOffset < maxHeight + height / 1.3 {
                            curruntAddLogNoteOffset = -maxHeight + 60
                        }
                        else {
                            curruntAddLogNoteOffset = 0
                        }
                    }
                    lastAddLogNoteOffset = curruntAddLogNoteOffset
                }))
            
            AddScheduleView(showAddSchedule: $showAddSchedule, currentOffset: $curruntAddScheduleOffset)
                .offset(y: height)
                .offset(y: -curruntAddScheduleOffset > 0 ? -curruntAddScheduleOffset <= (height - 50) ? curruntAddScheduleOffset : -(height - 50) : 0)
                .gesture(DragGesture().updating($gestureAddScheduleOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                }).onEnded({ value in
                    let maxHeight = height
                    withAnimation {
                        showAddSchedule = false
                        if -curruntAddScheduleOffset > height / 1.4 && -curruntAddScheduleOffset < maxHeight + height / 1.3 {
                            curruntAddScheduleOffset = -maxHeight + 60
                        }
                        else {
                            curruntAddScheduleOffset = 0
                        }
                    }
                    lastAddScheduleOffset = curruntAddScheduleOffset
                }))
            
           
        }
        .toolbar {
            
            ToolbarItem(placement: .principal) {
                Image("logo", bundle: bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 64, height: 22)
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
        .navigationBarHidden(showAddLogNoteSheet || showAddSchedule || curruntAddScheduleOffset != 0 || curruntAddLogNoteOffset != 0 ? true : false)
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.curruntAddScheduleOffset = gestureAddScheduleOffset + lastAddScheduleOffset
            if showAddSchedule {
                curruntAddScheduleOffset = -(height - 60) + gestureAddScheduleOffset + lastAddScheduleOffset
            }
            self.curruntAddLogNoteOffset = gestureAddLogNoteOffset + lastAddLogNoteOffset
            if showAddLogNoteSheet {
                curruntAddLogNoteOffset = -(height - 60) + gestureAddLogNoteOffset + lastAddLogNoteOffset
            }
        }
    }
    
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: testTask)
    }
}
