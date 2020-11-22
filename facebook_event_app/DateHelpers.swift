//
//  EventManager.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import Foundation

//"November 10, 2018 6:00 PM"'

class DateHelpers {
    static func uniqueDaysFrom(dates: Array<Date>) -> Array<Date> {
        var uniqueDays: Set<Date> = []
        dates.forEach { (date) in
            uniqueDays.insert(date.withoutTime())
        }
        var uniqueDaysArray = Array(uniqueDays)
        uniqueDaysArray.sort(by: {$0 < $1})
        return uniqueDaysArray
    }
    
    
    
    
}

extension Date {
    
    func dateHeader() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: self)
    }
 
    func withoutTime() -> Date {
        let calendar = NSCalendar.current
        
        let startDateMonth = calendar.component(.month, from: self)
        let startDateDay = calendar.component(.day, from: self)
        let startDateYear = calendar.component(.year, from: self)
        
        let components = DateComponents(calendar: calendar, year: startDateYear, month: startDateMonth, day: startDateDay)
        
        return calendar.date(from: components) ?? self
        
    }
    
    func eventDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}
