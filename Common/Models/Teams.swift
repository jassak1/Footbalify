//
//  Teams.swift
//  Footbalify
//
//  Created by Adam Jassak on 09/07/2024.
//

import Foundation

/// List of all available Teams
enum Teams: String {
    case ravens
    case steelers
    case colts
    case texans
    case titans
    case jaguars
    case lions
    case vikings
    case saints
    case falcons
    case patriots
    case jets
    case panthers
    case buccaneers
    case bengals
    case browns
    case packers
    case bears
    case commanders
    case cowboys
    case raiders
    case broncos
    case giants
    case eagles
    case cardinals
    case seahawks
    case ers = "49ers"
    case rams
    case chargers
    case chiefs
    case dolphins
    case bills
    case other = "TBD"

    /// Computed property providing Team's full name
    var fullName: String {
        switch self {
        case .ravens:
            "Baltimore Ravens"
        case .steelers:
            "Pittsburgh Steelers"
        case .colts:
            "Indianapolis Colts"
        case .texans:
            "Houston Texans"
        case .titans:
            "Tennessee Titans"
        case .jaguars:
            "Jacksonville Jaguars"
        case .lions:
            "Detroit Lions"
        case .vikings:
            "Minnesota Vikings"
        case .saints:
            "New Orleans Saints"
        case .falcons:
            "Atlanta Falcons"
        case .patriots:
            "New England Patriots"
        case .jets:
            "New York Jets"
        case .panthers:
            "Carolina Panthers"
        case .buccaneers:
            "Tampa Bay Buccaneers"
        case .bengals:
            "Cincinnati Bengals"
        case .browns:
            "Cleveland Browns"
        case .packers:
            "Green Bay Packers"
        case .bears:
            "Chicago Bears"
        case .commanders:
            "Washington Commanders"
        case .cowboys:
            "Dallas Cowboys"
        case .raiders:
            "Las Vegas Raiders"
        case .broncos:
            "Denver Broncos"
        case .giants:
            "New York Giants"
        case .eagles:
            "Philadelphia Eagles"
        case .cardinals:
            "Arizona Cardinals"
        case .seahawks:
            "Seattle Seahawks"
        case .ers:
            "San Francisco 49ers"
        case .rams:
            "Los Angeles Rams"
        case .chargers:
            "Los Angeles Chargers"
        case .chiefs:
            "Kansas City Chiefs"
        case .dolphins:
            "Miami Dolphins"
        case .bills:
            "Buffalo Bills"
        case .other:
            "TBD"
        }
    }

    /// Computed property providing Team's abbreviation name
    var abbrevName: String {
        switch self {
        case .ravens:
            "BAL"
        case .steelers:
            "PIT"
        case .colts:
            "IND"
        case .texans:
            "HOU"
        case .titans:
            "TEN"
        case .jaguars:
            "JAX"
        case .lions:
            "DET"
        case .vikings:
            "MIN"
        case .saints:
            "NO"
        case .falcons:
            "ATL"
        case .patriots:
            "NE"
        case .jets:
            "NYJ"
        case .panthers:
            "CAR"
        case .buccaneers:
            "TB"
        case .bengals:
            "CIN"
        case .browns:
            "CLE"
        case .packers:
            "GB"
        case .bears:
            "CHI"
        case .commanders:
            "WSH"
        case .cowboys:
            "DAL"
        case .raiders:
            "LV"
        case .broncos:
            "DEN"
        case .giants:
            "NYG"
        case .eagles:
            "PHI"
        case .cardinals:
            "ARI"
        case .seahawks:
            "SEA"
        case .ers:
            "SF"
        case .rams:
            "LAR"
        case .chargers:
            "LAC"
        case .chiefs:
            "KC"
        case .dolphins:
            "MIA"
        case .bills:
            "BUF"
        case .other:
            "TBD"
        }
    }

    /// Computed property providing Team's division
    var division: Divisions {
        switch self {
        case .ravens:
                .afcNorth
        case .steelers:
                .afcNorth
        case .colts:
                .afcSouth
        case .texans:
                .afcSouth
        case .titans:
                .afcSouth
        case .jaguars:
                .afcSouth
        case .lions:
                .nfcNorth
        case .vikings:
                .nfcNorth
        case .saints:
                .nfcSouth
        case .falcons:
                .nfcSouth
        case .patriots:
                .afcEast
        case .jets:
                .afcEast
        case .panthers:
                .nfcSouth
        case .buccaneers:
                .nfcSouth
        case .bengals:
                .afcNorth
        case .browns:
                .afcNorth
        case .packers:
                .nfcNorth
        case .bears:
                .nfcNorth
        case .commanders:
                .nfcEast
        case .cowboys:
                .nfcEast
        case .raiders:
                .afcWest
        case .broncos:
                .afcWest
        case .giants:
                .nfcEast
        case .eagles:
                .nfcEast
        case .cardinals:
                .nfcWest
        case .seahawks:
                .nfcWest
        case .ers:
                .nfcWest
        case .rams:
                .nfcWest
        case .chargers:
                .afcWest
        case .chiefs:
                .afcWest
        case .dolphins:
                .afcEast
        case .bills:
                .afcEast
        case .other:
                .other
        }
    }

    /// Computed property providing Team's Conference
    var conference: Divisions {
        if [Divisions.afcEast, Divisions.afcNorth,
            Divisions.afcWest, Divisions.afcSouth].contains(self.division) {
            return .mainAfc
        } else if self.division == .other {
            return .other
        } else {
            return .mainNfc
        }
    }

    /// Static method providing NFL Team from `Teams` Enum based on Team's String name
    static func teamFromFullName(name: String) -> Self {
        switch name {
        case ravens.fullName:
                .ravens
        case steelers.fullName:
                .steelers
        case colts.fullName:
                .colts
        case texans.fullName:
                .texans
        case titans.fullName:
                .titans
        case jaguars.fullName:
                .jaguars
        case lions.fullName:
                .lions
        case vikings.fullName:
                .vikings
        case saints.fullName:
                .saints
        case falcons.fullName:
                .falcons
        case patriots.fullName:
                .patriots
        case jets.fullName:
                .jets
        case panthers.fullName:
                .panthers
        case buccaneers.fullName:
                .buccaneers
        case bengals.fullName:
                .bengals
        case browns.fullName:
                .browns
        case packers.fullName:
                .packers
        case bears.fullName:
                .bears
        case commanders.fullName:
                .commanders
        case cowboys.fullName:
                .cowboys
        case raiders.fullName:
                .raiders
        case broncos.fullName:
                .broncos
        case giants.fullName:
                .giants
        case eagles.fullName:
                .eagles
        case cardinals.fullName:
                .cardinals
        case seahawks.fullName:
                .seahawks
        case ers.fullName:
                .ers
        case rams.fullName:
                .rams
        case chargers.fullName:
                .chargers
        case chiefs.fullName:
                .chiefs
        case dolphins.fullName:
                .dolphins
        case bills.fullName:
                .bills
        default:
                .other

        }
    }
}
