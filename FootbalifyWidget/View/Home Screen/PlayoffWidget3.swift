//
//  PlayoffWidget3.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct PlayoffWidget3View: View {
    @StateObject private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            VStack {
                HStack(spacing: 0) {
                    Image(entry.conference == .afc ? .afcLogo : .nfcLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                    Text(entry.conference.toDivision.rawValue + " Conference Leaders")
                        .font(.extra10)
                }.frame(maxWidth: .infinity,
                        alignment: .leading)
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 30)
                    .foregroundStyle(LinearGradient(colors: [
                        .black,
                        Color(vm.getTeamColor(team: vm.getDivisionLeader(for: entry.conference.toDivision).team))],
                                                    startPoint: .leading,
                                                    endPoint: .trailing))
                    .overlay(
                        HStack {
                            Text(verbatim: "1")
                                .font(.extraItalic20)
                                .padding(.leading, 10)
                            Text(vm.getDivisionLeader(for: entry.conference.toDivision).team.fullName)
                                .fixedSize(horizontal: true, vertical: false)
                                .font(.extraItalicCustom(15))
                            Spacer()
                            Image(vm.getTeamLogo(team: vm.getDivisionLeader(for: entry.conference.toDivision).team))
                                .resizable()
                                .scaledToFit()
                                .padding(.trailing, 5)
                        }
                    )
                LazyVGrid(columns: [GridItem(),
                                    GridItem(),
                                    GridItem()]) {
                    ForEach(vm.getStandings(for: entry.conference.toDivision).prefix(7).dropFirst(), id: \.team) { standing in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 30)
                            .foregroundStyle(LinearGradient(colors: [
                                .black,
                                Color(vm.getTeamColor(team: standing.team))],
                                                            startPoint: .leading,
                                                            endPoint: .trailing))
                            .overlay(
                                HStack {
                                    Text(standing.position)
                                        .font(.extraItalic20)
                                        .frame(maxWidth: .infinity,
                                               alignment: .leading)
                                        .padding(.leading, 10)
                                    Image(vm.getTeamLogo(team: standing.team))
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.trailing, 5)
                                }
                            )
                    }
                }
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct PlayoffWidget3: Widget {
    let kind: String = WidgetKind.playoffMedium3.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PlayoffConfigurationIntent.self, provider: PlayoffIntentProvider()) { entry in
            if #available(iOS 17.0, *) {
                PlayoffWidget3View(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.colorMainBg
                        Image(.gridiron)
                            .resizable()
                            .scaledToFill()
                        Color.black.opacity(0.7)
                    }
            } else {
                PlayoffWidget3View(entry: entry)
                    .background()
            }
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName(WidgetKind.playoffMedium3.rawValue)
        .description("NFL Conference Playoffs Medium Widget")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemMedium) {
    PlayoffWidget3()
} timeline: {
    PlayoffEntry(date: Date(), conference: .afc)
}

