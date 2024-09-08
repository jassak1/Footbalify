//
//  WidgetVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import SwiftUI

/// ViewModel class for all Widgets
class WidgetVM: ObservableObject {
    // MARK: - Properties
    /// ScheduleProvider reference
    var scheduleProvider: ScheduleProviderProto
    /// StandingsProvider reference
    var standingsProvider: StandingsProviderProto

    // MARK: - Methods
    /// Method responsible for retrieval of Playoff's schedule based on conference and a Week
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

    /// Method responsible for retrieving NFL Champion of provided Conference
    ///
    ///  - Parameters:
    ///     - conference: NFL's Conference
    ///
    ///  - Returns: NFL `Teams` team that has been crowned Conference's champion
    func getConferenceChampion(conference: Divisions) -> Teams {
        let baseSchedule = scheduleProvider.getFallbackSchedule(week: .superBowl)
        let transformedSchedule = scheduleProvider.transformSchedule(schedule: baseSchedule)
        return transformedSchedule.map {
            if $0.team1.conference == conference {
                return $0.team1
            } else {
                return $0.team2
            }
        }.first ?? .other
    }

    /// Method responsible for providing Team's logo asset name
    ///
    ///  - Parameters:
    ///     - teams: `Team` value defining NFL team
    ///
    ///  - Returns: String value defining team's logo Asset name
    func getTeamLogo(team: Teams) -> String {
        "\(team.fullName) \(AppConstant.logo.rawValue)"
    }

    /// Method responsible for providing Team's color asset name
    ///
    ///  - Parameters:
    ///     - teams: `Team` value defining NFL team
    ///
    ///  - Returns: String value defining team's color Asset name
    func getTeamColor(team: Teams) -> String {
        "\(team.fullName) \(AppConstant.color.rawValue)"
    }

    /// Method responsible for providing Conference's gradient colors
    ///
    ///  - Parameters:
    ///     - division: NFL Team's Division
    ///
    ///  - Returns: Collection of Conference's Colors
    func getConferenceColors(division: DivTeam) -> [Color] {
        return if division.toConference == .mainAfc {
            [.washingtonCommanders.opacity(0.85),
                    .washingtonCommanders.opacity(0.75)]
        } else {
            [.colorMainFg.opacity(0.85),
             .colorMainFg.opacity(0.75)]
        }
    }

    /// Method responsible for retrieval of NFL Standings based on a division
    ///
    ///  - Parameters:
    ///     - division: NFL Division that will be used as Standings filter
    ///
    ///  - Returns: Collection of `StandingsInfo` objects
    func getStandings(for division: Divisions) -> [StandingsInfo] {
        let rawStandings = standingsProvider.getFallbackStandings()
        return standingsProvider.getStandings(for: division, standings: rawStandings)
    }

    /// Method responsible for retrieval of NFL Standings top team based on a division
    ///
    ///  - Parameters:
    ///     - division: NFL Division that will be used as Standings filter
    ///
    ///  - Returns: `StandingsInfo` object with data of top team in a division
    func getDivisionLeader(for division: Divisions) -> StandingsInfo {
        let rawStandings = standingsProvider.getFallbackStandings()
        let transformedStandings = standingsProvider.getStandings(for: division, standings: rawStandings)
        return transformedStandings.first ?? .demoInfo
    }

    /// Method responsible for providing weekly NFL Schedule associated with specific NFL Team
    ///
    ///  - Parameters:
    ///     - team: NFL Team for whom the weekly schedule will be retrieved
    ///     - week: NFL Week
    ///
    ///  - Returns: Collection of a weekly schedule associated with specific NFL Team
    func getTeamsSchedule(team: NFLTeam, week: ScheduleTitle) -> [MatchInfo] {
        let baseSchedule = scheduleProvider.getFallbackSchedule(week: week)
        let transformedSchedule = scheduleProvider.transformSchedule(schedule: baseSchedule)
        return transformedSchedule.filter {
            $0.team1 == team.toTeam ||
            $0.team2 == team.toTeam
        }
    }

    /// Method responsible for getting specific `StandingsInfo`, based on a provided Team
    ///
    ///  - Parameters:
    ///     - team: NFL Team used for filtering Standings collection
    ///
    ///  - Returns: `StandingsInfo` object associated with specific team
    func getTeamStandings(team: Teams) -> StandingsInfo {
        let rawStandings = standingsProvider.getFallbackStandings()
        return standingsProvider.getTeamStandings(team: team, standings: rawStandings)
    }

    // MARK: - Initialiser
    init(scheduleProvider: ScheduleProviderProto,
         standingsProvider: StandingsProviderProto) {
        self.scheduleProvider = scheduleProvider
        self.standingsProvider = standingsProvider
    }
}

