//
//  ModuleCardView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 10/1/2023.
//

import SwiftUI

struct ModuleCardView: View {
    let module: String
    let colors: [Color] = [Color("CardColor1", bundle: bundle),
                           Color("CardColor2", bundle: bundle),
                           Color("CardColor3", bundle: bundle),
                           Color("CardColor4", bundle: bundle),
                           Color("CardColor5", bundle: bundle),
                           Color("CardColor6", bundle: bundle),
                           Color("CardColor7", bundle: bundle)]
    @State var liked = false
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                
                Rectangle()
                    .cornerRadius(20)
                    .frame(width: 150, height: 100)
                    .foregroundColor(colors[Int(generateColorFor(text: module, colors: colors))])
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack {
                            
                            Image(systemName: liked ? "heart.fill" : "heart")
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    liked.toggle()
                                    
                                    
                                }
                            
                            Spacer()
                        }
                        .padding(.top, 25)
                        
                    }
                    .padding(10)
                    
                   
                        
                        generateIcon(text: module) // Хардкод
                            .resizable()
                            .frame(width: module == "CRM" ? 50 : 35, height: 35)
                            .offset(y: -36)
                    
                    Text(module) // Хардкод
                        .foregroundColor(.white)
                        .offset(y: -40)
                    
                }
                
            }
            .frame(width: 150, height: 100)
            .padding(.horizontal, 28)
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

//struct ModuleCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModuleCardView(module: Modules(name: "", notifications: 0, view: ModuleCardView.self as! View))
//    }
//}
