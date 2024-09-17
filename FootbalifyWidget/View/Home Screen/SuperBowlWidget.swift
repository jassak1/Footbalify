//
//  SuperBowlWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 16/07/2024.
//

import SwiftUI
import WidgetKit

// MARK: - View
struct SuperBowlWidgetView: View {
    @StateObject private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            HStack {
                HStack {
                    VStack {
                        ForEach(vm.getSchedule(week: .confChamp,
                                               conference: .mainAfc), id: \.team1) { standing in
                            bracketView(team: standing.team1)
                            Image(.afcLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .offset(x: 50)
                            bracketView(team: standing.team2)
                        }
                    }
                    Rectangle()
                        .trim(from: 0.01, to: 0.7)
                        .stroke()
                        .foregroundStyle(.gray)
                        .frame(height: 70)
                }
                HStack {
                    bracketView(team: vm.getConferenceChampion(conference: .mainAfc))
                    bracketView(team: vm.getConferenceChampion(conference: .mainNfc))

                }
                HStack {
                    Rectangle()
                        .trim(from: 0.01, to: 0.7)
                        .stroke()
                        .foregroundStyle(.gray)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .frame(height: 70)
                    VStack {
                        ForEach(vm.getSchedule(week: .confChamp,
                                               conference: .mainNfc), id: \.team1) { standing in
                            bracketView(team: standing.team1)
                            Image(.nfcLogo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .offset(x: -50)
                            bracketView(team: standing.team2)
                        }
                    }
                }
            }
            Image(.superBowlLogo)
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(maxHeight: .infinity,
                       alignment: .top)
        }.dynamicTypeSize(.medium)
    }

    // MARK: - SubViews
    func bracketView(team: Teams) -> some View {
        VStack {
            Image("\(team.fullName) \(AppConstant.logo.rawValue)")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
                .padding(.horizontal, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color("\(team.fullName) \(AppConstant.color.rawValue)"))
                )
            Text(team.abbrevName)
                .font(.extraCustom(8))
                .foregroundStyle(.white)
        }
    }
}

// MARK: - Widget
struct SuperBowlWidget: Widget {
    let kind: String = WidgetKind.superBowlMedium.rawValue

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: PlayoffStaticProvider()) { entry in
            if #available(iOS 17.0, *) {
                SuperBowlWidgetView(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.colorMainBg.ignoresSafeArea()
                        Image(.gridiron)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors: [.black.opacity(0.85),
                                                .black.opacity(0.75)], startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    }
            } else {
                SuperBowlWidgetView(entry: entry)
                    .background()
            }
        }
                            .supportedFamilies([.systemMedium])
                            .configurationDisplayName(WidgetKind.superBowlMedium.rawValue)
                            .description("NFL Playoff Road to Super Bowl LIX")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemMedium) {
    SuperBowlWidget()
} timeline: {
    PlayoffEntry(date: Date(), conference: .nfc)
}
