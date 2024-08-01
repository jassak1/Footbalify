//
//  FootbalifyApp.swift
//  Footbalify
//
//  Created by Adam Jassak on 08/07/2024.
//

import SwiftUI

@main
struct FootbalifyApp: App {
    @StateObject private var factory = Factory()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(factory)
        }
    }
}
