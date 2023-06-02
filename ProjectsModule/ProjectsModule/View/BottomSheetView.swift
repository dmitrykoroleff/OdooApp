//
//  BottomSheetView.swift
//  project_management
//
//  Created by Dmitry Korolev on 31/3/2023.
//

import SwiftUI

struct BottomSheetView: View {
    let bundle = Bundle(identifier: "ProjectsModule.ProjectsModule")
    var currentProjectIdx: Int
    var currentTask: Int
    var onStatus: Int
    @Binding var changingStatus: Bool
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @Binding var curruntAddStatusOffset: CGFloat
    @Binding var currentStatus: Status
    @Binding var index: Int
    @Binding var currOffset: CGFloat
    @State var showBottomBar = false
    @Binding var showAdditionalStatuses: Bool
    let columns = [
            GridItem(.adaptive(minimum: 60))
        ]
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color("MainColor").opacity(0.5))
                    .frame(height: UIScreen.main.bounds.height)
                    .background(Color.white)
                    .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
                    .cornerRadius(35)
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "minus")
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 34, height: 3)
                        .foregroundColor(Color("MainColor"))
                    
                    
                    HStack {
                        Text("Change status")
                            .font(.body)
                            .fontWeight(.semibold)
                           
                        Spacer()
                    }
                    LazyVGrid(columns: columns, spacing: 20)  {
                            
                        ForEach(Array(projects[currentProjectIdx].statuses.enumerated()), id: \.offset) { offset, status in
                                Button(action: {
                                    if changingStatus {
                                        
                                        var currTask = projects[currentProjectIdx].statuses[onStatus].tasks[currentTask]
                                        projects[currentProjectIdx].statuses[onStatus].tasks.remove(at: currentTask)
                                        reindex(source: &projects[currentProjectIdx].statuses[onStatus].tasks, count:  projects[currentProjectIdx].statuses[onStatus].tasks.count)
                                        currTask.idx = projects[currentProjectIdx].statuses[status.idx!].tasks.count
                                        projects[currentProjectIdx].statuses[status.idx!].tasks.append(currTask)
                                        changingStatus.toggle()
                                    }
                                    withAnimation(Animation.easeIn(duration: 0.2)) {
                                        index = offset
                                        currentStatus = status
                                        currOffset = 0
                                        showBottomBar = false
                                    }
                                    HapticManager.instance.impact(style: .soft)
                                }, label: {
                                    VStack(spacing: 10) {
                                        if status.image == "globe" {
                                            ZStack {
                                                Circle()
                                                    .stroke(.black, lineWidth: 1)
                                                    .frame(width: 40, height: 40)
                                                Image(systemName: status.image)
                                                    .resizable()
                                                    .frame(width: 25, height: 25)
                                                    .font(Font.title.weight(.thin))
                                            }
                                        } else {
                                            Image(systemName: status.image)
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                                .font(Font.title.weight(.thin))
                                        }
                                        Text(status.name)
                                            .font(.system(size: 7))
                                            .padding(.top, status.image == "globe" ? 1 : 5)
                                    }
                                    .foregroundColor(.black)
                                })
                            }
                        
                        Button(action: {
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                curruntAddStatusOffset = -height
                                showAdditionalStatuses = true
                                changingStatus = false
                            }
                            HapticManager.instance.impact(style: .soft)
                        }, label: {
                            VStack {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .font(Font.title.weight(.thin))
                                Text("Add new status")
                                    .font(.system(size: 7))
                                    .padding(.top, 5)
                            }
                            .foregroundColor(.black)
                        })
                        
                        }
                    
                    
                    Spacer()
                }
                .padding()
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    @State static var changingStatus = false
    @State static var currOffset: CGFloat = 0
    static var previews: some View {
        BottomSheetView(currentProjectIdx: 0, currentTask: 0, onStatus: 0, changingStatus: $changingStatus, curruntAddStatusOffset: .constant(0), currentStatus: .constant(Status(id: UUID(), image: "graduationcap", name: "Student")), index: .constant(0), currOffset: $currOffset, showAdditionalStatuses: .constant(false))
    }
}
