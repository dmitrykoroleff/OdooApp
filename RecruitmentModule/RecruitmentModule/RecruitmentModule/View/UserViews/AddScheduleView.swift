//
//  AddSheduleView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 06.02.2023.
//

import SwiftUI

struct AddScheduleView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var text: String = ""
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    @State var selection: String = "Choose"
    @State var activityType = ""
    @State var assignedTo = ""
    @State var summary = ""
    @State var dueDate = ""
    @Binding var showAddSchedule: Bool
    
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
                                showAddSchedule.toggle()
                            }
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(Color("MainColor", bundle: bundle))
                                .font(.system(size: 14))
                        })
                        Spacer()
                        Button(action: {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                tasks.append(Task(user: testUser, text: text, dueTime: dueDate, type: activityType))
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
                    TextField("Enter schedule activity", text: $text) //Очень не очень по сути только для макета надо переделать
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .offset(y: 20)
                                .frame(height: 100)
                            
                        )
                    //                        .offset(y: 20)
                        .frame(height: 100)
                    Spacer()
                        .frame(height: 40)
                    VStack(spacing: 10) {
                        TextField("Activity type", text: $activityType) //Очень не очень по сути только для макета надо переделать
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                //                                .offset(y: 20)
                                
                                
                            )
                        //                        .offset(y: 20)
                        
                        TextField("Assigned to", text: $assignedTo) //Очень не очень по сути только для макета надо переделать
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                //                                .offset(y: 20)
                                
                                
                            )
                        //                        .offset(y: 20)
                        //                        .frame(height: 100)
                        TextField("Summary", text: $summary) //Очень не очень по сути только для макета надо переделать
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                //                                .offset(y: 20)
                                
                                
                            )
                        //                        .offset(y: 20)
                        TextField("Due Date", text: $dueDate) //Очень не очень по сути только для макета надо переделать
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 50)
                                //                                .offset(y: 20)
                                
                                
                            )
                        //                        .offset(y: 20)
                        
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
