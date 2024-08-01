//
//  ScheduleVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import SwiftUI
import OSLog

/// Schedule's ViewModel
class ScheduleVM: ObservableObject {
    /// Schedule Provider Service reference
    var scheduleProvider: ScheduleProviderProto
    /// Observable property holding all Matches for selected Week
    @Published var selectedSchedule = [Dictionary<Date, [MatchInfo]>.Element]()
    /// Observable property holding currently selected NFL Schedule week
    @Published var selectedWeek: ScheduleTitle = .week1

    // MARK: - Private methods
    /// Method responsible for loading Week's Schedule/Scores
    ///
    ///  - Parameters:
    ///     - week: Selected NFL week
    func loadWeekSchedule(week: ScheduleTitle) {
        print(week.rawValue)
        selectedWeek = week
        let baseSchedule = scheduleProvider.getDefaultSchedule(week: week)
        let groupedSchedule = groupSchedule(schedule: baseSchedule)
        selectedSchedule = groupedSchedule
    }

    /// Private method responsible for grouping Schedule into Dictionary Array. Key indicates Date of a match,
    /// while value indicates all available matches for given Date.
    ///
    ///  - Parameters:
    ///     - schedule: `ScheduleScoreboard` value for given Match week
    ///  - Returns: Dictionary Array - Key holding a Week date for set of matches available in a value of a Dictionary
    private func groupSchedule(schedule: [Event]) -> [Dictionary<Date, [MatchInfo]>.Element]  {
        var finalResult = [Date: [MatchInfo]]()
        /// Get Week dates only for grouped matches
        let uniqueDates = schedule.reduce(into: Set<Date>()) {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: $1.date)
            if let date = Calendar.current.date(from: dateComponents) {
                $0.insert(date)
            }
        }

        _ = uniqueDates.map { uniqueDate in
            let filteredMatches = schedule.filter { event in
                Calendar.current.isDate(uniqueDate, inSameDayAs: event.date)
            }

            let finalMatchInfo = scheduleProvider.transformSchedule(schedule: filteredMatches)
            finalResult[uniqueDate] = finalMatchInfo
        }

        return finalResult.sorted {
            $0.key < $1.key
        }
    }

    /// Private method responsible for loading Week Schedule of Upcoming NFL Week
    /// closest to Device's Date
    private func loadCurrWeek() {
        let currWeek = scheduleProvider.getCurrWeek()
        loadWeekSchedule(week: currWeek)
    }

    // MARK: Initialiser
    init(scheduleProvider: ScheduleProviderProto) {
        self.scheduleProvider = scheduleProvider
        loadCurrWeek()
    }
}
