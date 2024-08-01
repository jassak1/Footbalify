//
//  WidgetKind.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import Foundation

/// Collection of Widget Kinds
enum WidgetKind: String, CaseIterable {
    case playoffLarge1 = "AFC & NFC Conference Playoffs Simple"
    case playoffLarge2 = "AFC & NFC Conference Playoff Extended"
    case superBowlMedium = "NFL Super Bowl Bracket"
    case divisionLeadersLarge1 = "AFC & NFC Division Standings Extended"
    case divisionLeadersMedium1 = "AFC & NFC Division Standings Simple"
    case divisionLeaderSmall = "AFC & NFC Division Standings Leader"
    case playoffMedium3 = "AFC & NFC Conference Playoff Projection"
    case scheduleFullLarge = "NFL Matches Week Schedule"
    case teamScheduleMedium = "NFL Weekly Team Schedule Extended"
    case teamScheduleSmall = "NFL Weekly Team Schedule Simple"
    case teamStandingsMd = "NFL Specific Team Standings Extended"
    case teamStandingsSm = "NFL Specific Team Standings Simple"
    case superBowlCountdownSm = "Countdown to Super Bowl LIX"
    case lockSuperBowlCountdownSm = "Super Bowl Countdown"
    case lockTeamStandingsSm = "NFL Team Standings"
    case lockTeamStandingsMd = "NFL Team Standings Detailed"
    case lockTeamScheduleMd = "Team's Weekly Schedule"
    case lockDivisionMd = "NFL Divisions Standings"


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
