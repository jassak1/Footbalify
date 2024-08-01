//
//  Factory.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import SwiftUI

/// Factory holding instances to all ViewModels and Services
class Factory: ObservableObject {
    // MARK: - Private properties
    /// Standings Provider service Instance
    private let standingsProvider: StandingsProviderProto
    /// Schedule Provider service Instance
    private let scheduleProvider: ScheduleProviderProto
    /// Network Service Instance
    private let networkService: NetworkServiceProto

    // MARK: - Public methods
    func makeScheduleVm() -> ScheduleVM {
        ScheduleVM(scheduleProvider: scheduleProvider)
    }

    func makeStandingsVm() -> StandingsVM {
        StandingsVM(standingsProvider: standingsProvider,
                    scheduleProvider: scheduleProvider)
    }

    func makeWidgetsVm() -> WidgetsVM {
        WidgetsVM()
    }

    func makeSettingsVm() -> SettingsVM {
        SettingsVM()
    }

    // MARK: - Initialiser
    init() {
        standingsProvider = StandingsProvider()
        scheduleProvider = ScheduleProvider()
        networkService = NetworkService()
    }
}
