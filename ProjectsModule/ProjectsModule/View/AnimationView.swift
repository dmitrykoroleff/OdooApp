//
//  AnimationView.swift
//  project_management
//
//  Created by Dmitry Korolev on 2/4/2023.
//

import SwiftUI


extension View {
    
    func animatebleGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
    
}

struct AnimatableGradientModifier: AnimatableModifier {
    let bundle = Bundle(identifier: "ProjectsModule.ProjectsModule")
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
    
    var animatableData: CGFloat {
        get {progress}
        set {progress = newValue}
    }
    
    func body(content: Content) -> some View {
        var gradientColors = [Color]()
        
        for i in 0..<fromGradient.stops.count {
            let fromColor =  UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)
            
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
        
        return Circle().stroke(AngularGradient(gradient: Gradient(colors: gradientColors), center: .bottomLeading, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360.0)), lineWidth: 3).frame(width: 150, height: 150)
    }
    
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else {return Color(fromColor)}
        guard let toColor = toColor.cgColor.components else {return Color(toColor)}
        
        let r = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let g = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let b = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        
        return Color(red: Double(r), green: Double(g), blue: Double(b))
        
    }
    
}
