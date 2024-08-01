//
//  ScheduleScoreboard.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

// MARK: - Codable Structures used within NFL Schedule Scoreboard JSONs
struct ScheduleScoreboard: Codable {
    let events: [Event]
}

struct Event: Codable {
    let date: Date
    let name: String
    let shortName: String
    let competitions: [Competitions]
}

struct Competitions: Codable {
    let date: Date
    let competitors: [Competitors]
    let status: GameStatus
}

struct Competitors: Codable {
    let homeAway: String
    let team: TeamOponent
    let score: String
}

struct TeamOponent: Codable {
    let abbreviation: String
    let displayName: String
    var teamEnumVal: Teams {
        Teams.teamFromFullName(name: displayName)
    }
}

struct GameStatus: Codable {
    let type: GameType
}

struct GameType: Codable {
    let completed: Bool
}
