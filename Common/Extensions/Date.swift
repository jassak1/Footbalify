//
//  Date.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import Foundation

extension Date {
    /// Computed property formatting given Date into 'DayName, Month, Day' format
    var scheduleHeader: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: self)
    }

    /// Computed property formatting given Date into 'DayName (abr), Month, Day' format
    var scheduleLabelDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: self)
    }

    /// Computer property formatting given Date into 'Hour:Minute:AM/PM' format
    var scheduleLabelTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        return formatter.string(from: self)
    }

    static var superBowlDate: Date {
        //2025-02-09T05:00Z
        let components = DateComponents(timeZone: .gmt,
        year: 2025,
        month: 2,
        day: 9,
        hour: 5)
        return Calendar.current.date(from: components) ?? Date()
    }
}
