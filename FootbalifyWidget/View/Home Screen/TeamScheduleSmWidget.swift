//
//  TeamScheduleSmWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct TeamScheduleSmWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: ScheduleFullEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            HStack {
                if vm.useColors {
                    Color(vm.getTeamColor(team: entry.team.toTeam))
                        .frame(width: 25, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } else {
                    Image(vm.getTeamLogo(team: entry.team.toTeam))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                Spacer()
                Text(entry.currWeek.rawValue)
                    .fixedSize(horizontal: true,
                               vertical: false)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .font(.extra10)
            VStack {
                ForEach(vm.getTeamsSchedule(team: entry.team,
                                            week: entry.currWeek), id: \.team1) { schedule in
                    VStack(spacing: 0) {
                        Text(schedule.matchDate.scheduleLabelDate)
                            .font(.regular10)
                        Text(schedule.matchDate.scheduleLabelTime)
                            .font(.extraItalicCustom(15))
                            .padding(.bottom, 5)
                        HStack {
                            teamLabelView(team: schedule.team1)
                            Text("V")
                                .font(.extra20)
                                .foregroundStyle(.red)
                            teamLabelView(team: schedule.team2,
                                          rotate: true)
                        }
                    }.padding(.top, 5)
                }
            }
        }
        .foregroundStyle(.white)
        .dynamicTypeSize(.medium)
    }

    // MARK: - SubViews
    /// Team Label SubView
    ///
    ///  - Parameters:
    ///     - teams: Specific Team used in a label
    ///     - rotate: Boolean flag indicating whether label color shall be mirrored
    func teamLabelView(team: Teams,
                       rotate: Bool = false) -> some View {
        VStack {
            Rectangle()
                .frame(width: 30, height: 30)
                .foregroundStyle(LinearGradient(colors: [
                    .black,
                    Color(vm.getTeamColor(team: team))
                ],
                                                startPoint: .trailing,
                                                endPoint: .leading))
                .rotation3DEffect(
                    .degrees(rotate ? 180 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .overlay(
                    OptionallyHidden(isHidden: vm.useColors) {
                        Image(vm.getTeamLogo(team: team))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .scaleEffect(1.2)
                    }
                )
                .shadow(color: .yellow,
                        radius: 1)
            Text(team.abbrevName)
                .font(.extra10)
        }
    }
}

// MARK: - Widget
struct TeamScheduleSmWidget: Widget {
    let kind: String = WidgetKind.teamScheduleSmall.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: ScheduleProviderTeam()) { entry in
            if #available(iOS 17.0, *) {
                TeamScheduleSmWidgetView(entry: entry)
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
                TeamScheduleSmWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.teamScheduleSmall.rawValue)
                            .description("Small Widget with upcoming Team's schedule")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemSmall) {
    TeamScheduleSmWidget()
} timeline: {
    ScheduleFullEntry(date: Date(),
                      team: .dolphins,
                      currWeek: .week1,
                      schedule: MatchInfo.placeholderInstance)
}
