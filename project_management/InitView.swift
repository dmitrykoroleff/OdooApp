//
//  InitView.swift
//  project_management
//
//  Created by Nikita Rybakovskiy on 03.04.2023.
//

import SwiftUI

struct InitView: View {
    
    var initdata = initData()
    
    var body: some View {
        ProjectsView(project: .constant(projects[0]), task: .constant(projects[0].statuses[0].tasks[0]))
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
    }
}