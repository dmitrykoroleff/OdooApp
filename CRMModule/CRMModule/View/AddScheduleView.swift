//
//  AddScheduleView.swift
//  CRM
//
//  Created by Dmitry Korolev on 10/3/2023.
//

import SwiftUI

struct AddScheduleView: View {
    @State var text: String = ""
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    @State var selection: String = "Choose"
    @State var activityType = ""
    @State var assignedTo = ""
    @State var summary = ""
    @State var dueDate = ""
    @Binding var showAddSchedule: Bool
    
    
    

    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Sunday"),
        DropdownOption(key: uniqueKey, value: "Monday"),
        DropdownOption(key: uniqueKey, value: "Tuesday"),
        DropdownOption(key: uniqueKey, value: "Wednesday"),
        DropdownOption(key: uniqueKey, value: "Thursday"),
        DropdownOption(key: uniqueKey, value: "Friday"),
        DropdownOption(key: uniqueKey, value: "Saturday")
    ]
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color("MainColor").opacity(0.5))
                    .frame(height: UIScreen.main.bounds.height)
                    .background(Color.white)
                    .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
                    .cornerRadius(35)
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                showAddSchedule.toggle()
                            }
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(Color("MainColor"))
                                .font(.system(size: 14))
                        })
                        Spacer()
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                scheduleTasks.append(Schedule(user: testUser, text: text, dueTime: dueDate, type: activityType))
                                showAddSchedule.toggle()
                            }
                        }, label: {
                            Text("Done")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        })
                    }
                    Spacer()
                        .frame(height: height/20)
                    HStack {
                        Text("Schedule activity")
                            .font(.system(size: 28))
                        Spacer()
                    }
                    TextField("Enter schedule activity", text: $text) // очень плохо
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .offset(y: 20)
                                .frame(height: 100)
                            
                        )
                        .frame(height: 100)
                    Spacer()
                        .frame(height: 40)
                    VStack(spacing: 10) {

                        DropdownView(
                            placeholder: "Day of the week",
                            options: AddScheduleView.options,
                            onOptionSelected: { option in
                                print(option)
                        })
                        
                        TextField("Assigned to", text: $assignedTo) // очень плохо
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                
                            )

                        TextField("Summary", text: $summary) // очень плохо
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                
                                
                            )
                        TextField("Due Date", text: $dueDate) // очень плохо
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                
                                
                            )
                        
                    }
                    
                    Spacer()
                }
                .frame(width: width * 0.8, height: height * 0.95)
                
            }
        }
    }
}

struct AddSheduleView_Previews: PreviewProvider {
    @State static var flag = false
    static var previews: some View {
        AddScheduleView(showAddSchedule: $flag)
    }
}
