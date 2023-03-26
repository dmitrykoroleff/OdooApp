//
//  CustomProgressbarView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct CustomProgressBarView: View {
    @State private var value = 60
    @State private var inputState: String = ""

    var body: some View {
        
        HStack(spacing: 15) {
            
            ProgressView(value: CGFloat(value), total: 100)
                .accentColor(Color("ProgressBarColor", bundle: bundle))
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            
            Text("\(value) руб")
        }
        .padding(.horizontal)
           
    }
}



struct CustomProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBarView()
    }
}







