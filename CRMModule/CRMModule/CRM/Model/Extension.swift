//
//  Extension.swift
//  CRMModule
//
//  Created by Данила on 27.05.2023.
//

import Foundation
// "yyyy-MM-dd HH:mm:ss"
class DateString {
    func strToDate(str: String, dateFormat: String) -> Int {
        let dateFormatter = DateFormatter()
        let mytime = Date()
        dateFormatter.dateFormat = dateFormat
        let dateNow = dateFormatter.date(from: dateFormatter.string(from: mytime))
        var date = dateFormatter.date(from: str)
        if date != nil {
            return Calendar(identifier: .gregorian).numberOfDaysBetween(dateNow!, and: date!)
        }
        return 0
    }
}


extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let numberOfDays = dateComponents([.day], from: from, to: to)
        return numberOfDays.day!
    }
}
