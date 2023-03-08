//
//  BottomSheetView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI

@available(iOS 14.0, *)
struct BottomSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var liked = false
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color("MainColor").opacity(0.5))
                    .frame(height: UIScreen.main.bounds.height)
                    .background(Color("BottomSheet"))
                    .shadow(color: Color("MainColor").opacity(0.5), radius: 5)
                    .cornerRadius(35)
                
                VStack(spacing: 20) {
                    
                    Image(systemName: "minus")
                        .resizable()
                        .imageScale(.large)
                        .frame(width: 34, height: 3)
                        .foregroundColor(colorScheme == .light ? Color("MainColor"): Color(.white))
                    
                    ScrollView {
                        Text("All modules")
                        LazyVGrid(columns: columns) {
                            ForEach(Modules.sampleData) {module in
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
    @available(iOS 13.0, *)
    static var previews: some View {
        if #available(iOS 14.0, *) {
            BottomSheetView()
        } else {
            // Fallback on earlier versions
        }
    }
}
