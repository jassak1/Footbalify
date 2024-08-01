//
//  ScheduleFullWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct ScheduleFullWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: ScheduleFullEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            Text(entry.currWeek.rawValue)
                .font(.extraItalicCustom(15))
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                .foregroundStyle(.blue)
            LazyVGrid(columns: [GridItem(),
                               GridItem(),
                                GridItem(),
                               GridItem()]) {
                ForEach(entry.schedule, id: \.team1) { item in
                    VStack(spacing: 0) {
                        Text(item.matchDate.scheduleLabelDate)
                            .font(.regular10)
                        Text(item.matchDate.scheduleLabelTime)
                            .font(.extra10)
                        HStack(spacing: 0) {
                            Text(item.team1.abbrevName)
                            Text(" - ")
                            Text(item.team2.abbrevName)
                        }.font(.extra10)
                            .fixedSize(horizontal: true,
                                       vertical: false)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(
                                    LinearGradient(colors: [
                                        Color(vm.getTeamColor(team: item.team1)),
                                        Color(vm.getTeamColor(team: item.team2))
                                    ], startPoint: .leading,
                                                   endPoint: .trailing))
                        )
                        .padding(.bottom, 10)
                    }

                }
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct ScheduleFullWidget: Widget {
    let kind: String = WidgetKind.scheduleFullLarge.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: ScheduleProviderFull()) { entry in
            if #available(iOS 17.0, *) {
                ScheduleFullWidgetView(entry: entry)
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
                ScheduleFullWidgetView(entry: entry)
                    .background()
            }
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName(WidgetKind.scheduleFullLarge.rawValue)
        .description("Large Widget with weekly updated schedule")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemLarge) {
    ScheduleFullWidget()
} timeline: {
    ScheduleFullEntry(date: Date(),
                      team: .bears,
                      currWeek: .week1,
                      schedule: MatchInfo.placeholderInstance)
}
