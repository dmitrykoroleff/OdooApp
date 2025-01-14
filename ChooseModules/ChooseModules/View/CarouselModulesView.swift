//
//  ModuleLikedCardView.swift
//  Choose Module
//
//  Created by Dmitry Korolev on 9/1/2023.
//

import SwiftUI

struct CarouselModulesView <Content: View, T: Identifiable>: View {

    @State private var progress: CGFloat = 0
    @State private var progression: CGFloat = 0
    @Binding var currentOffset: CGFloat
    @Binding var addFavModule: Bool
//    let bundle = Bundle(identifier: "chooseModules.ChooseModules")
    let bundle = Bundle(identifier: "odoo.miem.ios.ChooseModules")
    
    var gradient1: Gradient
    
    var gradient2: Gradient
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    var height: CGFloat = UIScreen.main.bounds.height
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 16, index: Binding<Int>,
         items: [T], currentOffset: Binding<CGFloat>, addFavModule: Binding<Bool>, @ViewBuilder content: @escaping (T) -> Content) {
        self.gradient1 = Gradient(colors:[Color("GradientColor1", bundle: bundle),
                                          Color("GradientColor2", bundle: bundle),
                                          Color("GradientColor3", bundle: bundle),
                                          Color("GradientColor4", bundle: bundle),
                                          Color("GradientColor1", bundle: bundle)])
        self.gradient2 = Gradient(colors:[Color("GradientColor4", bundle: bundle),
                                          Color("GradientColor1", bundle: bundle),
                                          Color("GradientColor2", bundle: bundle),
                                          Color("GradientColor3", bundle: bundle),
                                          Color("GradientColor4", bundle: bundle)])
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self._currentOffset = currentOffset
        self._addFavModule = addFavModule
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
                        .frame(width: proxy.size.width - trailingSpace, height: getHeight(item: item, width: width))
                }
                
                VStack(spacing: 10) {
                    
                    Text("Add favourite module")
                        .fixedSize()
                    
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
                .fixedSize()
                .padding(.top, 20)
                .frame(width: proxy.size.width - 30, height: getHeight2())
                .foregroundColor(Color("MainColor", bundle: bundle))
                .background(
                    animatebleGradient(fromGradient: gradient1, toGradient: gradient2, progress: progression)
                        .onAppear{
                            
                            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses:true)) {
                                //MARK: animation turn off
//                                self.progression = 1
                            }
                            
                        }
                        .padding(.top, 20)
                )
                .onTapGesture {
                    withAnimation {
                        if height > 500 && height < 700 {
                            currentOffset = -(height / 3)
                        } else if height < 800 && height > 700 {
                            currentOffset = -(height / 2.9)
                        } else if height > 800 && height < 900 {
                            currentOffset = -(height / 2.75)
                        } else {
                            currentOffset = -(height / 2.5)
                        }
                        addFavModule = true
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
    
    func getHeight(item: T, width: CGFloat)->CGFloat{

        let previous = getIndex(item: item) + 1 == currentIndex ? height / 3.8 : height / 3.8
        
        let next = getIndex(item: item) - 1 == currentIndex ? height / 3.8 : height / 3.8
        
        let checkBetween = currentIndex >= 0 && currentIndex <= list.count ?
        (getIndex(item: item) - 1 == currentIndex ? previous: next) : height / 3.8
        
        return getIndex(item: item) == currentIndex ? height / 3.5 : checkBetween
    }
    
    func getHeight2()->CGFloat{
        
        let previous = list.count == currentIndex ? (offset < 0 ? height / 4 : height / 4) : height / 4
        
        let next = list.count - 1 == currentIndex ? (offset < 0 ? height / 4 : height / 3.8) : height / 3.8
        
        let checkBetween = currentIndex >= 0 && currentIndex <= list.count
        ? (list.count - 1 == currentIndex ? previous: next) : height / 3.8
        
        return list.count == currentIndex ? height / 3.5 : checkBetween
    }
    
    func getIndex(item: T)->Int{
        let index = list.firstIndex { currentModule in
            return currentModule.id == item.id
        } ?? 0
        return index
    }
}

//struct CarouselModulesView_Previews: PreviewProvider {
//    static var previews: some View {
////        ChooseModuleView(modules: Modules.sampleData)
//        ChooseModuleView()
//    }
//}

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
        
        return RoundedRectangle(cornerRadius: 20).stroke(AngularGradient(
            gradient: Gradient(colors: gradientColors), center: .bottomLeading,
            startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 360.0)), lineWidth: 3)
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
