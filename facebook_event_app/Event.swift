//
//  Event.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import Foundation

struct Event: Decodable {
    let title: String
    let start: Date
    let end: Date
    
    var startHour: String {
        get {
            return start.eventDateString()
        }
    }
    
    var endHour: String {
        get {
            return end.eventDateString()
        }
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

