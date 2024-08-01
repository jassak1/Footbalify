//
//  MatchInfo.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import Foundation

/// Custom type holding info about a NFL match
struct MatchInfo {
    var team1: Teams
    var team2: Teams
    var matchDate: Date
    var score1: String
    var score2: String
    var gameCompleted: Bool

    /// Demo instance of `MatchInfo`
    static var demoInfo: Self {
        Self(team1: .other,
             team2: .other,
             matchDate: Date(),
             score1: "0",
             score2: "0",
             gameCompleted: false)
    }

    /// WidgetKit Placeholder instance of `MatchInfo`
    static var placeholderInstance: [Self] {
        let provider = ScheduleProvider()
        let baseCollection = provider.getDefaultSchedule(week: .week1)
        let transformedSchedule = provider.transformSchedule(schedule: baseCollection)
        return transformedSchedule
    }
}
