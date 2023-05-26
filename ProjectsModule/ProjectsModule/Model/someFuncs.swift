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

func reindex (source: inout [Project], count: Int) {
    for iii in 0..<count {
        source[iii].idx = iii
    }
}

func reindex (source: inout [Task], count: Int) {
    for iii in 0..<count {
        source[iii].idx = iii
    }
}
