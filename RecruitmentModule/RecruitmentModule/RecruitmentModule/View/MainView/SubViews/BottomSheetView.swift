//
//  BottomSheetView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 02.02.2023.
//

import SwiftUI

struct BottomSheetView: View {
    let bundle = Bundle(identifier: "Recruitment.RecruitmentModule")
    @State var statuses: [Status]
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
                            .fontWeight(.bold)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            ForEach(statuses) { status in
                                VStack {
                                    if status.image == "globe" {
                                        ZStack {
                                            Circle()
                                                .stroke(.black, lineWidth: 1)
                                                .frame(width: 30, height: 30)
                                            Image(systemName: status.image)
                                        }
                                    } else {
                                        Image(systemName: status.image)
//                                            .fontWeight(.light)
                                            .frame(width: 30, height: 30)
                                    }
                                    Text(status.name)
                                        .font(.system(size: 9))
                                }
                            }
                        }
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
        BottomSheetView(statuses: statuses)
    }
}
