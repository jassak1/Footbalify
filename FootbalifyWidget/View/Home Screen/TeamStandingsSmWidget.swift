//
//  TeamStandingsSmWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct TeamStandingsSmWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: TeamStandingsEntry
    var teamStanding: StandingsInfo {
        vm.getTeamStandings(team: entry.nflTeam.toTeam)
    }
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Image(teamStanding.team.conference == .mainAfc ? .afcLogo : .nfcLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("\(teamStanding.wins) - \(teamStanding.loses)")
                            .font(.extraCustom(7))
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text(teamStanding.team.division.rawValue)
                            .font(.extraItalicCustom(13))
                            .foregroundStyle(teamStanding.team.conference == .mainAfc ? .red : .blue)
                        Text(teamStanding.team.rawValue.uppercased())
                            .font(.extra10)
                    }
                }
                Image(vm.getTeamLogo(team: teamStanding.team))
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct TeamStandingsSmWidget: Widget {
    let kind: String = WidgetKind.teamStandingsSm.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: TeamStandingsProvider()) { entry in
            if #available(iOS 17.0, *) {
                TeamStandingsSmWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(colors: [
                            .black,
                            Color("\(entry.nflTeam.toTeam.fullName) \(AppConstant.color.rawValue)")
                        ],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    }
            } else {
                TeamStandingsSmWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.teamStandingsSm.rawValue)
                            .description("Small Widget with Team's Standings during Regular Season")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemSmall) {
    TeamStandingsSmWidget()
} timeline: {
    TeamStandingsEntry(date: Date(),
                       nflTeam: .vikings)
}
