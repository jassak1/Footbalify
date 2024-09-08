//
//  ScheduleProviderFull.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit

/// Schedule Full Widget Provider
struct ScheduleProviderFull: TimelineProvider {
    /// Schedule Provider service reference
    let provider = DI.shared.scheduleProvider

    // MARK: - Stubs
    func placeholder(in context: Context) -> ScheduleFullEntry {
        .init(date: Date(), team: .ravens,
              currWeek: .week1, schedule: MatchInfo.placeholderInstance)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ScheduleFullEntry) -> Void) {
        completion(.init(date: Date(), team: .ravens,
                         currWeek: .week1, schedule: MatchInfo.placeholderInstance))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ScheduleFullEntry>) -> Void) {
        let currSchedule = getCurrWeekDetails()
        let lastDate = currSchedule.1.last?.matchDate ?? Date()
        completion(.init(entries: [.init(date: Date(),
                                         team: .ravens,
                                         currWeek: currSchedule.0,
                                         schedule: currSchedule.1)],
                         policy: .after(lastDate)))
    }

    // MARK: - Helper Methods
    /// Method responsible for providing current week and week's NFL Schedule
    ///
    ///  - Returns: Tuple - 0 - Current Week, 1 - Current week's Schedule
    func getCurrWeekDetails() -> (ScheduleTitle, [MatchInfo]) {
        let currWeek = provider.getCurrWeek()
        let defaultSchedule = provider.getFallbackSchedule(week: currWeek)
        return (currWeek, provider.transformSchedule(schedule: defaultSchedule))
    }
}

/// Specific NFL Team's Schedule Provider - Intent based
struct ScheduleProviderTeam: IntentTimelineProvider {
    /// Schedule Provider service reference
    let provider = DI.shared.scheduleProvider

    // MARK: - Stubs
    func placeholder(in context: Context) -> ScheduleFullEntry {
        .init(date: Date(),
              team: .bengals,
              currWeek: .week1,
              schedule: MatchInfo.placeholderInstance.filter {
            $0.team1 == .bengals || $0.team2 == .bengals })
    }
    
    func getSnapshot(for configuration: TeamConfigurationIntent,
                     in context: Context, completion: @escaping (ScheduleFullEntry) -> Void) {
        completion(.init(date: Date(),
                         team: .bengals,
                         currWeek: .week1,
                         schedule: MatchInfo.placeholderInstance.filter {
            $0.team1 == .bengals || $0.team2 == .bengals }))
    }
    
    func getTimeline(for configuration: TeamConfigurationIntent,
                     in context: Context, completion: @escaping (Timeline<ScheduleFullEntry>) -> Void) {
        let infoDetails = getCurrWeekDetails()
        completion(.init(entries: [.init(date: Date(),
                                         team: configuration.nflTeam,
                                         currWeek: infoDetails.0,
                                         schedule: [])],
                         policy: .after(infoDetails.1)))
    }

    // MARK: - Helper Methods
    /// Method responsible for providing current week and week's and Date of last match of a current Week
    ///
    ///  - Parameters:
    ///
    ///  - Returns: Tuple - 0 - Current Week, 1 - Last match's Date
    func getCurrWeekDetails() -> (ScheduleTitle, Date) {
        let currWeek = provider.getCurrWeek()
        let defaultSchedule = provider.getFallbackSchedule(week: currWeek)
        return (currWeek, provider.transformSchedule(schedule: defaultSchedule).last?.matchDate ?? Date())
    }
}

/// Schedule Full Widget Entry
struct ScheduleFullEntry: TimelineEntry {
    let date: Date
    let team: NFLTeam
    let currWeek: ScheduleTitle
    let schedule: [MatchInfo]
}
