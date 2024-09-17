//
//  StandingsView.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import SwiftUI

struct StandingsView: View {
    @StateObject private var vm: StandingsVM
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorMainBg.ignoresSafeArea()
                GeometryReader { geo in
                    List {
                        selectorView
                            .listRowBackground(Color.colorMainBg)
                            .listRowSeparator(.hidden)
                        if vm.standingSelection == .playOff {
                            Section(content: {
                                PlayOffView(wildCards: vm.getSchedule(week: .wildCard, conference: .mainAfc),
                                            divisionals: vm.getSchedule(week: .divRd, conference: .mainAfc),
                                            conferences: vm.getSchedule(week: .confChamp, conference: .mainAfc))
                                .listRowBackground(Color.gray.opacity(0.1))
                                .listRowSeparator(.hidden)
                            }, header: {
                                HStack {
                                    Image(.afcLogo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    Text("\(Divisions.mainAfc.rawValue) Playoffs")
                                }.font(.extra20)
                            })
                            Section(content: {
                                PlayOffView(wildCards: vm.getSchedule(week: .wildCard, conference: .mainNfc),
                                            divisionals: vm.getSchedule(week: .divRd, conference: .mainNfc),
                                            conferences: vm.getSchedule(week: .confChamp, conference: .mainNfc))
                                .listRowBackground(Color.gray.opacity(0.1))
                                .listRowSeparator(.hidden)
                            }, header: {
                                HStack {
                                    Image(.nfcLogo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    Text("\(Divisions.mainNfc.rawValue) Playoffs")
                                }.font(.extra20)
                            })
                        } else {
                            ForEach(vm.standingsActual, id: \.key) { keyItem in
                                Section(content: {
                                    tableHeader(geo: geo)
                                    ForEach(keyItem.value, id: \.team) { valItem in
                                        tableContent(standing: valItem,
                                                     geo: geo)
                                    }
                                }, header: {
                                    HStack {
                                        Image(vm.getDivisionsLogo(division: keyItem.key))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30)
                                        Text(keyItem.key)
                                    }.font(.extra20)
                                })
                            }.listRowBackground(Color.gray.opacity(0.1))
                                .listRowSeparator(.hidden)
                        }
                    }.listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.colorMainBg)
                        .scrollIndicators(.hidden)
                }
            }.navigationTitle("Standings")
        }
    }

    // MARK: - SubViews
    /// Selector Buttons Sub View displaying Standings buttons
    private var selectorView: some View {
        HStack {
            ForEach(StandingsType.allCases, id: \.rawValue) { standing in
                Text(standing.rawValue)
                    .padding()
                    .background(.atlantaFalcons
                        .opacity(standing == vm.standingSelection ? 0.8 : 0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundStyle(standing == vm.standingSelection ? .white : .gray)
                    .font(.extraItalicCustom(15))
                    .onTapGesture {
                        withAnimation(.smooth) {
                            vm.displayStandings(selection: standing)
                        }
                    }
            }
        }.font(.extraCustom(15))
            .frame(maxWidth: .infinity)
    }

    /// Method providing Standings Table's Header
    ///
    ///  - Parameters:
    ///     - geo: Proxy value of Geometry Reader
    private func tableHeader(geo: GeometryProxy) -> some View {
        HStack() {
            Text(AppConstant.team.rawValue)
                .frame(width: geo.size.width/3, alignment: .leading)
            Text(AppConstant.win.rawValue)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(AppConstant.lose.rawValue)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(AppConstant.tie.rawValue)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(AppConstant.percentage.rawValue)
                .padding(.leading, 5)
        }.font(.semiCustom(15))
    }

    /// Method providing Standings Table's Content
    ///
    ///  - Parameters:
    ///     - standing: NFL Standings used as table content
    ///     - geo: Proxy value of Geometry Reader
    private func tableContent(standing: StandingsInfo,
                              geo: GeometryProxy) -> some View {
        HStack {
            HStack {
                Image("\(standing.team.fullName) \(AppConstant.logo.rawValue)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Text(standing.team.abbrevName)
            }.frame(width: geo.size.width/3, alignment: .leading)
                .font(.extraItalic20)
            Text(standing.wins)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(standing.loses)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(standing.ties)
                .frame(width: geo.size.width/10, alignment: .leading)
            Text(standing.percentage)
        }.font(.regular20)
    }

    // MARK: - Initialiser
    init(vm: StandingsVM) {
        _vm = StateObject(wrappedValue: vm)
    }
}

#Preview {
    StandingsView(vm: StandingsVM(standingsProvider: StandingsProvider(),
                                  scheduleProvider: ScheduleProvider()))
}
