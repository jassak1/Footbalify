//
//  TeamScheduleMdWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 17/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct TeamScheduleMdWidgetView: View {
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
                Text(entry.currWeek.rawValue)
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .font(.extra20)
            VStack {
                ForEach(vm.getTeamsSchedule(team: entry.team,
                                            week: entry.currWeek), id: \.team1) { schedule in
                    VStack(spacing: 0) {
                        Text(schedule.matchDate.scheduleLabelDate)
                            .font(.extra10)
                        Text(schedule.matchDate.scheduleLabelTime)
                            .font(.extraItalic20)
                            .padding(.bottom, 5)
                        HStack {
                            teamLabelView(team: schedule.team1)
                            Text("V")
                                .font(.extra20)
                                .foregroundStyle(.red)
                            teamLabelView(team: schedule.team2,
                                          rotate: true)
                            .rotation3DEffect(
                                .degrees(180),
                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
                            )

                        }
                    }
                }
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
    // MARK: - SubViews
    /// Team Label SubView
    ///
    ///  - Parameters:
    ///     - teams: Specific Team used in a label
    ///     - rotate: Boolean flag indicating whether label shall be horizontally mirrored
    func teamLabelView(team: Teams,
                       rotate: Bool = false) -> some View {
        Rectangle()
            .frame(height: 40)
            .foregroundStyle(LinearGradient(colors: [
                .black,
                Color(vm.getTeamColor(team: team))
            ],
                                            startPoint: .trailing,
                                            endPoint: .leading))
            .overlay(
                HStack {
                    if !vm.useColors {
                        Image(vm.getTeamLogo(team: team))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .scaleEffect(1.5)
                            .rotation3DEffect(
                                .degrees(rotate ? 180 : 0),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    Spacer()
                    Text(team.abbrevName)
                        .font(.extra20)
                        .padding(.trailing, 5)
                        .rotation3DEffect(
                            .degrees(rotate ? 180 : 0),
                                                  axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .padding(.trailing, rotate ? 5 : 0)
                }

            )
            .shadow(color: .yellow,
                    radius: 1)
    }
}

// MARK: - Widget
struct TeamScheduleMdWidget: Widget {
    let kind: String = WidgetKind.teamScheduleMedium.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: TeamConfigurationIntent.self,
                            provider: ScheduleProviderTeam()) { entry in
            if #available(iOS 17.0, *) {
                TeamScheduleMdWidgetView(entry: entry)
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
                TeamScheduleMdWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.teamScheduleMedium.rawValue)
                            .description("Medium Widget with upcoming Team's schedule")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemMedium) {
    TeamScheduleMdWidget()
} timeline: {
    ScheduleFullEntry(date: Date(),
                      team: .dolphins,
                      currWeek: .week1,
                      schedule: MatchInfo.placeholderInstance)
}
