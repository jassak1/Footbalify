//
//  SeasonStandings.swift
//  Footbalify
//
//  Created by Adam Jassak on 13/07/2024.
//

import Foundation

// MARK: - Codable Structures used within NFL Standings JSONs
struct SeasonStandings: Codable {
    let children: [StandingsChildren]
}

struct StandingsChildren: Codable {
    let abbreviation: String
    let standings: ConferenceStandings
}

struct ConferenceStandings: Codable {
    let name: String
    let entries: [ConferenceEntries]
}

struct ConferenceEntries: Codable {
    let team: ConferenceTeam
    let stats: [ConferenceStats]
}

struct ConferenceTeam: Codable {
    let displayName: String
}

struct ConferenceStats: Codable {
    let name: String
    let displayValue: String
}


