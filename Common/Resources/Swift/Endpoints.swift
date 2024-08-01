//
//  Endpoints.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

/// Structure defining available Endpoints with NFL Json content
struct Endpoints {
    /// Static method providing endpoint with Schedule and Scores data
    ///
    ///  - Parameters:
    ///     - regSeason: Boolean flag indicating whether searching for regular Season (Weeks 1 - 18)
    ///     - week: Number of a week (1 - 18 for Regular season).
    ///     (Post Season: 1 - Wild Card Round, 2 - Divisional Round, 3 - Conference Championships, 5 - Super Bowl)
    static func scheduleScoreboard(regSeason: Bool = true,
                                   week: Int) -> String {
        "https://site.api.espn.com/apis/site/v2/sports/football/nfl/scoreboard?dates=2024&seasontype=\(regSeason ? "2" : "3")&week=\(week)"
    }

    
}
