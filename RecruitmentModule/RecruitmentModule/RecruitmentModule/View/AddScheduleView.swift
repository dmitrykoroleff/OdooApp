//
//  AddScheduleView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct AddScheduleView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var text: String = ""
    @State private var shouldShowDropdown = false
    @State var activityType = ""
    @State var assignedTo = ""
    @State var summary = ""
    @State var dueDate = ""
    @Binding var showAddSchedule: Bool
    @Binding var currentOffset: CGFloat
    @State var selectedDate = Date()
    @State var title = "Messages"
    @State var qq = ""
    
    
    @State private var selectionActivity: String = "Activity Type"
    @State private var selectionAssigner: String = "Assign to"
    
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color("MainColor", bundle: bundle).opacity(0.5))
                    .frame(height: UIScreen.main.bounds.height)
                    .background(Color.white)
                    .shadow(color: Color("MainColor", bundle: bundle).opacity(0.5), radius: 5)
                    .cornerRadius(35)
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                currentOffset = 0
                                showAddSchedule = false
                            }
                        }, label: {
                            Text("Cancel")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("MainColor", bundle: bundle))
                        })
                        Spacer()
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                scheduleTasks.append(Schedule(user: testUser, text: text, dueTime: dueDate, type: activityType))
                                currentOffset = 0
                                showAddSchedule = false
                            }
                        }, label: {
                            Text("Done")
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        })
                    }
                    Spacer()
                        .frame(height: height/20)
                    HStack {
                        Text("Schedule activity")
                            .font(.system(size: 28))
                        Spacer()
                    }
                    ZStack(alignment: .topLeading) {
                        
                        if text.isEmpty {
                            Text("Enter schedule activity...")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .foregroundColor(.primary.opacity(0.25))
                            
                        }
                        
                        TextEditor(text: $text)
                            .padding(.horizontal, 5)
                            .frame(height: 100)
                    }
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .onAppear{
                                UITextView.appearance().backgroundColor = .clear
                            }
                            .onDisappear{
                                UITextView.appearance().backgroundColor = nil
                            }
                        
                    })
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(spacing: 10) {

                                VStack {
                                    TextField("Summary", text: $summary)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke()
                                                .frame(height: 50)
               
                                        )
                                    
                                    DatePicker("Due Date", selection: $selectedDate, in: Date.now...Date.distantFuture, displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                        .accentColor(Color("MainColor", bundle: bundle))
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke()
                                            .frame(height: 50)


                                    )
                                }
                                .frame(width: width * 0.8)
                                .customDropdownMenu(items: [ // хардкод
                                    DropdownItem(id: 1, title: "Assigned to", onSelect: {
                                        title = "Assigned to"
                                    }),
                                    DropdownItem(id: 2, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    }),
                                    DropdownItem(id: 3, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    }),
                                    DropdownItem(id: 4, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    }),
                                    DropdownItem(id: 5, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    }),
                                    DropdownItem(id: 6, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    }),
                                    DropdownItem(id: 7, title: "Arina Shoshina", onSelect: {
                                        title = "Arina Shoshina"
                                    })
                                ])
                                .customDropdownMenu(items: [ // хардкод
                                    DropdownItem(id: 1, title: "Activity type", onSelect: {
                                        title = "Activity type"
                                    }),
                                    DropdownItem(id: 2, title: "Email", onSelect: {
                                        title = "Email"
                                    }),
                                    DropdownItem(id: 3, title: "Call", onSelect: {
                                        title = "Call"
                                    }),
                                    DropdownItem(id: 4, title: "Meeting", onSelect: {
                                        title = "Meeting"
                                    }),
                                    DropdownItem(id: 5, title: "To Do", onSelect: {
                                        title = "To Do"
                                    }),
                                    DropdownItem(id: 6, title: "Reminder", onSelect: {
                                        title = "Reminder"
                                    }),
                                    DropdownItem(id: 7, title: "Upload document", onSelect: {
                                        title = "Upload document"
                                    })
                                ])
                                
                        
                        
                    }
                    
                    Spacer()
                }
                .frame(width: width * 0.8, height: height * 0.95)
                
            }
        }
    }
}

struct AddSheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AddScheduleView(showAddSchedule: .constant(false), currentOffset: .constant(0))
    }
}
