//
//  askCardView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct TaskCardView: View {
    
    var task: Task
    @Binding var showEditView: Bool
    @Binding var currentTask: Int
    @Binding var currentStatus: Status
    @Binding var currentEditOffset: CGFloat
    
    var width = UIScreen.main.bounds.width
    var heigth = UIScreen.main.bounds.height
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading) {
                    
                    Group {
                        Text("\(task.text)")
                            .font(.headline) +
                        Text((task.subTasks != nil) ? " + \(task.subTasks!.count) tasks": "")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                    if let company = task.company {
                        Text(company)
                            .font(.system(size: 15))
                    }
                    if task.tags != nil {
                        HStack {
                            ForEach(task.tags!, id: \.self) {tag in
                                Circle()
                                    .fill(.red)
                                    .frame(width: 8, height: 8)
                                Text(tag)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    if task.dueTime != nil {
                        Text(task.dueTime!)
                            .foregroundColor(task.dueTime! == "Yesterday" ? .red: .black)
                            .font(.headline)
                    }
                }
                Spacer()
                
                Menu {
                    
                    Button("Cancel", role: .destructive) {
                        
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Change status", systemImage: "folder")
                    }
                    
                    Button {
//                        currentTask = task.idx!
                        showEditView = true
                        currentEditOffset = -heigth
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Delete", systemImage: "delete.left")
                    }
                    
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                    
                }
                .frame(width: 50, height: 50)
                .foregroundColor(.primary)
                .offset(y: -10)
            }
            HStack {
                Button(action: {
                    withAnimation(Animation.linear(duration: 0.2)) {
                        
                    }
                }, label: {
                    Image(systemName: task.isFavorite ? "star.fill": "star")
                        .foregroundColor(task.isFavorite ? .yellow: .black)
                })
                Image(systemName: "clock")
                    .opacity(0.4)
                Spacer()
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.gray)
                    .opacity(0.4)
                    .background(content: {
                        Circle()
                            .stroke()
                            .foregroundColor(.gray)
                        
                    })
                Image("admin")
                    .resizable()
                    .frame(width: 27, height: 27)
                    .clipShape(Circle())
            }
        }
        .frame(width: width * 0.7)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke()
        )
        .padding(5)
    }
}

//struct TaskCardView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TaskCardView(task: projects[0].statuses[0].tasks[0], showEditView: $show, currentTask: $curr, currentStatus: $stat)
//    }
//}
