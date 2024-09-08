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
    /// Mail URL handle
    let mailUrl = URL(string: "mailto:footbalify@proton.me")!
    /// x.com URL handle
    let xUrl = URL(string: "https://twitter.com/FootbalifyApp")!
    /// Current App's Version
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? String()
    /// Boolean observer indicating whether modal sheet shall be displayed
    @Published var showSheet = false
}

/// Custom enum with possible values of Settings Navigation Path
enum SettingsNavPath: Hashable {
    case about, faq
}
