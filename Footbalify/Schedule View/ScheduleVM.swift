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
    /// Network Service reference
    var networkService: NetworkServiceProto
    /// Observable property holding all Matches for selected Week
    @Published var selectedSchedule = [Dictionary<Date, [MatchInfo]>.Element]()
    /// Observable property holding currently selected NFL Schedule week
    @Published var selectedWeek: ScheduleTitle = .week1
    /// Boolean observer indicating whether to display InApp Screen's sheet
    @Published var showSheet = false
    /// Boolean property indicating whether Color shall be used over NFL Team Logos
    @Published var useColors = UserDefaults.getValue(for: .useColors, defaultValue: false)

    // MARK: - Public methods
    /// Method called upon View Appears
    func onAppear() {
        useColors = UserDefaults.getValue(for: .useColors, defaultValue: false)
    }

    // MARK: - Private methods
    /// Method responsible for loading Week's Schedule/Scores
    ///
    ///  - Parameters:
    ///     - week: Selected NFL week
    func loadWeekSchedule(week: ScheduleTitle) {
        selectedWeek = week
        let fallbackSchedule = scheduleProvider.getFallbackSchedule(week: week)
        let groupedSchedule = groupSchedule(schedule: fallbackSchedule)
        selectedSchedule = groupedSchedule
        Task { @MainActor in
            await storeNetworkSchedule(week: week)
            let fallbackSchedule = scheduleProvider.getFallbackSchedule(week: week)
            let groupedSchedule = groupSchedule(schedule: fallbackSchedule)
            selectedSchedule = groupedSchedule
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await storeStandings()
        }
    }

    /// Helper method reponsible for persisting Schedule of specific NFL Week obtained from Remote Endpoint
    ///
    ///  - Parameters:
    ///     - week: Value of `ScheduleTitle` type defining NFL Week
    private func storeNetworkSchedule(week: ScheduleTitle) async {
        let defaultKey = week.toDefaultKey
        let networkData = await networkService.getData(from: Endpoints.scheduleScoreboard(regSeason: week.isRegSeason,
                                                                                          week: week.toWeekNum))
        guard !networkData.isEmpty else {
            return
        }
        UserDefaults.setValue(for: defaultKey, value: networkData)
    }

    /// Helper method responsible for persisting Standings data obtained from Remote Endpoint
    private func storeStandings() async {
        let defaultKey = DefaultKey.standings
        let networkData = await networkService.getData(from: Endpoints.standings)

        guard !networkData.isEmpty else {
            return
        }

        UserDefaults.setValue(for: defaultKey, value: networkData)
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
    init(scheduleProvider: ScheduleProviderProto,
         networkService: NetworkServiceProto) {
        self.scheduleProvider = scheduleProvider
        self.networkService = networkService
        loadCurrWeek()
    }
}
