//
//  ExtensionCalendar.swift
//  RecruitmentModule
//
//  Created by Данила on 24.04.2023.
//

import Foundation

class DateString {
    func strToDate(str: String) -> Int {
        let dateFormatter = DateFormatter()
        let mytime = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
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
