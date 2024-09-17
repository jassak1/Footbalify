//
//  PlayoffWidget.swift
//  Footbalify
//
//  Created by Adam Jassak on 14/07/2024.
//

import SwiftUI
import WidgetKit

// MARK: - View
struct PlayoffWidget1View: View {
    @StateObject private var vm = DI.shared.vm
    let entry: PlayoffEntry
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                Color.colorMainBg.ignoresSafeArea()
            }
            HStack {
                VStack {
                    Group {
                        Text("WILD")
                        Text("CARD")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(vm.getSchedule(week: .wildCard, conference: entry.conference.toDivision), id: \.team1) { schedule in
                        bracketView(team: schedule.team1)
                        bracketView(team: schedule.team2)
                        Spacer()
                    }
                }.padding(.horizontal, 30)
                VStack {
                    Group {
                        Text("DIV")
                        Text("RND")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(vm.getSchedule(week: .divRd, conference: entry.conference.toDivision), id: \.team1) { schedule in
                        VStack {
                            bracketView(team: schedule.team1)
                            bracketView(team: schedule.team2)
                        }
                        .padding(.vertical, 10)

                    }
                }.padding(.trailing, 30)
                VStack {
                    Group {
                        Text("CONF")
                        Text("CHAMP")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(vm.getSchedule(week: .confChamp,
                                           conference: entry.conference.toDivision), id: \.team1) { schedule in
                        bracketView(team: schedule.team1)
                        bracketView(team: schedule.team2)
                    }
                }
                VStack {
                    Image(entry.conference == .afc ? .afcLogo : .nfcLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    bracketView(team: vm.getConferenceChampion(conference: entry.conference.toDivision))
                        .padding(.horizontal, 30)
                }
            }.padding(.top, 10)
        }.foregroundStyle(.white)
            .dynamicTypeSize(.medium)
    }

    // MARK: - SubViews
    func bracketView(team: Teams) -> some View {
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
    }
}

// MARK: - Widget
struct PlayoffWidget1: Widget {
    let kind: String = WidgetKind.playoffLarge1.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PlayoffConfigurationIntent.self, provider: PlayoffIntentProvider()) { entry in
            if #available(iOS 17.0, *) {
                PlayoffWidget1View(entry: entry)
                    .containerBackground(for: .widget) {
                        Color.black
                        Image(.superBowlLogo)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors: [.colorMainBg,
                                                .colorMainBg.opacity(0.8)],
                                       startPoint: .bottomTrailing,
                                       endPoint: .topLeading)
                    }
            } else {
                PlayoffWidget1View(entry: entry)
                    .background()
            }
        }
        .supportedFamilies([.systemLarge])
        .configurationDisplayName(WidgetKind.playoffLarge1.rawValue)
        .description("NFL Conference Playoffs Large Widget")
    }
}

// MARK: - Preview
@available(iOS, introduced: 17.0)
#Preview(as: .systemLarge) {
    PlayoffWidget1()
} timeline: {
    PlayoffEntry(date: Date(), conference: .nfc)
}
