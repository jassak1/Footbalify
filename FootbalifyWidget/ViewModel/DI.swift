//
//  DI.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import Foundation

/// Dependency injection with singleton used within WidgetKit Footbalify extension
struct DI {
    /// Singleton DI
    static var shared = Self()
    /// Schedule Provider Service instance
    var scheduleProvider: ScheduleProviderProto
    /// Standings Provider Service instance
    var standingsProvider: StandingsProviderProto

    /// WidgetKit's ViewModel
    var vm: WidgetVM {
        WidgetVM(scheduleProvider: scheduleProvider,
                 standingsProvider: standingsProvider)
    }

    init() {
        scheduleProvider = ScheduleProvider()
        standingsProvider = StandingsProvider()
    }
}
