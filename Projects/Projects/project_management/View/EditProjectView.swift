//
//  EditProjectView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct EditProjectView: View {
    @Binding var showEditProjectView: Bool
    @Binding var currentEditOffset: CGFloat
    @Binding var project: Project
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    @State private var date = Date.now
    
    @State private var _external = false
    @State private var _internal = false
    
    @State var projectName: String = String()
    @State private var companyName: String = String()
    @State var projectType: [String] = []
    
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
                            showEditProjectView = false
                            currentEditOffset = 0
                        }
                        HapticManager.instance.impact(style: .light)
                    }, label: {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("MainColor"))
                    })
                    Spacer()
                    Button(action: {
//                        print(projects[project.idx!].name)
                        projects[project.idx!].name = projectName
                        projects[project.idx!].company = companyName
                        projects[project.idx!].type = projectType
//                        print(projects[project.idx!].name)
//                        projects[project.idx!].type = project.type
                        withAnimation(Animation.easeIn(duration: 0.2)){
                            UIApplication.shared.endEditing()
                            showEditProjectView = false
                            currentEditOffset = 0
                        }
                        HapticManager.instance.notification(type: .success)
                    }, label: {
                        Text("Edit")
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    })
                }
                Spacer()
                    .frame(height: height/20)
                HStack {
                    Text("Edit existing project")
                        .font(.system(size: 28))
                    Spacer()
                }
                TextField("Project name", text: $projectName) //Очень не очень по сути только для макета надо переделать
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
                DatePicker(selection: $date, in: Date.now...Date.distantFuture, displayedComponents: .date) {
                                Text(" Select a date")
                        .opacity(0.3)
                            }
                .accentColor(Color("MainColor"))
                .frame(height: 90)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .frame(height: 50)
                }
//                TextField("type", text: $text) //Очень не очень по сути только для макета надо переделать
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke()
//                            .frame(height: 50)
//
//                    )
                HStack {

                    Button(action: {
                        if (projectType.contains("External")) {
                            projectType.remove(at: projectType.firstIndex(of: "External")!)
                        } else {
                            projectType.append("External")
                        }
                    }, label: {
                        HStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                            Text("External")
                                .foregroundColor(!(projectType.contains("External")) ? .black: .white)
                        }
                    })
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke()
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(!(projectType.contains("External")) ? .white: Color(hex: 0xEC9706))
                                    .frame(width: 100, height: 30)

                            }
                            .frame(width: 100, height: 30)

                    }
                    .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        if (projectType.contains("Internal")) {
                            projectType.remove(at: projectType.firstIndex(of: "Internal")!)
                        } else {
                            projectType.append("Internal")
                        }
                    }, label: {
                        HStack {
                            Circle()
                                .fill(.purple)
                                .frame(width: 8, height: 8)
                            Text("Internal")
                                .foregroundColor(!(projectType.contains("Internal")) ? .black: .white)
                        }
                    })
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke()
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(!(projectType.contains("Internal")) ? .white: Color(hex: 0xA219FF))
                                    .frame(width: 100, height: 30)

                            }
                            .frame(width: 100, height: 30)

                    }
                    .padding(.horizontal)

                }
            
                    
                
                
                Spacer()
            }
            .frame(width: width * 0.8, height: height * 0.95)
        }
        .onAppear {
            projectName = project.name
            companyName = project.company
            projectType = project.type
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(showEditProjectView: .constant(false), currentEditOffset: .constant(0), project: .constant(projects[0]))
    }
}
