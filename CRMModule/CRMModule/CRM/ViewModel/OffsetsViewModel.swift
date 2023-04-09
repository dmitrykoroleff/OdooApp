//
//  OffsetsViewModel.swift
//  CRM
//
//  Created by Dmitry Korolev on 20/3/2023.
//

import SwiftUI

// here is all functions for all offsets...

func customBottomButtonOffset(height: CGFloat) -> [CGFloat] {
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    
    if height > 600 && height < 700 {
        offsetX = -25
        offsetY = -40
    } else if height < 800 && height > 700 {
        offsetX = -30
        offsetY = -80
    } else if height > 800 && height < 900{
        offsetX = -30
        offsetY = -90
    } else {
        offsetX = -40
        offsetY = -100
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
