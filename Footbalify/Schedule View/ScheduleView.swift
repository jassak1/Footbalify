//
//  ScheduleView.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var vm: ScheduleVM
    var body: some View {
        NavigationStack {
            List {
                horizontalScrollView
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(.colorMainBg))
                ForEach(vm.selectedSchedule, id: \.key) { keyItem in
                    Section(content: {
                        ForEach(keyItem.value, id: \.team1) { valItem in
                            scheduleItem(matchInfo: valItem)
                        }
                    }, header: {
                        Text("\(keyItem.key.scheduleHeader)")
                            .font(.extra20)
                    })
                }.listRowSeparator(.hidden)
                    .listRowBackground(Color(.colorMainBg))
            }.listStyle(.inset)
                .scrollIndicators(.hidden)
                .navigationTitle("Schedule")
                .refreshable {
                   // TODO: - Add data fetch
                }
                .scrollContentBackground(.hidden)
                .background(Color(.colorMainBg))
        }
    }

    // MARK: - SubViews
    /// List Item SubView with ScheduleView content
    private func scheduleItem(matchInfo: MatchInfo) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(Color(.colorMainFg))
            .frame(height: 100)
            .overlay(
                GeometryReader { geo in
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            teamItem(team: matchInfo.team1)
                            teamItem(team: matchInfo.team2)
                        }.padding(5)
                        Spacer()
                        Rectangle()
                            .frame(width: 1)
                            .padding(.vertical, 5)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                        if matchInfo.gameCompleted {
                            VStack(spacing: 20) {
                                Text(matchInfo.score1)
                                Text(matchInfo.score2)
                            }.padding(.trailing, 50)
                                .font(.extra20)
                                .frame(width: geo.size.width/4)
                        } else {
                            VStack {
                                Text("\(matchInfo.matchDate.scheduleLabelDate)")
                                Text(matchInfo.matchDate.scheduleLabelTime.lowercased())
                            }.font(.semiCustom(12))
                                .padding()
                                .frame(width: geo.size.width/3)
                        }
                    }
                }
            )
            .foregroundStyle(.white)
    }

    /// Team's Hstack with Logo and Team Name SubView
    private func teamItem(team: Teams) -> some View {
        HStack {
            Image("\(team.fullName) \(AppConstant.logo.rawValue)")
                .resizable()
                .scaledToFit()
            HStack {
                Text(verbatim: team.rawValue.uppercased())
                    .font(.extraItalicCustom(15))
            }
        }
    }

    /// Custom SubView providing Horizontal Week's ScrollView
    private var horizontalScrollView: some View {
        ScrollViewReader { scRead in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(ScheduleTitle.allCases, id: \.rawValue) { scItem in
                        Text("\(scItem.rawValue)")
                            .id(scItem)
                            .padding(2)
                            .font(.extraItalic20)
                            .opacity(scItem == vm.selectedWeek ? 1 : 0.3)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    vm.loadWeekSchedule(week: scItem)
                                }
                            }
                            .padding(10)
                            .background(.atlantaFalcons
                                .opacity(scItem == vm.selectedWeek ? 0.8 : 0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }.scrollIndicators(.hidden)
                .onAppear {
                    scRead.scrollTo(vm.selectedWeek)
                }
        }
    }

    init(vm: ScheduleVM) {
        _vm = StateObject(wrappedValue: vm)
    }
}

#Preview {
    ScheduleView(vm: ScheduleVM(scheduleProvider: ScheduleProvider()))
}
