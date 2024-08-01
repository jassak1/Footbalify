//
//  PlayoffWidget2.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import SwiftUI
import WidgetKit

// MARK: - View
struct PlayoffWidget2View: View {
    @StateObject private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            PlayOffView(wildCards: vm.getSchedule(week: .wildCard,
                                                  conference: entry.conference.toDivision),
                        divisionals: vm.getSchedule(week: .divRd,
                                                    conference: entry.conference.toDivision),
                        conferences: vm.getSchedule(week: .confChamp,
                                                    conference: entry.conference.toDivision))
            .padding(.top, 10)
            .foregroundStyle(.white)
            Image(entry.conference == .afc ? .afcLogo : .nfcLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .bottomTrailing)
                .padding()
            Image(.superBowlLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topTrailing)
                .padding()
        }.dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct PlayoffWidget2: Widget {
    let kind: String = WidgetKind.playoffLarge2.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PlayoffConfigurationIntent.self, provider: PlayoffIntentProvider()) { entry in
            if #available(iOS 17.0, *) {
                PlayoffWidget2View(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.colorMainBg.ignoresSafeArea()
                        Color.gray.opacity(0.1)
                    }
            } else {
                PlayoffWidget2View(entry: entry)
                    .background()
            }
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName(WidgetKind.playoffLarge2.rawValue)
        .description("NFL Conference Playoffs Large Widget")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemLarge) {
    PlayoffWidget2()
} timeline: {
    PlayoffEntry(date: Date(), conference: .nfc)
}
