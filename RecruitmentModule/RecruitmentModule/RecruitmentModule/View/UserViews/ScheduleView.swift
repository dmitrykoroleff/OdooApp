//
//  ScheduleView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 06.02.2023.
//

import SwiftUI

struct ScheduleView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var user: User
    @State var text: String = ""
    @State var offSet: CGFloat = 0
    var tasks: [Task]
    @Binding var showAddSchedule: Bool
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Schedule activity")
                    .font(.system(size: 14))
                    .foregroundColor(Color("MainColor", bundle: bundle))
                List {
                    ForEach(tasks) { task in
                        TaskView(task: task)
                            .swipeActions {
                                Button(role: .destructive) {
                                    
                                } label: {
                                    //                                    VStack {
                                    //                                        Image(systemName: "trash")
                                    //                                        Text("Cancel")
                                    //
                                    //                                    }
                                    //                                    .foregroundColor(.white)
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
                                    //                                ZStack {
                                    //                                    Color("MainColor")
                                    //                                    VStack {
                                    //                                        Image(systemName: "square.and.pencil")
                                    //                                        Text("Edit")
                                    //                                            .font(.system(size: 6))
                                    //                                    }
                                    //                                    .foregroundColor(.white)
                                    //                                }
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
                        showAddSchedule.toggle()
                    }
                }, label: {
                    Text("Add new schedule activity")
                        .underline()
                        .foregroundColor(Color("MainColor", bundle: bundle))
                })
                Spacer()
                
            }
            //bottom sheet
//            if showBottomSheet {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 35)
//                            .stroke(Color("MainColor").opacity(0.5))
//                            .frame(height: UIScreen.main.bounds.height)
//                            .background(Color.white)
//                            .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
//                            .cornerRadius(35)
//                        VStack {
//                            HStack {
//                                Button(action: {
//                                    withAnimation(Animation.easeIn(duration: 0.2)){
//                                        showBottomSheet.toggle()
//                                    }
//                                }, label: {
//                                    Text("Cancel")
//                                        .foregroundColor(Color("MainColor"))
//                                        .font(.system(size: 14))
//                                })
//                                Spacer()
//                                Button(action: {
//                                    withAnimation(Animation.easeIn(duration: 0.2)){
//                                        showBottomSheet.toggle()
//                                    }
//                                }, label: {
//                                    Text("Done")
//                                        .foregroundColor(.gray)
//                                        .font(.system(size: 14))
//                                })
//                            }
//                            Spacer()
//                                .frame(height: height/20)
//                            HStack {
//                                Text("Log note")
//                                    .font(.system(size: 28))
//                                Spacer()
//                            }
//                            TextField("Enter log note", text: $text) //Очень не очень по сути только для макета надо переделать
//                                .padding()
//                                .background(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke()
//                                        .offset(y: 20)
//                                        .frame(height: 100)
//
//                                )
//                            //                        .offset(y: 20)
//                                .frame(height: 100)
//
//
//                            Spacer()
//                        }
//                        .frame(width: width * 0.8, height: height * 0.95)
//
//
//                }
//                .edgesIgnoringSafeArea(.bottom)
//                .offset(y: offSet)
//                .offset(y: height*0.05)
////                .offset(y: showBottomSheet ? 0: height)
//                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value:)))
//            }
        }
    }
//    func onChanged(value: DragGesture.Value) {
//        if value.translation.height > 0 {
//            offSet = value.translation.height
//        }
//    }

//    func onEnded(value: DragGesture.Value) {
//        if value.translation.height > 0 {
//            withAnimation(Animation.easeIn(duration: 0.2)) {
//                offSet = 0
//                showBottomSheet.toggle()
//            }
//        }
//    }
    
}

struct ScheduleView_Previews: PreviewProvider {
    @State static var flag = false
    static var previews: some View {
        ScheduleView(user: testUser, tasks: tasks, showAddSchedule: $flag)
    }
}
