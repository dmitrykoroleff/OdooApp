//
//  AddProjectView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct AddProjectView: View {
    
    @Binding var currProjects: [Project]
    @Binding var showBottomSheet: Bool
    @Binding var currentOffset: CGFloat
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateStyle = .long
            return formatter
        }()
    
    @State private var _external = false
    @State private var _internal = false
    @State var text: String = String()
    @State private var newText: String = String()
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
                            text = ""
                            newText = ""
                            _external = false
                            _internal = false
                            date = Date.now
                            UIApplication.shared.endEditing()
                            showBottomSheet = false
                            currentOffset = 0
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
                            var types: [String] = []
                            if _internal {
                                types.append("Internal")
                            }
                            if _external {
                                types.append("External")
                            }
                            
                            let newProject = Project(name: text, company: newText == "" ? "The Best Company": newText, type: types
                            )
                            projects.append(newProject)
                            text = ""
                            newText = ""
                            _external = false
                            _internal = false
                            date = Date.now
                            showBottomSheet = false
                            currentOffset = 0
                            currProjects = projects
                            UIApplication.shared.endEditing()
                            
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
                    Text("Create a new project")
                        .font(.system(size: 28))
                    Spacer()
                }
                TextField("Project name", text: $text) //Очень не очень по сути только для макета надо переделать
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
                        _external.toggle()
                    }, label: {
                        HStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                            Text("External")
                                .foregroundColor(!_external ? .black: .white)
                        }
                    })
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke()
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(!_external ? .white: .orange)
                                    .opacity(0.6)
                                    .frame(width: 100, height: 30)
                                    
                            }
                            .frame(width: 100, height: 30)
                            
                    }
                    .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        _internal.toggle()
                    }, label: {
                        HStack {
                            Circle()
                                .fill(.purple)
                                .frame(width: 8, height: 8)
                            Text("Internal")
                                .foregroundColor(!_internal ? .black: .white)
                        }
                    })
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .stroke()
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(!_internal ? .white: .purple)
                                    .opacity(0.6)
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
    }
}

struct AddProjectView_Previews: PreviewProvider {
    @State static var show = false
    @State static var pr = projects
    static var previews: some View {
        AddProjectView(currProjects: $pr, showBottomSheet: $show, currentOffset: .constant(0))
    }
}
