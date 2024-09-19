//
//  DivisionLeadersWidget2.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct DivisionLeadersWidget2View: View {
    @StateObject private var vm = DI.shared.vm
    let entry: DivisionEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            VStack(spacing: 0) {
                HStack {
                    Image(entry.division.toConference == .mainAfc ? .afcLogo : .nfcLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Text(entry.division.toDivision.baseName)
                        .font(.extraItalic10)
                }.padding(.bottom, 5)
                    .frame(maxWidth: .infinity,
                           alignment: .trailing)
                ForEach(vm.getStandings(for: entry.division.toDivision), id: \.team) { standing in
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(
                            LinearGradient(colors: [.black,
                                                    Color(vm.getTeamColor(team: standing.team))],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .overlay(
                            HStack {
                                HStack {
                                    Image(vm.getTeamLogo(team: standing.team))
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .padding(.vertical, 3)
                                    Text(standing.team.rawValue.uppercased())
                                        .font(.extra20)
                                }.frame(maxWidth: .infinity,
                                        alignment: .leading)
                                 .padding(.leading, 20)
                                Text("\(standing.wins) - \(standing.loses)")
                                    .font(.extraItalic20)
                                    .padding(.trailing, 20)
                            }
                        )
                }
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct DivisionLeadersWidget2: Widget {
    let kind: String = WidgetKind.divisionLeadersMedium1.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: DivisionsConfigurationIntent.self,
                            provider: DivisionIntentProvider()) { entry in
            if #available(iOS 17.0, *) {
                DivisionLeadersWidget2View(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.colorMainBg.ignoresSafeArea()
                        Image(.superBowlLogo)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors:
                                        getConferenceColors(division: entry.division), startPoint: .top,
                                       endPoint: .bottom)
                    }
            } else {
                DivisionLeadersWidget2View(entry: entry)
                    .background()
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName(WidgetKind.divisionLeadersMedium1.rawValue)
        .description("Division Leaders")
    }

    /// Helper method providing Conference's Gradient Colors conditionally
    func getConferenceColors(division: DivTeam) -> [Color] {
        return if division.toConference == .mainAfc {
            [.washingtonCommanders.opacity(0.85),
                    .washingtonCommanders.opacity(0.75)]
        } else {
            [.chicagoBears.opacity(0.85),
             .chicagoBears.opacity(0.75)]
        }
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemMedium) {
    DivisionLeadersWidget2()
} timeline: {
    DivisionEntry(date: Date(), division: .nfcNorth)
}
