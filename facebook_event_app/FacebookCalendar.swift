//
//  Calendar.swift
//  facebook_event_app
//
//  Created by jake on 11/21/20.
//

import Foundation

struct FacebookCalendar {
    var events: [Event]
    var dates: [Date]
    
    func eventsOccuringOn(date: Date) -> Array<Event> {
        return events.filter { $0.start.withoutTime() == date.withoutTime() }
    }
    
    func conflictingEvents() -> [Event] {
        
        var conflictingEvents: [Event] = []
        
        for event in events {
            
            for otherEvent in events {
                if (Event.doesOverlap(event: event, otherEvent: otherEvent) && event != otherEvent) {
                    conflictingEvents.append(otherEvent)
                }
            }
        }
        return conflictingEvents
    }
    
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
        
        events.sort(by: {$0.start < $1.start})
        
        let dates = DateHelpers.uniqueDaysFrom(dates: events.map { $0.start })
        
        return FacebookCalendar(events: events, dates: dates)
    }
    
    
}
