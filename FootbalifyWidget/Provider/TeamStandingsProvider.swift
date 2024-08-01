//
//  TeamStandingsProvider.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit

/// Team's Standings Widget Provider - Intent based
struct TeamStandingsProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> TeamStandingsEntry {
        .init(date: Date(),
              nflTeam: .ravens)
    }
    
    func getSnapshot(for configuration: TeamConfigurationIntent,
                     in context: Context, completion: @escaping (TeamStandingsEntry) -> Void) {
        completion(.init(date: Date(), nflTeam: .ravens))
    }
    
    func getTimeline(for configuration: TeamConfigurationIntent,
                     in context: Context, completion: @escaping (Timeline<TeamStandingsEntry>) -> Void) {
        completion(.init(entries: [.init(date: Date(),
                                         nflTeam: configuration.nflTeam)],
                         policy: .never))
    }
}

/// Team's Standings Widget Entry
struct TeamStandingsEntry: TimelineEntry {
    let date: Date
    let nflTeam: NFLTeam
}
