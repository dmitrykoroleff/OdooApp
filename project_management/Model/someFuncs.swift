//
//  someFuncs.swift
//  project_management
//
//  Created by Dmitry Korolev on 2/4/2023.
//

import SwiftUI
import Foundation

protocol Indexable {
    var idx: Int? { get set }
}

func reindex(source: inout Indexable, count: Int) {
    for i in 0..<count {
        source.idx = i
    }
}
