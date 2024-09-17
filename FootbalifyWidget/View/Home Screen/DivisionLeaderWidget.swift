//
//  DivisionLeaderWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct DivisionLeaderWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: DivisionEntry
    var entryTeam: StandingsInfo {
        vm.getDivisionLeader(for: entry.division.toDivision)
    }
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            VStack {
                HStack {
                    Image(entry.division.toConference == .mainAfc ? .afcLogo : .nfcLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    VStack(alignment: .leading) {
                        Text(entry.division.toDivision.rawValue)
                            .font(.extraItalic10)
                        Text("DIVISION LEADER")
                            .font(.regularCustom(7))
                    }
                }
                VStack(spacing: 0) {
                    Text(entryTeam.team.rawValue.uppercased())
                        .font(.extra10)
                    Text("\(entryTeam.wins) - \(entryTeam.loses)")
                        .font(.regItalic10)
                    Image(vm.getTeamLogo(team: entryTeam.team))
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .scaleEffect(1.2)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct DivisionLeaderWidget: Widget {
    let kind: String = WidgetKind.divisionLeaderSmall.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: DivisionsConfigurationIntent.self,
                            provider: DivisionIntentProvider()) { entry in
            if #available(iOS 17.0, *) {
                DivisionLeaderWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.colorMainBg.ignoresSafeArea()
                        Image(.gridiron)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors:
                                        [.chicagoBears.opacity(0.85),
                                         .chicagoBears.opacity(0.75)], startPoint: .top,
                                       endPoint: .bottom)
                    }
            } else {
                DivisionLeaderWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.divisionLeaderSmall.rawValue)
                            .description("NFL AFC/NFC Division Leader Team")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemSmall) {
    DivisionLeaderWidget()
} timeline: {
    DivisionEntry(date: Date(), division: .afcWest)
}
