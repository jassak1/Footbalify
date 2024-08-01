//
//  DivisionProvider.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit

/// Division WidgetKit Provider - Intent based
struct DivisionIntentProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> DivisionEntry {
        .init(date: Date(), division: .afcEast)
    }
    
    func getSnapshot(for configuration: DivisionsConfigurationIntent,
                     in context: Context, completion: @escaping (DivisionEntry) -> Void) {
        completion(.init(date: Date(), division: .afcEast))
    }
    
    func getTimeline(for configuration: DivisionsConfigurationIntent,
                     in context: Context, completion: @escaping (Timeline<DivisionEntry>) -> Void) {
        completion(.init(entries: [.init(date: Date(),
                                         division: configuration.divTeam)], policy: .never))
    }
}

/// Divisions Widgets Entry
struct DivisionEntry: TimelineEntry {
    let date: Date
    let division: DivTeam
}

