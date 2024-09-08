//
//  SuperBowlCountdownWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct SuperBowlCountdownWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            VStack {
                Image(.superBowlLogo)
                    .resizable()
                    .scaledToFit()
                Text("\(Date.superBowlDate, style: .relative)")
                    .font(.extraCustom(15))
                    .fixedSize(horizontal: false,
                               vertical: true)
            }
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct SuperBowlCountdownWidget: Widget {
    let kind: String = WidgetKind.superBowlCountdownSm.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: PlayoffStaticProvider()) { entry in
            if #available(iOS 17.0, *) {
                SuperBowlCountdownWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black
                    }
            } else {
                SuperBowlCountdownWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemSmall])
                            .configurationDisplayName(WidgetKind.superBowlCountdownSm.rawValue)
                            .description("Small Widget Countdown to upcoming Super Bowl")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemSmall) {
    SuperBowlCountdownWidget()
} timeline: {
    PlayoffEntry(date: Date(), conference: .nfc)
}
