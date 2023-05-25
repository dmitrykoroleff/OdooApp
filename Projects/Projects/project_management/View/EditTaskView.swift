//
//  EditTaskView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct EditTaskView: View {
    
    @Binding var showEditOffset: Bool
    @Binding var task: Task
    @Binding var currentEditOffset: CGFloat
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    @State private var date = Date.now
    
    @State private var _external = false
    @State private var _internal = false
    
    @State var text: String = String()
    @State private var companyName: String = String()
    
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
                            UIApplication.shared.endEditing()
                            showEditOffset = false
                            currentEditOffset = 0
                        }
                        HapticManager.instance.impact(style: .light)
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color("MainColor"))
                            .font(.system(size: 14))
                    })
                    Spacer()
                    Button(action: {
                        projects[task.projectIdx].statuses[task.status.idx!].tasks[task.idx!].text = text
                        projects[task.projectIdx].statuses[task.status.idx!].tasks[task.idx!].company = companyName
                        withAnimation(Animation.easeIn(duration: 0.2)){

                            UIApplication.shared.endEditing()
                            showEditOffset = false
                            currentEditOffset = 0
                        }
                        HapticManager.instance.notification(type: .success)
                    }, label: {
                        Text("Edit")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    })
                }
                Spacer()
                    .frame(height: height/20)
                HStack {
                    Text("Edit existing task")
                        .font(.system(size: 28))
                    Spacer()
                }
                TextField("Task text", text: $text) //Очень не очень по сути только для макета надо переделать
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
//                            .offset(y: 20)
                            .frame(height: 50)

                    )
                //                        .offset(y: 20)
                    .frame(height: 100)
                TextField("Company name", text: $companyName) //Очень не очень по сути только для макета надо переделать
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .frame(height: 50)

                    )
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
//                TextField("Company name", text: $task.status) //Очень не очень по сути только для макета надо переделать
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke()
//                            .frame(height: 50)
//
//                    )
//                    .frame(height: 100)
                    
                
                
                Spacer()
            }
            .frame(width: width * 0.8, height: height * 0.95)
            
            
        }
        .onAppear {
            text = task.text
            companyName = task.company ?? ""
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    @State static var show = false
    static var previews: some View {
        EditTaskView(showEditOffset: .constant(false), task: .constant(Task(projectIdx: 0, text: "Meeting Room Furnitures", company: "YourCompany, Joel Willis", status: projects[0].statuses[0])), currentEditOffset: .constant(0))
    }
}
