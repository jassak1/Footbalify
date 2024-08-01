//
//  NFLTeamExt.swift
//  Footbalify
//
//  Created by Adam Jassak on 17/07/2024.
//

import Foundation

extension NFLTeam {
    /// Computed property matching `NFLTeam` value with associated `Teams` type value
    var toTeam: Teams {
        return switch self {
        case .unknown:
                .other
        case .ravens:
                .ravens
        case .steelers:
                .steelers
        case .colts:
                .colts
        case .texans:
                .texans
        case .titans:
                .titans
        case .jaguars:
                .jaguars
        case .lions:
                .lions
        case .vikings:
                .vikings
        case .saints:
                .saints
        case .falcons:
                .falcons
        case .patriots:
                .patriots
        case .jets:
                .jets
        case .panthers:
                .panthers
        case .buccaneers:
                .buccaneers
        case .bengals:
                .bengals
        case .browns:
                .browns
        case .packers:
                .packers
        case .bears:
                .bears
        case .commanders:
                .commanders
        case .cowboys:
                .cowboys
        case .raiders:
                .raiders
        case .broncos:
                .broncos
        case .giants:
                .giants
        case .eagles:
                .eagles
        case .cardinals:
                .cardinals
        case .seahawks:
                .seahawks
        case .ers:
                .ers
        case .rams:
                .rams
        case .chargers:
                .chargers
        case .chiefs:
                .chiefs
        case .dolphins:
                .dolphins
        case .bills:
                .bills
        }
    }
}
