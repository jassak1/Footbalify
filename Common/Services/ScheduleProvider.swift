//
//  ScheduleProvider.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import Foundation
import OSLog

/// Protocol defining NFL Schedule Provider's methods and properties
protocol ScheduleProviderProto {
    /// Method responsible for retrieving NFL Schedule for specific week from default/Bundled JSON file
    ///
    ///  - Parameters:
    ///     - week: Week for which the NFL Schedule will be retrieved
    ///  - Returns: Array of Schedule Events associated with specific week stored in Bundled JSON file
    func getDefaultSchedule(week: ScheduleTitle) -> [Event]

    /// Transforms JSON based schedule into `MatchInfo` type one
    ///
    ///  - Parameters:
    ///     - schedule: Collection of `Event` as read from JSON file
    ///  - Returns: Array of `MatchInfo` schedule
    func transformSchedule(schedule: [Event]) -> [MatchInfo]

    /// Method responsible for retrieval of Playoff's schedule based on conference on a Week
    ///
    ///  - Parameters:
    ///     - baseSchedule: Collection of `Event` as read from JSON file
    ///     - week: `ScheduleTitle` value representing week of a PlayOff
    ///     - conference: AFC/NFC NFL Conference
    ///
    ///  - Returns: Collection of `MatchInfo` holding NFL Schedule
    func getSchedule(baseSchedule: [Event],
                     week: ScheduleTitle,
                     conference: Divisions) -> [MatchInfo]

    /// Method responsible for returning `ScheduleTitle` value, indicating Current NFL Week
    /// based on a Calendar Date of a device
    ///
    ///  - Returns: `ScheduleTitle` value with current week
    func getCurrWeek() -> ScheduleTitle
}

/// Implementation of NFL Schedule Provider Protocol
struct ScheduleProvider: ScheduleProviderProto {
    func getDefaultSchedule(week: ScheduleTitle) -> [Event] {
        do {
            let bundledData = try Bundle.getDataContent(of: week.toJsonFile)
            let decodedJson: ScheduleScoreboard = try JSONDecoder.decodeJson(data: bundledData)
            return decodedJson.events
        } catch {
            Logger.generic.error("\(error)")
            return []
        }
    }

    func transformSchedule(schedule: [Event]) -> [MatchInfo] {
        guard !schedule.isEmpty else {
            Logger.generic.warning("Empty collection found")
            return []
        }

        return schedule.map {
            MatchInfo(team1: $0.competitions[0].competitors[1].team.teamEnumVal,
                      team2: $0.competitions[0].competitors[0].team.teamEnumVal,
                      matchDate: $0.date,
                      score1: $0.competitions[0].competitors[1].score,
                      score2: $0.competitions[0].competitors[0].score,
                      gameCompleted: $0.competitions[0].status.type.completed)
        }
    }

    func getSchedule(baseSchedule: [Event],
                     week: ScheduleTitle,
                     conference: Divisions) -> [MatchInfo] {

        var filteredSchedule = transformSchedule(schedule: baseSchedule).filter {
            ($0.team1.conference == conference && $0.team2.conference == conference) ||
            ($0.team1.conference == conference && $0.team2.conference == .other) ||
            ($0.team1.conference == .other && $0.team2.conference == conference)
        }
        switch week {
        case .wildCard:
            while filteredSchedule.count < 3 {
                filteredSchedule.append(.demoInfo)
            }
        case .divRd:
            while filteredSchedule.count < 2 {
                filteredSchedule.append(.demoInfo)
            }
        case .confChamp:
            while filteredSchedule.count < 1 {
                filteredSchedule.append(.demoInfo)
            }
        default:
            while filteredSchedule.count < 3 {
                filteredSchedule.append(.demoInfo)
            }
        }
        return filteredSchedule
    }

    func getCurrWeek() -> ScheduleTitle {
        return if Date() > WeekDates.superBowl {
            .superBowl
        } else if Date() > WeekDates.confChamp {
            .confChamp
        } else if Date() > WeekDates.divisRound {
            .divRd
        } else if Date() > WeekDates.wildCard {
            .wildCard
        } else if Date() > WeekDates.week18 {
            .week18
        } else if Date() > WeekDates.week17 {
            .week17
        } else if Date() > WeekDates.week16 {
            .week16
        } else if Date() > WeekDates.week15 {
            .week15
        } else if Date() > WeekDates.week14 {
            .week14
        } else if Date() > WeekDates.week13 {
            .week13
        } else if Date() > WeekDates.week12 {
            .week12
        } else if Date() > WeekDates.week11 {
            .week11
        } else if Date() > WeekDates.week10 {
            .week10
        } else if Date() > WeekDates.week9 {
            .week9
        } else if Date() > WeekDates.week8 {
            .week8
        } else if Date() > WeekDates.week7 {
            .week7
        } else if Date() > WeekDates.week6 {
            .week6
        } else if Date() > WeekDates.week5 {
            .week5
        } else if Date() > WeekDates.week4 {
            .week4
        } else if Date() > WeekDates.week3 {
            .week3
        } else if Date() > WeekDates.week2 {
            .week2
        } else {
            .week1
        }
    }
}
