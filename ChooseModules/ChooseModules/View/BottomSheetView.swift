//
//  BottomSheetView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI

struct BottomSheetView: View {
    let bundle = Bundle(identifier: "chooseModules.ChooseModules")
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var liked = false
    
    var body: some View {
        
        
        VStack {
            
            Spacer()
            
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
                    
                    
                    ScrollView() {
                        Text("All modules")
                        LazyVGrid(columns: columns) {
                            ForEach(Modules.sampleData){module in
                                ModuleCardView(module: module, liked: liked)
                            }
                            
                        }
                    }
                    
                    
                }
                .padding()
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
    
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView()
    }
}

