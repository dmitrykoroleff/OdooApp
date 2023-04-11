//
//  ContentView.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 31.01.2023.
//

import SwiftUI

public struct RecruitmentView: View {
    public init() {
        
    }
    public var body: some View {
        WebsiteRequestView(shared: LogicR())
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecruitmentView()
    }
}
