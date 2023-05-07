//
//  BottomSheetView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI
import CRMModule
import RecruitmentModule
struct BottomSheetView: View {
    let bundle = Bundle(identifier: "chooseModules.ChooseModules")
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var liked = false
    @State var openModule: String? = nil
    var body: some View {
        
        VStack {
            NavigationLink(destination: CRMModule.StatusView(),
                           tag: "CRM",
                           selection: $openModule)
            { EmptyView() }
            NavigationLink(destination: RecruitmentModule.StatusView(),
                           tag: "Recruitment",
                           selection: $openModule)
            { EmptyView() }
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
                                Button(action: {
                                    openModule = module.name
                                }) {
                                    ModuleCardView(module: module, liked: liked)
                                    
                                }
                               
                                
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

