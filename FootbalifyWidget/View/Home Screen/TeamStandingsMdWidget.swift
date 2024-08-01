//
//  TeamStandingsMdWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: View
struct TeamStandingsMdWidgetView: View {
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
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(teamStanding.team.conference == .mainAfc ? .afcLogo : .nfcLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text(teamStanding.team.division.rawValue)
                            .font(.extraItalicCustom(15))
                            .foregroundStyle(teamStanding.team.conference == .mainAfc ? .red : .blue)
                    }
                    Text(teamStanding.team.fullName)
                        .font(.extra10)
                    Text("C: P\(teamStanding.position) | \(teamStanding.percentage) %")
                        .font(.semi10)
                    Text("\(teamStanding.wins) - \(teamStanding.loses)")
                        .font(.regular10)
                }.frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                    alignment: .topLeading)
                Image(vm.getTeamLogo(team: teamStanding.team))
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black,
                            radius: 30)
            }
        }
        .foregroundStyle(.white)
        .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct TeamStandingsMdWidget: Widget {
    let kind: String = WidgetKind.teamStandingsMd.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: TeamStandingsProvider()) { entry in
            if #available(iOS 17.0, *) {
                TeamStandingsMdWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(colors: [
                            .black,
                            Color("\(entry.nflTeam.toTeam.fullName) \(AppConstant.color.rawValue)")
                        ],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    }
            } else {
                TeamStandingsMdWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.teamStandingsMd.rawValue)
                            .description("Medium Widget with Team's Standings during Regular Season")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemMedium) {
    TeamStandingsMdWidget()
} timeline: {
    TeamStandingsEntry(date: Date(),
                       nflTeam: .packers)
}
