//
//  LockMdTeamStandings.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct LockMdTeamStandingsView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: TeamStandingsEntry
    var teamStanding: StandingsInfo {
        vm.getTeamStandings(team: entry.nflTeam.toTeam)
    }
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(teamStanding.team.conference == .mainAfc ? .afcLogo : .nfcLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                        Text(teamStanding.team.division.rawValue)
                            .font(.extraItalic10)
                            .foregroundStyle(teamStanding.team.conference == .mainAfc ? .red : .blue)
                    }
                    Text(teamStanding.team.rawValue.uppercased())
                        .font(.extra10)
                    Text("C: P\(teamStanding.position) | \(teamStanding.percentage) %")
                        .font(.semiCustom(8))
                    Text("\(teamStanding.wins) - \(teamStanding.loses)")
                        .font(.regularCustom(8))
                }.frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                    alignment: .topLeading)
                Image(vm.getTeamLogo(team: teamStanding.team))
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black,
                            radius: 30)
            }
        }
        .foregroundStyle(.white)
        .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct LockMdTeamStandingsWidget: Widget {
    let kind: String = WidgetKind.lockTeamStandingsMd.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: TeamStandingsProvider()) { entry in
            if #available(iOS 17.0, *) {
                LockMdTeamStandingsView(entry: entry)
                    .containerBackground(for: .widget) {
                        LinearGradient(colors: [
                            .black,
                            Color("\(entry.nflTeam.toTeam.fullName) \(AppConstant.color.rawValue)")
                        ],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    }
            } else {
                LockMdTeamStandingsView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.accessoryRectangular])
                            .configurationDisplayName(WidgetKind.lockTeamStandingsMd.rawValue)
                            .description("Rectangular Widget with specific Team's NFL Standings")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .accessoryRectangular) {
    LockMdTeamStandingsWidget()
} timeline: {
    TeamStandingsEntry(date: Date(),
                       nflTeam: .jaguars)
}
