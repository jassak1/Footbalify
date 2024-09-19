//
//  LockSmTeamStandings.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct LockSmTeamStandingsView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: TeamStandingsEntry
    var teamStandings: StandingsInfo {
        vm.getTeamStandings(team: entry.nflTeam.toTeam)
    }
    var body: some View {
        ZStack {
            Image(vm.getTeamLogo(team: entry.nflTeam.toTeam))
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(0.3)
            VStack {
                Text("\(teamStandings.wins) - \(teamStandings.loses)")
                Text(teamStandings.team.abbrevName)
                    .font(.extraItalicCustom(15))
                Text("C: P\(teamStandings.position)")
            }.font(.regularCustom(8))
        }
    }
}

// MARK: - Widget
struct LockSmTeamStandingsWidget: Widget {
    let kind: String = WidgetKind.lockTeamStandingsSm.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: TeamStandingsProvider()) { entry in
            if #available(iOS 17.0, *) {
                LockSmTeamStandingsView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(colors: [
                            .black,
                            Color("\(entry.nflTeam.toTeam.fullName) \(AppConstant.color.rawValue)")
                        ],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    }
            } else {
                LockSmTeamStandingsView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.accessoryCircular])
                            .configurationDisplayName(WidgetKind.lockTeamStandingsSm.rawValue)
                            .description("Circular Widget with specific Team's Standings")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .accessoryCircular) {
    LockSmTeamStandingsWidget()
} timeline: {
    TeamStandingsEntry(date: Date(),
                       nflTeam: .chiefs)
}
