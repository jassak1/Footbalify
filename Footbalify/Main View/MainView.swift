//
//  MainView.swift
//  Footbalify
//
//  Created by Adam Jassak on 08/07/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var factory: Factory
    var body: some View {
        TabView {
            ScheduleView(vm: factory.makeScheduleVm())
                .tabItem {
                    Label(
                        title: { Text("Schedule") },
                        icon: { Image(systemName: AppConstant.calendarIcon.rawValue) }
                    )
                }
            StandingsView(vm: factory.makeStandingsVm())
                .tabItem {
                    Label(
                        title: { Text("Standings") },
                        icon: { Image(systemName: AppConstant.footballIcon.rawValue) }
                    )
                }
            WidgetsView(vm: factory.makeWidgetsVm() )
                .tabItem {
                    Label(
                        title: { Text("Widgets") },
                        icon: { Image(systemName: AppConstant.gridironIcon.rawValue) }
                    )
                }
            SettingsView(vm: factory.makeSettingsVm())
                .tabItem {
                    Label(
                        title: { Text("Settings") },
                        icon: { Image(systemName: AppConstant.gearIcon.rawValue) }
                    )
                }
        }.tint(.mint)
    }
}

#Preview {
    MainView()
        .environmentObject(Factory())
}
