//
//  BottomBarView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 05.02.2023.
//

import SwiftUI

struct BottomBarView: View {
    @State var text: String = ""
    
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
                        Button(action: {}, label: {
                            Text("Cancel")
                                .foregroundColor(Color("MainColor"))
                                .font(.system(size: 14))
                        })
                        Spacer()
                        Button(action: {}, label: {
                            Text("Done")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        })
                    }
                    Spacer()
                        .frame(height: height/20)
                    HStack {
                        Text("Log note")
                            .font(.system(size: 28))
                        Spacer()
                    }
                    TextField("Enter log note", text: $text) //Очень не очень по сути только для макета надо переделать
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .offset(y: 20)
                                .frame(height: 100)
                                
                        )
//                        .offset(y: 20)
                        .frame(height: 100)
                        
                    
                    Spacer()
                }
                .frame(width: width * 0.8, height: height * 0.95)
                
            }
        }
    }
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
