//
//  StandingsType.swift
//  Footbalify
//
//  Created by Adam Jassak on 13/07/2024.
//

import Foundation

/// List of available NFL Season Standings data
enum StandingsType: String, CaseIterable {
    case division = "Division"
    case conference = "Conference"
    case playOff = "Playoff"
}
