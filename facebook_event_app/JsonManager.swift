//
//  JsonManager.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import Foundation

class JsonManager {
    static func retrieveEventData() -> Data? {
        if let filepath = Bundle.main.path(forResource: "mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath), options: .mappedIfSafe)
            } catch {
                return nil
            }
        } else {
            return nil
        }
        return Data()
    }
}
