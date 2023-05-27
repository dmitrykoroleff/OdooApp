//
//  ScheduleView.swift
//  CRM
//
//  Created by Dmitry Korolev on 13/3/2023.
//

import SwiftUI

struct ScheduleListView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    var scheduleTasks: [Schedule]
    @Binding var showAddSchedule: Bool
    @Binding var curruntAddScheduleOffset: CGFloat
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var shared: CRMLogic
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Schedule activity")
                    .font(.system(size: 14))
                    .foregroundColor(Color("MainColor", bundle: bundle))
                List {
                    ForEach(scheduleTasks) { scheduleTask in
                        ScheduleView(scheduleTask: scheduleTask, shared: shared)
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                } label: {

                                    Label {
                                        Text("Cancel")
                                            .font(.system(size: 6))
                                    } icon: {
                                        Image(systemName: "trash")
                                    }
                                    .labelStyle(VerticalLabelStyle())
                                    //Does't work :(
                                    
                                }
                                .tint(Color("MainColor", bundle: bundle))
                                Button(role: .cancel) {
                                    
                                } label: {
                                    Label("Edit", systemImage: "square.and.pencil")
                                }
                                Button(role: .destructive) {
                                    
                                } label: {
                                    Label("Done", systemImage: "checkmark.square")
                                }
                                .tint(Color(hex: 0x017E84))
                            }
                    }
                }
                .listStyle(.plain)
                .frame(height: height*0.55)
                Button(action: {
                    withAnimation(Animation.easeIn(duration: 0.2)){
                        curruntAddScheduleOffset = -(height + 60)
                        showAddSchedule = true
                    }
                }, label: {
                    Text("Add new schedule activity")
                        .underline()
                        .foregroundColor(Color("MainColor", bundle: bundle))
                })
                Spacer()
                
            }

        }
    }

    
}

//struct ScheduleListView_Previews: PreviewProvider {
//    @State static var flag = false
//    static var previews: some View {
//        ScheduleListView(scheduleTasks: scheduleTasks, showAddSchedule: .constant(false), curruntAddScheduleOffset: .constant(0))
//    }
//}
