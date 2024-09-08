//
//  StandingsVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import SwiftUI
import OSLog

/// Standing's ViewModel
class StandingsVM: ObservableObject {
    /// StandingsProvider service reference
    private var standingsProvider: StandingsProviderProto
    /// ScheduleProvider service reference
    private var scheduleProvider: ScheduleProviderProto
    /// Observable property holding Season Standings collection
    @Published var standingsActual = [Dictionary<String, [StandingsInfo]>.Element]()
    /// Observable property holding currently selected Standings switch
    @Published var standingSelection = StandingsType.division

    /// Method responsible for displaying specific NFL Standings
    ///
    ///  - Parameters:
    ///     - selection: `StandingsType` value indicating what sort of Standings to be displayed
    func displayStandings(selection: StandingsType) {
        standingSelection = selection
        let rawStandings = standingsProvider.getFallbackStandings()
        switch selection {
        case .division:
            standingsActual.removeAll()
            let afcEast = [Divisions.afcEast.rawValue: standingsProvider.getStandings(for: .afcEast, standings: rawStandings)]
            let afcNorth = [Divisions.afcNorth.rawValue: standingsProvider.getStandings(for: .afcNorth, standings: rawStandings)]
            let afcSouth = [Divisions.afcSouth.rawValue: standingsProvider.getStandings(for: .afcSouth, standings: rawStandings)]
            let afcWest = [Divisions.afcWest.rawValue: standingsProvider.getStandings(for: .afcWest, standings: rawStandings)]
            let nfcEast = [Divisions.nfcEast.rawValue: standingsProvider.getStandings(for: .nfcEast, standings: rawStandings)]
            let nfcNorth = [Divisions.nfcNorth.rawValue: standingsProvider.getStandings(for: .nfcNorth, standings: rawStandings)]
            let nfcSouth = [Divisions.nfcSouth.rawValue: standingsProvider.getStandings(for: .nfcSouth, standings: rawStandings)]
            let nfcWest = [Divisions.nfcWest.rawValue: standingsProvider.getStandings(for: .nfcWest, standings: rawStandings)]
            standingsActual.insert(contentsOf: afcEast, at: 0)
            standingsActual.insert(contentsOf: afcNorth, at: 1)
            standingsActual.insert(contentsOf: afcSouth, at: 2)
            standingsActual.insert(contentsOf: afcWest, at: 3)
            standingsActual.insert(contentsOf: nfcEast, at: 4)
            standingsActual.insert(contentsOf: nfcNorth, at: 5)
            standingsActual.insert(contentsOf: nfcSouth, at: 6)
            standingsActual.insert(contentsOf: nfcWest, at: 7)
        case .conference:
            standingsActual.removeAll()
            let afcFull = [Divisions.mainAfc.rawValue: standingsProvider.getStandings(for: .mainAfc, standings: rawStandings)]
            let nfcFull = [Divisions.mainNfc.rawValue: standingsProvider.getStandings(for: .mainNfc, standings: rawStandings)]
            standingsActual.insert(contentsOf: afcFull, at: 0)
            standingsActual.insert(contentsOf: nfcFull, at: 1)
        case .playOff:
            standingsActual.removeAll()
        }
    }

    /// Method providing NFL Division's Logo
    ///
    ///  - Parameters:
    ///     - division: String idenifying specific NFL division
    ///
    ///  - Returns: String describing Division's Logo
    func getDivisionsLogo(division: String) -> String {
        let division = Divisions(rawValue: division) ?? .mainAfc
        return switch division {
        case .mainAfc:
            "\(Divisions.mainAfc.rawValue) \(AppConstant.logo.rawValue)"
        case .mainNfc:
            "\(Divisions.mainNfc.rawValue) \(AppConstant.logo.rawValue)"
        case .afcNorth:
            "\(Divisions.mainAfc.rawValue) \(AppConstant.logo.rawValue)"
        case .afcSouth:
            "\(Divisions.mainAfc.rawValue) \(AppConstant.logo.rawValue)"
        case .afcEast:
            "\(Divisions.mainAfc.rawValue) \(AppConstant.logo.rawValue)"
        case .afcWest:
            "\(Divisions.mainAfc.rawValue) \(AppConstant.logo.rawValue)"
        case .nfcNorth:
            "\(Divisions.mainNfc.rawValue) \(AppConstant.logo.rawValue)"
        case .nfcSouth:
            "\(Divisions.mainNfc.rawValue) \(AppConstant.logo.rawValue)"
        case .nfcEast:
            "\(Divisions.mainNfc.rawValue) \(AppConstant.logo.rawValue)"
        case .nfcWest:
            "\(Divisions.mainNfc.rawValue) \(AppConstant.logo.rawValue)"
        case .other:
            "\(Divisions.other.rawValue) \(AppConstant.logo.rawValue)"
        }
    }

    /// Method responsible for retrieval of Playoff's schedule based on conference on a Week
    ///
    ///  - Parameters:
    ///     - week: `ScheduleTitle` value representing week of a PlayOff
    ///     - conference: AFC/NFC NFL Conference
    ///
    ///  - Returns: Collection of `MatchInfo` holding NFL Schedule
    func getSchedule(week: ScheduleTitle, conference: Divisions) -> [MatchInfo] {
        let baseSchedule = scheduleProvider.getFallbackSchedule(week: week)
        return scheduleProvider.getSchedule(baseSchedule: baseSchedule,
                                            week: week,
                                            conference: conference)
    }

    // MARK: - Initialiser
    init(standingsProvider: StandingsProviderProto,
         scheduleProvider: ScheduleProviderProto) {
        self.standingsProvider = standingsProvider
        self.scheduleProvider = scheduleProvider
        displayStandings(selection: .division)
    }
}
