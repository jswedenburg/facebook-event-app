//
//  Event.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import Foundation

struct Event: Decodable, Hashable {
    let title: String
    let start: Date
    let end: Date
    
}

extension Event {
    var startHour: String {
        get {
            return eventDateString(date: start)
        }
    }
    
    var endHour: String {
        get {
            return eventDateString(date: end)
        }
    }
    
    var eventSectionHeader: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d"
            return dateFormatter.string(from: start)
        }
    }
    
    private func eventDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    static func doesOverlap(event: Event, otherEvent: Event) -> Bool {
        return (event.start < otherEvent.end && otherEvent.start < event.end)
    }
}

extension Event: Equatable {
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.title == rhs.title && lhs.start == rhs.start && lhs.end == rhs.end
    }
}

