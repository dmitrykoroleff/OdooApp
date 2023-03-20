//
//  CarouselModulesView.swift
//  CRM
//
//  Created by Dmitry Korolev on 6/3/2023.
//

import SwiftUI

struct CarouselModulesView <Content: View, T: Identifiable>: View {

    @State private var progress: CGFloat = 0
    @State private var progression: CGFloat = 0
    @Binding var curruntAddStatusOffset: CGFloat
    @Binding var showAdditionalStatuses: Bool
    @Binding var currentStatus: Status
    var addNewStatus = Status(id: UUID(), image: "", name: "Add new status")
    
    var gradient1 = Gradient(colors:[Color("GradientColor1"), Color("GradientColor2"), Color("GradientColor3"), Color("GradientColor4"), Color("GradientColor1")])
    
    var gradient2 = Gradient(colors:[Color("GradientColor4"), Color("GradientColor1"), Color("GradientColor2"), Color("GradientColor3"), Color("GradientColor4")])
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var height: CGFloat = UIScreen.main.bounds.height
    var width: CGFloat = UIScreen.main.bounds.width
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 16,
         index: Binding<Int>, items: [T], curruntAddStatusOffset: Binding<CGFloat>,
         showAdditionalStatuses: Binding<Bool>,currentStatus: Binding<Status>,
         @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self._curruntAddStatusOffset = curruntAddStatusOffset
        self._showAdditionalStatuses = showAdditionalStatuses
        self._currentStatus = currentStatus
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width - trailingSpace + spacing
            let adjustmentWidth = (trailingSpace / 2) - spacing
            HStack(spacing: spacing) {
                ForEach(list) {item in
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace, height: height)
                }
                
                HStack {
                    VStack {
                        ZStack {
                            Image(systemName: "plus")
                                .resizable()
                                .font(Font.title.weight(.ultraLight))
                                .frame(width: 60, height: 60)
                            
                            animatebleGradient(fromGradient: gradient1, toGradient: gradient2, progress: progression)
                            
                        }
                        .frame(width: width / 1.05, height: height / 15)
                        .foregroundColor(Color("MainColor"))
                        Spacer()
                    }
                }
                .onTapGesture {
                    withAnimation {
                        if height > 500 && height < 700 {
                            curruntAddStatusOffset = -(height / 3)
                        } else if height < 800 && height > 700 {
                            curruntAddStatusOffset = -(height / 2.9)
                        } else if height > 800 && height < 900 {
                            curruntAddStatusOffset = -(height - 30)
                        } else {
                            curruntAddStatusOffset = -(height / 2.5)
                        }
                        showAdditionalStatuses = true
                    }
                }
                
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded({ value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count), 0)
                        currentIndex = index
                        currentStatus = currentIndex == statuses.count ? addNewStatus: statuses[currentIndex]
                        
                    })
                    .onChanged({value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex), list.count), 0)
                    })
            )
        }
        .animation(.easeOut, value: offset == 0)
    }
    
    
    func getIndex(item: T)->Int{
        let index = list.firstIndex { currentModule in
            return currentModule.id == item.id
        } ?? 0
        return index
    }
}

struct CarouselModulesView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(taskCards: TaskCard.sampleWebsiteRequest)
    }
}

extension View {
    
    func animatebleGradient(fromGradient: Gradient, toGradient: Gradient, progress: CGFloat) -> some View {
        
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient, toGradient: toGradient, progress: progress))
    }
    
}

struct AnimatableGradientModifier: AnimatableModifier {
    
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
        
        for ind in 0..<fromGradient.stops.count {
            let fromColor =  UIColor(fromGradient.stops[ind].color)
            let toColor = UIColor(toGradient.stops[ind].color)
            
            gradientColors.append(colorMixer(fromColor: fromColor, toColor: toColor, progress: progress))
        }
        
        return Circle().stroke(AngularGradient(gradient: Gradient(colors: gradientColors),
                                               center: .bottomLeading, startAngle: Angle(degrees: 0.0),
                                               endAngle: Angle(degrees: 360.0)), lineWidth: 3).frame(width: 150, height: 150)
    }
    
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else {return Color(fromColor)}
        guard let toColor = toColor.cgColor.components else {return Color(toColor)}
        
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
        
    }
    
}
