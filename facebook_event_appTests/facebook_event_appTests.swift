//
//  facebook_event_appTests.swift
//  facebook_event_appTests
//
//  Created by jake on 11/19/20.
//

import XCTest
@testable import facebook_event_app

class facebook_event_appTests: XCTestCase {
    
    var facebookCalendar: FacebookCalendar!
    
    override func setUpWithError() throws {
        facebookCalendar = FacebookCalendarManager.getCalendar()
    }

    override func tearDownWithError() throws {
        facebookCalendar = nil
    }

    func testEventJsonDeserializesCorrectly() {
        let events: [Event] = facebookCalendar.calendarDays[0].events
        let firstEvent = events[0]
        
        let calendar = NSCalendar.current
        let startDateMonth = calendar.component(.month, from: firstEvent.start)
        let startDateDay = calendar.component(.day, from: firstEvent.start)
        let startDateYear = calendar.component(.year, from: firstEvent.start)
        let startDateHour = calendar.component(.hour, from: firstEvent.start)
        let startDateMinute = calendar.component(.minute, from: firstEvent.start)
        
        XCTAssertEqual(events.count, 3)
        XCTAssertEqual(firstEvent.title, "Bicycling with Friends")
        XCTAssertEqual(startDateMonth, 11)
        XCTAssertEqual(startDateDay, 1)
        XCTAssertEqual(startDateYear, 2018)
        XCTAssertEqual(startDateHour, 7)
        XCTAssertEqual(startDateMinute, 0)
    }
    
    func testConflictingEvents() {
        
        let calendar = NSCalendar.current
        let date1Components = DateComponents(year: 2018, month: 11, day: 7, hour: 9, minute: 0)
        let date1 = calendar.date(from: date1Components)!
        
        let date2Components = DateComponents(year: 2018, month: 11, day: 7, hour: 10, minute: 0)
        let date2 = calendar.date(from: date2Components)!
        
        let date3Components = DateComponents(year: 2018, month: 11, day: 7, hour: 10, minute: 0)
        let date3 = calendar.date(from: date3Components)!
        
        let date4Components = DateComponents(year: 2018, month: 11, day: 7, hour: 13, minute: 0)
        let date4 = calendar.date(from: date4Components)!
        
        let nonConfictingEvent1 = Event(title: "", start: date1, end: date2)
        let nonConfictingEvent2 = Event(title: "", start: date3, end: date4)
        
        
        XCTAssertEqual(Event.doesOverlap(event: nonConfictingEvent2, otherEvent: nonConfictingEvent1), false)
        
        let date5Components = DateComponents(year: 2018, month: 11, day: 7, hour: 9, minute: 0)
        let date5 = calendar.date(from: date5Components)!
        
        let date6Components = DateComponents(year: 2018, month: 11, day: 7, hour: 10, minute: 0)
        let date6 = calendar.date(from: date6Components)!
        
        let date7Components = DateComponents(year: 2018, month: 11, day: 7, hour: 9, minute: 30)
        let date7 = calendar.date(from: date7Components)!
        
        let date8Components = DateComponents(year: 2018, month: 11, day: 7, hour: 10, minute: 30)
        let date8 = calendar.date(from: date8Components)!
        
        let confictingEvent1 = Event(title: "", start: date5, end: date6)
        let confictingEvent2 = Event(title: "", start: date7, end: date8)
        
        XCTAssertEqual(Event.doesOverlap(event: confictingEvent2, otherEvent: confictingEvent1), true)
        
        XCTAssertEqual(facebookCalendar.calendarDays[0].conflictingEvents().count, 0)
        XCTAssertEqual(facebookCalendar.calendarDays[6].conflictingEvents().count, 3)
        
        
        
    }
    
    
    func testEventStartHour() {
        let calendar = NSCalendar.current
        let components = DateComponents(month: 11, day: 10, hour: 18, minute: 0)
        let testEvent = Event(title: "This is a test event", start: calendar.date(from: components)!, end: Date())
        XCTAssertEqual(testEvent.startHour, "6:00 PM")
    }
    
    func testNumberOfDaysInDates() {
        let calendar = NSCalendar.current
        let date1Components = DateComponents(month: 11, day: 10, hour: 18, minute: 0)
        let date1WithTime = calendar.date(from: date1Components)!
        
        let date2Components = DateComponents(month: 11, day: 10, hour: 7, minute: 45)
        let date2WithTime = calendar.date(from: date2Components)!
        
        let date3Components = DateComponents(month: 11, day: 9, hour: 7, minute: 45)
        let date3WithTime = calendar.date(from: date3Components)!
        
        let uniqueDays: Array<Date> = DateHelpers.uniqueDaysFrom(dates: [date1WithTime, date2WithTime, date3WithTime])
        
        XCTAssertEqual(uniqueDays.count, 2)
    }
    
    func testDateWithoutTime() {
        let calendar = NSCalendar.current
        let date1Components = DateComponents(month: 11, day: 10, hour: 18, minute: 0)
        let date1WithTime = calendar.date(from: date1Components)!
        let date1WithoutTime = date1WithTime.withoutTime()
        
        let date2Components = DateComponents(month: 11, day: 10, hour: 7, minute: 45)
        let date2WithTime = calendar.date(from: date2Components)!
        let date2WithoutTime = date2WithTime.withoutTime()
        
        let date3Components = DateComponents(month: 11, day: 9, hour: 7, minute: 45)
        let date3WithTime = calendar.date(from: date3Components)!
        let date3WithoutTime = date3WithTime.withoutTime()
        
        
    
        XCTAssertNotEqual(date1WithTime, date2WithTime)
        XCTAssertNotEqual(date1WithoutTime, date3WithoutTime)
        XCTAssertEqual(date1WithoutTime, date2WithoutTime)
        
        
    }

}
