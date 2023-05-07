//
//  BottomSheetView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct BottomSheetView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    var height = UIScreen.main.bounds.height
    var width = UIScreen.main.bounds.width
    @Binding var curruntAddStatusOffset: CGFloat
    @Binding var currentStatus: Status
    @Binding var index: Int
    @State var showBottomBar = false
    @Binding var showAdditionalStatuses: Bool
    let columns = [
            GridItem(.adaptive(minimum: 60))
        ]
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color("MainColor", bundle: bundle).opacity(0.5))
                    .frame(height: UIScreen.main.bounds.height)
                    .background(Color.white)
                    .shadow(color: Color("MainColor", bundle: bundle).opacity(0.5), radius: 5)
                    .cornerRadius(35)
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "minus")
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 34, height: 3)
                        .foregroundColor(Color("MainColor", bundle: bundle))
                    
                    
                    HStack {
                        Text("Change status")
                            .font(.body)
                            .fontWeight(.semibold)
                           
                        Spacer()
                    }
                    LazyVGrid(columns: columns, spacing: 20)  {
                            
                            ForEach(statuses) { status in
                                Button(action: {
                                    withAnimation(Animation.easeIn(duration: 0.2)) {
                                        index = find(value: status, in: statuses)!
                                        currentStatus = statuses[index]
                                    }
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
                            }
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
    static var previews: some View {
        BottomSheetView(curruntAddStatusOffset: .constant(0), currentStatus: .constant(Status(id: UUID(), image: "graduationcap", name: "Student")), index: .constant(0), showAdditionalStatuses: .constant(false))
    }
}
