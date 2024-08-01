//
//  WeekDates.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import Foundation

/// Custom type holding all starting dates for NFL Weeks in a 2024 Season
struct WeekDates {
    static let week1 = DateFormatter.ISO8601NoSeconds.date(from: "2023-09-11T07:00Z") ?? Date()
    static let week2 = DateFormatter.ISO8601NoSeconds.date(from: "2024-09-11T07:00Z") ?? Date()
    static let week3 = DateFormatter.ISO8601NoSeconds.date(from: "2024-09-18T07:00Z") ?? Date()
    static let week4 = DateFormatter.ISO8601NoSeconds.date(from: "2024-09-25T07:00Z") ?? Date()
    static let week5 = DateFormatter.ISO8601NoSeconds.date(from: "2024-10-02T07:00Z") ?? Date()
    static let week6 = DateFormatter.ISO8601NoSeconds.date(from: "2024-10-09T07:00Z") ?? Date()
    static let week7 = DateFormatter.ISO8601NoSeconds.date(from: "2024-10-16T07:00Z") ?? Date()
    static let week8 = DateFormatter.ISO8601NoSeconds.date(from: "2024-10-23T07:00Z") ?? Date()
    static let week9 = DateFormatter.ISO8601NoSeconds.date(from: "2024-10-30T07:00Z") ?? Date()
    static let week10 = DateFormatter.ISO8601NoSeconds.date(from: "2024-11-06T08:00Z") ?? Date()
    static let week11 = DateFormatter.ISO8601NoSeconds.date(from: "2024-11-13T08:00Z") ?? Date()
    static let week12 = DateFormatter.ISO8601NoSeconds.date(from: "2024-11-20T08:00Z") ?? Date()
    static let week13 = DateFormatter.ISO8601NoSeconds.date(from: "2024-11-27T08:00Z") ?? Date()
    static let week14 = DateFormatter.ISO8601NoSeconds.date(from: "2024-12-04T08:00Z") ?? Date()
    static let week15 = DateFormatter.ISO8601NoSeconds.date(from: "2024-12-11T08:00Z") ?? Date()
    static let week16 = DateFormatter.ISO8601NoSeconds.date(from: "2024-12-18T08:00Z") ?? Date()
    static let week17 = DateFormatter.ISO8601NoSeconds.date(from: "2024-12-25T08:00Z") ?? Date()
    static let week18 = DateFormatter.ISO8601NoSeconds.date(from: "2025-01-01T08:00Z") ?? Date()
    static let wildCard = DateFormatter.ISO8601NoSeconds.date(from: "2025-01-08T08:00Z") ?? Date()
    static let divisRound = DateFormatter.ISO8601NoSeconds.date(from: "2025-01-17T08:00Z") ?? Date()
    static let confChamp = DateFormatter.ISO8601NoSeconds.date(from: "2025-01-24T08:00Z") ?? Date()
    static let superBowl = DateFormatter.ISO8601NoSeconds.date(from: "2025-01-31T08:00Z") ?? Date()
}
