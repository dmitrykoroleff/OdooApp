//
//  CustomDots.swift
//  RecruitmentModule
//
//  Created by Nikita Rybakovskiy on 04.02.2023.
//

import SwiftUI

struct CustomDots: View {
    let numberOfPages: Int
    let currentIndex: Int
    
    
    // MARK: - Drawing Constants
    
    //    private let circleSize: CGFloat = 16
    private let circleSpacing: CGFloat = 12
    //
    //    private let primaryColor = Color.white
    //    private let secondaryColor = Color.white.opacity(0.6)
    //
    private let smallScale: CGFloat = 0.6
    
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: circleSpacing) {
            ForEach(0..<numberOfPages) { index in // 1
                //                if shouldShowIndex(index) {
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(currentIndex == index ? .black: .gray)
                    .id(index)
                //                    Circle()
                //                        .fill(currentIndex == index ? primaryColor : secondaryColor) // 2
                //                        .scaleEffect(currentIndex == index ? 1 : smallScale)
                //
                //                        .frame(width: circleSize, height: circleSize)
                //
                    .transition(AnyTransition.opacity.combined(with: .scale)) // 3
                
                // 4
                //                }
            }
        }
    }
    //    func shouldShowIndex(_ index: Int) -> Bool {
    //        ((currentIndex - 1)...(currentIndex + 1)).contains(index)
    //    }
}

struct CustomDots_Previews: PreviewProvider {
    static var previews: some View {
        CustomDots(numberOfPages: 3, currentIndex: 1)
    }
}


