//
//  CustomProgressbarView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct CustomProgressBarView: View {
    let bundle = Bundle(identifier: "CRM.CRMModule")
    @State private var value = 60
    @State private var inputState: String = ""
    var total: Float
    var body: some View {
        
        HStack(spacing: 15) {
            
            ProgressView(value: CGFloat(value), total: 100)
                .accentColor(Color("ProgressBarColor", bundle: bundle))
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            
            Text("\(String(format: "%.1f", total)) руб")
        }
        .padding(.horizontal)
           
    }
}



//struct CustomProgressBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomProgressBarView()
//    }
//}







