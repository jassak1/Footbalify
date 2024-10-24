//
//  SettingsVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 23/07/2024.
//

import SwiftUI

/// Setting's ViewModel
class SettingsVM: ObservableObject {
    // MARK: - Properties
    /// Navigation path property used within Navigation Stack of a Settings View
    @Published var navPath = NavigationPath()
    /// Boolean property indicating whether Colors will be used instead of Team Logos in selected Widgets
    @Published var useColors = Bool() {
        didSet {
            UserDefaults.setValue(for: .useColors, value: useColors)
        }
    }
    /// Mail URL handle
    let mailUrl = URL(string: "mailto:footbalify@proton.me")!
    /// x.com URL handle
    let xUrl = URL(string: "https://twitter.com/FootbalifyApp")!
    /// Current App's Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? String()
    /// Boolean observer indicating whether modal sheet shall be displayed
    @Published var showSheet = false

    // MARK: - Initialiser
    init() {
        useColors = UserDefaults.getValue(for: .useColors, defaultValue: false)
    }
}

/// Custom enum with possible values of Settings Navigation Path
enum SettingsNavPath: Hashable {
    case about, faq
}
