//
//  AddTaskView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct AddTaskView: View {
    
    var currentStatus: Int
    var project: Project
    @Binding var showAddTaskView: Bool
    @Binding var curruntAddTaskOffset: CGFloat
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    @State private var _external = false
    @State private var _internal = false
    @State var text: String = String()
    @State private var newText: String = String()
    @State private var dudeName: String = String()
//    @State var companyName: String = String()
    
    @State private var date = Date.now
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
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
                        withAnimation(Animation.easeIn(duration: 0.2)){
                            showAddTaskView = false
                            curruntAddTaskOffset = 0
                        }
                        HapticManager.instance.impact(style: .light)
                    }, label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("MainColor"))
                    })
                    Spacer()
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.2)){
                            
                            let newTask = Task(text: text, company: newText == "" ? "My Company": newText, status: projects[project.idx!].statuses[currentStatus])
                            projects[project.idx!].statuses[currentStatus].tasks.append(newTask)
                            showAddTaskView = false
                            curruntAddTaskOffset = 0
                        }
                        HapticManager.instance.notification(type: .success)
                    }, label: {
                        Text("Add")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    })
                }
                Spacer()
                    .frame(height: height/20)
                HStack {
                    Text("Create a new project task")
                        .font(.system(size: 28))
                    Spacer()
                }
                TextField("Task title", text: $text) //Очень не очень по сути только для макета надо переделать
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
//                            .offset(y: 20)
                            .frame(height: 50)

                    )
                //                        .offset(y: 20)
                    .frame(height: 100)
                TextField("Company name", text: $newText) //Очень не очень по сути только для макета надо переделать
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .frame(height: 50)

                    )
                
                TextField("Assigner", text: $dudeName) //Очень не очень по сути только для макета надо переделать
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .frame(height: 50)

                    )
                    .frame(height: 100)
//                TextField("date", text: $text) //Очень не очень по сути только для макета надо переделать
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke()
//                            .frame(height: 50)
//
//                    )
//                    .frame(height: 100)
                
//                TextField("type", text: $text) //Очень не очень по сути только для макета надо переделать
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke()
//                            .frame(height: 50)
//
//                    )
              
            
                    
                
                
                Spacer()
            }
            .frame(width: width * 0.8, height: height * 0.95)
            
            
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AddTaskView(currentStatus: projects[0].statuses[0], project: projects[0], showAddTaskView: .constant(false), curruntAddTaskOffset: .constant(0))
//    }
//}
