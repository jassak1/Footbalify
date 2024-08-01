//
//  FootbalifyWidgetBundle.swift
//  FootbalifyWidget
//
//  Created by Adam Jassak on 14/07/2024.
//

import WidgetKit
import SwiftUI

@main
struct FootbalifyWidgetBundle: WidgetBundle {
    var body: some Widget {
        PlayoffWidget3()
        DivisionLeadersWidget1()
        SuperBowlWidget()
        WidgetBundle1().body
    }
}

struct WidgetBundle1: WidgetBundle {
    var body: some Widget {
        DivisionLeadersWidget2()
        DivisionLeaderWidget()
        PlayoffWidget1()
        WidgetBundle2().body
    }
}

struct WidgetBundle2: WidgetBundle {
    var body: some Widget {
        PlayoffWidget2()
        ScheduleFullWidget()
        TeamScheduleMdWidget()
        WidgetBundle3().body
    }
}

struct WidgetBundle3: WidgetBundle {
    var body: some Widget {
        TeamScheduleSmWidget()
        TeamStandingsMdWidget()
        TeamStandingsSmWidget()
        WidgetBundle4().body
    }
}

struct WidgetBundle4: WidgetBundle {
    var body: some Widget {
        SuperBowlCountdownWidget()
        LockSmCountdownWidget()
        LockSmTeamStandingsWidget()
        WidgetBundle5().body
    }
}

struct WidgetBundle5: WidgetBundle {
    var body: some Widget {
        LockMdTeamStandingsWidget()
    }
}
