//
//  PlayOffView.swift
//  Footbalify
//
//  Created by Adam Jassak on 14/07/2024.
//

import SwiftUI

struct PlayOffView: View {
    let wildCards: [MatchInfo]
    let divisionals: [MatchInfo]
    let conferences: [MatchInfo]
    let aTeam = Teams.browns
    let bTeam = Teams.bills
    var body: some View {
        ZStack {
            Color.colorMainBg.ignoresSafeArea()
            Color.gray.opacity(0.1)
            HStack {
                VStack {
                    Group {
                        Text("WILD")
                        Text("CARD")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(wildCards, id: \.team1) { schedule in
                        bracketItem(team: schedule.team1)
                        bracketItem(team: schedule.team2)
                            .padding(.bottom, 30)
                    }
                }.padding(.trailing, 20)
                VStack {
                    Group {
                        Text("DIV")
                        Text("RND")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(divisionals, id: \.team1) { schedule in
                        bracketItem(team: schedule.team1)
                        bracketItem(team: schedule.team2)
                            .padding(.bottom, 30)
                    }
                }.padding(.trailing, 20)
                VStack {
                    Group {
                        Text("CONF")
                        Text("CHAMP")
                    }.fixedSize(horizontal: true, vertical: true)
                        .font(.extraItalic10)
                    ForEach(conferences, id: \.team1) { schedule in
                        bracketItem(team: schedule.team1)
                        bracketItem(team: schedule.team2)
                    }
                }.padding(.bottom, 30)
            }
        }
    }

    // MARK: - SubViews
    /// Bracket item SubView
    ///
    ///  - Parameters:
    ///     - team: Value of `Teams` type defining team used in a bracket
    func bracketItem(team: Teams) -> some View {
        Rectangle()
            .stroke(lineWidth: 2)
            .frame(height: 30)
            .foregroundStyle(Color("\(team.fullName) \(AppConstant.color.rawValue)"))
            .overlay(
                HStack {
                    Image("\(team.fullName) \(AppConstant.logo.rawValue)")
                        .resizable()
                        .scaledToFit()
                        .padding(.leading, 5)
                    Spacer()
                    Text("\(team.abbrevName)")
                        .font(.extra10)
                        .offset(x: -10)
                        .frame(maxWidth: 30,
                               alignment: .leading)
                }
            )
    }
}

#Preview {
    let vm = WidgetVM(scheduleProvider: ScheduleProvider(), standingsProvider: StandingsProvider())
    return PlayOffView(wildCards: vm.getSchedule(week: .wildCard,
                                                 conference: .mainAfc),
                       divisionals: vm.getSchedule(week: .divRd,
                                                   conference: .mainAfc),
                       conferences: vm.getSchedule(week: .confChamp,
                                                   conference: .mainAfc))
}
