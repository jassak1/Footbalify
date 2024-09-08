//
//  FootbalifyApp.swift
//  Footbalify
//
//  Created by Adam Jassak on 08/07/2024.
//

import SwiftUI
import WidgetKit

@main
struct FootbalifyApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var factory = Factory()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(factory)
                .onChange(of: scenePhase) { newPhase in
                    WidgetCenter.shared.reloadAllTimelines()
                }
        }
    }
}
