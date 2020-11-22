//
//  Calendar.swift
//  facebook_event_app
//
//  Created by jake on 11/21/20.
//

import Foundation

struct FacebookCalendar {
    var calendarDays:[FacebookCalendarDay]
}

struct FacebookCalendarDay {
    var day:Date
    var events: [Event]
}

extension FacebookCalendarDay {
    func conflictingEvents() -> [Event] {
        
        ///Assume confilcting events will only occur during same day
        var conflictingEvents: Set<Event> = []
        
        ///This is a logarithmic time algorithm O(log n), as it iterates over the set the remaining events array becomes smaller thus reducing the amont of time 
        for (index, event) in events.enumerated() {
            let remainingEvents = events[index+1..<events.count]
            for otherEvent in remainingEvents {
                if (Event.doesOverlap(event: event, otherEvent: otherEvent)) {
                    conflictingEvents.insert(otherEvent)
                    conflictingEvents.insert(event)
                }
            }
        }
        return Array(conflictingEvents)
    }
    
    func findEventMatch(events: [Event]) {
        
    }
}


