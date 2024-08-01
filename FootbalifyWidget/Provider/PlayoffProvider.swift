//
//  PlayoffProvider.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import WidgetKit

/// Intent based Playoff Provider
struct PlayoffIntentProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> PlayoffEntry {
        return .init(date: Date(), conference: .afc)
    }
    
    func getSnapshot(for configuration: PlayoffConfigurationIntent,
                     in context: Context, completion: @escaping (PlayoffEntry) -> Void) {
        completion(.init(date: Date(), conference: .afc))
    }
    
    func getTimeline(for configuration: PlayoffConfigurationIntent,
                     in context: Context, completion: @escaping (Timeline<PlayoffEntry>) -> Void) {
        completion(.init(entries: [.init(date: Date(),
                                         conference: configuration.conference)],
                         policy: .never))
    }
}

/// Static based Playoff Provider
struct PlayoffStaticProvider: TimelineProvider {
    func placeholder(in context: Context) -> PlayoffEntry {
        .init(date: Date(), conference: .afc)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PlayoffEntry) -> Void) {
        completion(.init(date: Date(), conference: .afc))
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PlayoffEntry>) -> Void) {
        completion(.init(entries: [.init(date: Date(),
                                         conference: .afc)],
                         policy: .never))
    }
}

/// Playoff Widgets Entry
struct PlayoffEntry: TimelineEntry {
    let date: Date
    let conference: Conference
}
