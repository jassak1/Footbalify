//
//  LockSmCountdown.swift
//  Footbalify
//
//  Created by Adam Jassak on 18/07/2024.
//

import WidgetKit
import SwiftUI

// MARK: - View
struct LockSmCountdownView: View {
    @State private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            Image(.superBowlLogo)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(0.4)
            Text("\(Date.superBowlDate, style: .relative)")
                .font(.extra10)
                .multilineTextAlignment(.center)
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }
}

// MARK: - Widget
struct LockSmCountdownWidget: Widget {
    let kind: String = WidgetKind.lockSuperBowlCountdownSm.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: PlayoffStaticProvider()) { entry in
            if #available(iOS 17.0, *) {
                LockSmCountdownView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black
                    }
            } else {
                LockSmCountdownView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.accessoryCircular])
                            .configurationDisplayName(WidgetKind.lockSuperBowlCountdownSm.rawValue)
                            .description("Circular Widget Countdown to upcoming Super Bowl")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .accessoryCircular) {
    LockSmCountdownWidget()
} timeline: {
    PlayoffEntry(date: Date(), conference: .nfc)
}
