//
//  TaskView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 06.02.2023.
//

import SwiftUI

struct TaskView: View {
    var task: Task
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                
                Circle()
                    .foregroundColor(Color("MainColor"))
                    .frame(width: 40, height: 40)
                
                Text("A") // Хардкод
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading) {
                    
                    Group {
                        Text("\(task.dueTime): ")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: 0x017E84)) +
                        Text(task.type)
                            .font(.system(size: 14))
                    }
                    
                    
                    Text(task.text)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: 0x282F33))
                }
                Text("for \(task.user.name)")
                    .font(.system(size: 10))
                    .foregroundColor(Color(hex: 0x6B6D70))
                    .offset(y:2)
            }
        }
        .frame(height: 68)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: tasks[0])
    }
}
