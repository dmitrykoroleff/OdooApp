//
//  AddStatusView.swift
//  project_management
//
//  Created by Dmitry Korolev on 30/3/2023.
//

import SwiftUI

struct AddStatusView: View {
    @State var text: String = ""
    @State var activeStatus: String = "plus"
    @Binding var showView: Bool
    @Binding var currentStatus: Status
    @Binding var currentOffset: CGFloat
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
        VStack {
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
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                showView = false
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
                            withAnimation(Animation.easeIn(duration: 0.2)) {
                                statuses.append(Status(id: UUID(), image: activeStatus, name: text))
                                currentStatus = statuses[statuses.count - 1]
                                showView = false
                                text = ""
                                activeStatus = "plus"
                                currentOffset = 0
                            }
                            HapticManager.instance.notification(type: .success)
                        }, label: {
                            Text("Done")
                                .fontWeight(.medium)
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        })
                    }
                    Spacer()
                        .frame(height: height/20)
                    HStack {
                        Text("New status")
                            .font(.system(size: 28))
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 60)
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 1)
                                .frame(width: 60, height: 60)
                            Image(systemName: activeStatus)
                                .font(.system(size: 40, weight: .light))
                                .frame(width: 60, height: 60)
                        }
                        
                        TextField("Name of status", text: $text)
                            .multilineTextAlignment(.center)
                            .frame(width: 287)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                                    .frame(height: 40)
                            )
                            
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke()
                            .frame(width: 319, height: 180)
                    )
                    Spacer()
                        .frame(height: 100)
                    VStack(spacing: 20) { //нужно отрисовывать кружок а в нем картинку + развернуть некоторые
                        HStack(spacing: 20) {
                            ForEach(additionStatuses[0]) {status in
                                Button(action: {
                                    withAnimation(Animation.default) {
                                        activeStatus = status.image
                                    }
                                }, label: {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .frame(width: 45, height: 45)
                                        Image(systemName: status.image)
                                            .rotationEffect(Angle(degrees: status.image == "airplane" ? -90: 0))
                                    }
                                })
                            }
                        }
                        HStack(spacing: 20) {
                            ForEach(additionStatuses[1]) {status in
                                Button(action: {
                                    withAnimation(Animation.default) {
                                        activeStatus = status.image
                                    }
                                }, label: {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .frame(width: 45, height: 45)
                                        Image(systemName: status.image)
                                            .rotationEffect(Angle(degrees: status.image == "arrow.triangle.2.circlepath" ? -35: 0))
                                    }
                                })
                            }
                        }
                        HStack(spacing: 20) {
                            ForEach(additionStatuses[2]) {status in
                                Button(action: {
                                    withAnimation(Animation.default) {
                                        activeStatus = status.image
                                    }
                                }, label: {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 1)
                                            .frame(width: 45, height: 45)
                                        Image(systemName: status.image)
                                    }
                                })
                            }
                        }
                    }
                    .font(.system(size: 25, weight: .light))
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke()
                            .frame(width: 319, height: 210)
                    )
                    
                    
                    Spacer()
                }
                .frame(width: width * 0.8, height: height * 0.95)
                
            }
        }
    }
}

struct AddStatusView_Previews: PreviewProvider {
    static var previews: some View {
        AddStatusView(showView: .constant(false), currentStatus: .constant(statuses[0]), currentOffset: .constant(0))
    }
}
