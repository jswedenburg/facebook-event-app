//
//  facebook_event_appTests.swift
//  facebook_event_appTests
//
//  Created by jake on 11/19/20.
//

import XCTest
@testable import facebook_event_app

class facebook_event_appTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEventJsonDeserializesCorrectly() {
        let events: [Event] = Event.getAllEvents()
        let firstEvent = events[0]
        
        let calendar = NSCalendar.current
        let startDateMonth = calendar.component(.month, from: firstEvent.start)
        let startDateDay = calendar.component(.day, from: firstEvent.start)
        let startDateYear = calendar.component(.year, from: firstEvent.start)
        let startDateHour = calendar.component(.hour, from: firstEvent.start)
        let startDateMinute = calendar.component(.minute, from: firstEvent.start)
        
        XCTAssertEqual(events.count, 21)
        XCTAssertEqual(firstEvent.title, "Evening Picnic")
        XCTAssertEqual(startDateMonth, 11)
        XCTAssertEqual(startDateDay, 10)
        XCTAssertEqual(startDateYear, 2018)
        XCTAssertEqual(startDateHour, 18)
        XCTAssertEqual(startDateMinute, 0)
    }

}
