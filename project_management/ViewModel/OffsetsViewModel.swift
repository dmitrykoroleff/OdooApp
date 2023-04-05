//
//  OffsetsViewModel.swift
//  project_management
//
//  Created by Dmitry Korolev on 2/4/2023.
//

import SwiftUI

func customBottomButtonOffset(height: CGFloat) -> [CGFloat] {
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    if height > 600 && height < 700 {
        offsetX = -25
        offsetY = -70
    } else if height < 800 && height > 700 {
        offsetX = -30
        offsetY = -110
    } else if height > 800 && height < 900{
        offsetX = -30
        offsetY = -120
    } else {
        offsetX = -40
        offsetY = -130
    }
    
    return [offsetX, offsetY]
}

func customAddButtonOffset(height: CGFloat) -> [CGFloat] {
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    if height > 600 && height < 700 {
        offsetX = -255
        offsetY = -70
    } else if height < 800 && height > 700 {
        offsetX = -240
        offsetY = -110
    } else if height > 800 && height < 900{
        offsetX = -255
        offsetY = -120
    } else {
        offsetX = -295
        offsetY = -130
    }
    
    return [offsetX, offsetY]
}

func searchViewOffset(searchIsActive: Bool, height: CGFloat) -> CGFloat {
    
    return searchIsActive ? height > 600 && height < 700 ? (height / 4.8) : height > 700 && height < 800 ? (height / 5.7) : height > 800 && height < 900 ? (height / 6.4) : (height / 6.8) : height
    
}


func searchBarOffset(searchIsActive: Bool, scrollViewContentOffset: CGFloat, height: CGFloat) -> CGFloat {
    
    return searchIsActive && scrollViewContentOffset < 30 ? height > 500 && height < 700 ? -(height / 5) : height > 700 && height < 800 ? -(height / 6) : height > 800 && height < 900 ? -(height / 6.5) : -(height / 7.5) : searchIsActive && scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? 0 : scrollViewContentOffset < 30 && scrollViewContentOffset > 0 && !searchIsActive ? -scrollViewContentOffset : 0
}

func headerOffset(searchIsActive: Bool, scrollViewContentOffset: CGFloat, height: CGFloat) -> CGFloat {
    return searchIsActive ? -(height / 2) : scrollViewContentOffset < 30 && scrollViewContentOffset > 0 ? -scrollViewContentOffset : 0
}
