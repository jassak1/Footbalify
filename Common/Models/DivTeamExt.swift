//
//  DivTeamExt.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import Foundation

extension DivTeam {
    /// Computed property providing `Divisions` value associated with `DivTeam` value
    var toDivision: Divisions {
        return switch self {
        case .afcEast:
                .afcEast
        case .afcWest:
                .afcWest
        case .afcNorth:
                .afcNorth
        case .afcSouth:
                .afcSouth
        case .nfcNorth:
                .nfcNorth
        case .nfcSouth:
                .nfcSouth
        case .nfcWest:
                .nfcWest
        case .nfcEast:
                .nfcEast
        default:
                .other
        }
    }

    /// Computed property providing Conference value associated with specific Division
    var toConference: Divisions {
        return if [DivTeam.afcEast, DivTeam.afcWest,
                   DivTeam.afcNorth, DivTeam.afcSouth].contains(self) {
            .mainAfc
        } else {
            .mainNfc
        }
    }
}
