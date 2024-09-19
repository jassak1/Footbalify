//
//  WidgetKind.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import Foundation

/// Collection of Widget Kinds
enum WidgetKind: String, CaseIterable {
    case playoffLarge1 = "American & National Conference Playoffs Simple"
    case playoffLarge2 = "American & National Conference Playoff Extended"
    case superBowlMedium = "Football League Super Bowl Bracket"
    case divisionLeadersLarge1 = "American & National Division Standings Extended"
    case divisionLeadersMedium1 = "American & National Division Standings Simple"
    case divisionLeaderSmall = "American & National Division Standings Leader"
    case playoffMedium3 = "American & National Conference Playoff Projection"
    case scheduleFullLarge = "Football League Matches Week Schedule"
    case teamScheduleMedium = "Football League Weekly Team Schedule Extended"
    case teamScheduleSmall = "Football League Weekly Team Schedule Simple"
    case teamStandingsMd = "Football League Specific Team Standings Extended"
    case teamStandingsSm = "Football League Specific Team Standings Simple"
    case superBowlCountdownSm = "Countdown to Super Bowl LIX"
    case lockSuperBowlCountdownSm = "Super Bowl Countdown"
    case lockTeamStandingsSm = "Football League Team Standings"
    case lockTeamStandingsMd = "Football League Team Standings Detailed"
    case lockTeamScheduleMd = "Team's Weekly Schedule"
    case lockDivisionMd = "Football League Divisions Standings"


    /// Static property holding list of Small sized Widgets
    static var smallWidgets: [Self] = [
        .divisionLeaderSmall, .teamScheduleSmall, .teamStandingsSm,
        .superBowlCountdownSm
    ]

    /// Static property holding list of Medium sized Widgets
    static var mediumWidgets: [Self] = [
        .superBowlMedium, .divisionLeadersMedium1, .playoffMedium3,
        .teamScheduleMedium, .teamStandingsMd
    ]

    /// Static property holding list of Large sized Widgets
    static var largeWidgets: [Self] = [
        .playoffLarge1, .playoffLarge2, .divisionLeadersLarge1,
        .scheduleFullLarge
    ]

    /// Static property holding list of LockScreen Widgets
    static var lockScreenWidgets: [Self] = [
        .lockSuperBowlCountdownSm, .lockTeamStandingsSm, .lockTeamStandingsMd,
        .lockTeamScheduleMd, .lockDivisionMd
    ]
}
