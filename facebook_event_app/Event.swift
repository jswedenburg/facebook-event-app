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
    
    static func getAllEvents() -> Array<Event> {
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
                return []
            }
        } else {
            return []
        }
        return events
    }
}

