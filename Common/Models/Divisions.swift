//
//  Divisions.swift
//  Footbalify
//
//  Created by Adam Jassak on 09/07/2024.
//

import Foundation

/// List of all NFC divisions
enum Divisions: String {
    case mainAfc = "AFC"
    case mainNfc = "NFC"
    case afcNorth = "AFC North"
    case afcSouth = "AFC South"
    case afcEast = "AFC East"
    case afcWest = "AFC West"
    case nfcNorth = "NFC North"
    case nfcSouth = "NFC South"
    case nfcEast = "NFC East"
    case nfcWest = "NFC West"
    case other = "TBD"
}

extension Divisions {
    var baseName: String {
        switch self {
        case .mainAfc:
            "American"
        case .mainNfc:
            "National"
        case .afcNorth:
            "American North"
        case .afcSouth:
            "American South"
        case .afcEast:
            "American East"
        case .afcWest:
            "American West"
        case .nfcNorth:
            "National North"
        case .nfcSouth:
            "National South"
        case .nfcEast:
            "National East"
        case .nfcWest:
            "National West"
        case .other:
            "TBD"
        }
    }
}
