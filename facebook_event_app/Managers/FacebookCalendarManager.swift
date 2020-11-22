//
//  FacebookCalendarManager.swift
//  facebook_event_app
//
//  Created by jake on 11/22/20.
//

import Foundation

class FacebookCalendarManager {
    static func getCalendar() -> FacebookCalendar {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "MST")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        var events: Array<Event> = []
        
        if let filepath = Bundle.main.path(forResource: "mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .mappedIfSafe)
                
                events = try decoder.decode([Event].self, from: data)
            } catch {
                print(error)
            }
        } else {
            
        }
        
        ///Sort events by date
        events.sort(by: {$0.start < $1.start})
        
        let dates = DateHelpers.uniqueDaysFrom(dates: events.map { $0.start })
        
        var calendarDays: [FacebookCalendarDay] = []
        for date in dates {
            let eventsOnDate = events.filter { $0.start.withoutTime() == date.withoutTime() }
            let newDay = FacebookCalendarDay(day: date, events: eventsOnDate)
            calendarDays.append(newDay)
        }
        
        return FacebookCalendar(calendarDays: calendarDays)
    }
}
