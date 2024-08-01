//
//  LockMdTeamSchedule.swift
//  Footbalify
//
//  Created by Adam Jassak on 19/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct LockMdTeamScheduleView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: ScheduleFullEntry
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(vm.getTeamLogo(team: entry.team.toTeam))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Spacer()
                    Text(entry.currWeek.rawValue)
                        .font(.extraItalic10)
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                ForEach(vm.getTeamsSchedule(team: entry.team,
                                            week: entry.currWeek), id: \.team1) { schedule in
                    HStack {
                        Text(schedule.team1.abbrevName)
                            .font(.extra20)
                        VStack(spacing: 0) {
                            Text(schedule.matchDate.scheduleLabelDate)
                                .font(.regularCustom(8))
                            Text(schedule.matchDate.scheduleLabelTime)
                                .font(.extraItalicCustom(8))
                                .padding(.bottom, 5)
                        }
                        Text(schedule.team2.abbrevName)
                            .font(.extra20)
                    }
                }
            }
        }
        .foregroundStyle(.white)
        .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct LockMdTeamSchedule: Widget {
    let kind: String = WidgetKind.lockTeamScheduleMd.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: ScheduleProviderTeam()) { entry in
            if #available(iOS 17.0, *) {
                LockMdTeamScheduleView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black
                        Image(.nflBall2)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors: [.colorMainBg.opacity(0.95),
                                                .colorMainBg.opacity(0.8)],
                                       startPoint: .bottomTrailing,
                                       endPoint: .topLeading)
                    }
            } else {
                LockMdTeamScheduleView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.accessoryRectangular])
                            .configurationDisplayName(WidgetKind.lockTeamScheduleMd.rawValue)
                            .description("Rectangular Widget with specific Team's Weekly schedule")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .accessoryRectangular) {
    LockMdTeamSchedule()
} timeline: {
    ScheduleFullEntry(date: Date(),
                      team: .dolphins,
                      currWeek: .week1,
                      schedule: MatchInfo.placeholderInstance)
}
