//
//  TaskManagmentView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct TaskManagmentView: View {
    @State var selectedDate = Date()
    var task: Task
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var text: String = "The best description ever done by the human being!"
    @State var projectName = "Best project"
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        TabView {
            VStack {
                Text(task.text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Headings"))

                Text("Project name: \(projects[task.projectIdx].name)") // хардкод
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .frame(width: width - 40, height: 50)
                )
                
                DatePicker("Deadline:", selection: $selectedDate, in: Date.now...Date.distantFuture, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .accentColor(Color("MainColor"))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .frame(width: width - 40, height: 50)


                )
                
                List {
                    Section("Assignees") {
//                        ForEach(assigner???) { assigner in
//
//                        }
                        
                        Text("Dmitry Korolev") // хардкод
                        Text("Nikita Rybakovskii")
                        
                    }
                    Section("Milestones") {
                        
                        Text("Development of the UI \"Project\" module")
                        Text("Development of the back-end \"Project\" module")
                        
                    }
                    Section("Customers") {
                        
                        Text("MIEM")
                        
                    }
                }
                .cornerRadius(10)
                .frame(height: height / 2)
                   
                
                Spacer()
            }
            .padding()
            
            VStack {
                
                Text("Description")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Headings"))

                    TextEditor(text: $text)
                        .frame(width: width - 40, height: height / 4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                            }
                                    
                
                Spacer()
            }
            .padding()
            
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .onAppear {
            setupAppearance()
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
    }
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

//struct TaskManagmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskManagmentView(task: projects[0].statuses[0].tasks[0])
//    }
//}
