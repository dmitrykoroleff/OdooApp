//
//  ScheduleView2.swift
//  CRM
//
//  Created by Dmitry Korolev on 13/3/2023.
//

import SwiftUI

struct ScheduleView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    var scheduleTask: Schedule
    var shared: LogicR
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                
                Circle()
                    .foregroundColor(Color("MainColor", bundle: bundle))
                    .frame(width: 40, height: 40)
                
                Text("\(shared.getFirstLetter(str: scheduleTask.user))") // Хардкод
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
            }
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading) {
                    
                    Group {
                        Text("\(scheduleTask.dueTime): ")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: 0x017E84)) +
                        Text(scheduleTask.type)
                            .font(.system(size: 14))
                    }
                    
                    
                    Text(scheduleTask.text)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: 0x282F33))
                }
                Text("for \(scheduleTask.user)")
                    .font(.system(size: 10))
                    .foregroundColor(Color(hex: 0x6B6D70))
                    .offset(y:2)
            }
        }
        .frame(height: 68)
    }
}
