//
//  StandingsInfo.swift
//  Footbalify
//
//  Created by Adam Jassak on 13/07/2024.
//

import Foundation

/// Custom type holding NFL Standings info
struct StandingsInfo {
    let team: Teams
    let wins: String
    let loses: String
    let ties: String
    let percentage: String
    let position: String

    /// Demo instance of `StandingsInfo`
    static var demoInfo: Self {
        Self(team: .other,
             wins: "0",
             loses: "0",
             ties: "0",
             percentage: "0",
             position: "0")
    }
}
