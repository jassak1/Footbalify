//
//  SettingsView.swift
//  Footbalify
//
//  Created by Adam Jassak on 23/07/2024.
//

import SwiftUI
import StoreKit

/// SettingsView
struct SettingsView: View {
    @StateObject private var vm: SettingsVM
    @Environment(\.requestReview) private var requestReview
    @EnvironmentObject private var factory: Factory
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            ZStack {
                Color.colorMainBg.ignoresSafeArea()
                List {
                    Section(content: {
                        Text("Support Footbalify")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.atlantaFalcons)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.extra20)
                            .onTapGesture {
                                vm.showSheet = true
                            }
                    }, header: {
                        Text("FUNDING")
                            .font(.semiCustom(15))
                    }).listRowBackground(Color.colorMainBg)
                    Section(content: {
                        labelItem(label: "About", icon: "info.circle.fill")
                            .onTapGesture {
                                vm.navPath.append(SettingsNavPath.about)
                            }
                        labelItem(label: "FAQ", icon: "questionmark.circle.fill")
                            .onTapGesture {
                                vm.navPath.append(SettingsNavPath.faq)
                            }
                        Link(destination: vm.mailUrl,
                             label: {
                            labelItem(label: "E-mail",
                                      icon: "envelope.fill",
                                      withArrow: false,
                                      handle: "footbalify@proton.me")
                        })
                        Link(destination: vm.xUrl,
                             label: {
                            labelItem(label: "x.com",
                                      icon: "x.circle.fill",
                                      withArrow: false,
                                      handle: "@FootbalifyApp")
                        })
                        Label(
                            title: { Text("Leave a rating") },
                            icon: { Image(systemName: "star.circle.fill").font(.headline) }
                        ).font(.extra20)
                            .foregroundStyle(.white.opacity(0.7))
                            .onTapGesture {
                                requestReview()
                            }
                    }, header: {
                        Text("FOOTBALIFY")
                            .font(.semiCustom(15))
                    }).listRowBackground(Color.colorMainBg)
                    Text("Foobalify \(vm.appVersion)")
                        .frame(maxWidth: .infinity,
                               alignment: .center)
                        .listRowSeparator(.hidden)
                        .font(.extraCustom(15))
                        .foregroundStyle(.gray)
                        .listRowBackground(Color.colorMainBg)
                }.listStyle(.plain)
                    .scrollIndicators(.hidden)
            }.navigationDestination(for: SettingsNavPath.self) { navItem in
                switch navItem {
                case .about:
                    aboutView
                case .faq:
                    faqView
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $vm.showSheet) {
                IapView(vm: factory.makeIapVm())
            }
        }
    }

    // MARK: - SubViews
    /// Custom SwiftUI SubView providing label item
    ///
    ///  - Parameters:
    ///     - label: String defining label's text
    ///     - icon: SF symbol icon for a label
    ///     - withArrow: Boolean flag indicating whether navigation chevron is shown
    ///     - handle: Text for a deep link URL
    func labelItem(label: String,
                   icon: String,
                   withArrow: Bool = true,
                   handle: String = String()) -> some View {
        HStack {
            Label(
                title: { Text(label) },
                icon: { Image(systemName: icon).font(.headline) }
            ).font(.extra20)
                .foregroundStyle(.white.opacity(0.7))
            OptionallyHidden(isHidden: !withArrow) {
                Color.colorMainBg.frame(maxWidth: .infinity)
                Image(systemName: AppConstant.chevronRightIcon.rawValue)
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
            }
            OptionallyHidden(isHidden: withArrow) {
                Spacer()
                Text(handle)
                    .font(.extraCustom(15))
                    .foregroundStyle(.atlantaFalcons)
            }
        }
    }

    /// Computed property providing content of an About screen
    var aboutView: some View {
        ScrollView(.vertical) {
            Text("Footbalify is the ultimate app for National Football enthusiasts, offering comprehensive access to the latest schedules and standings. It provides up to date game details, including dates and times, making it easy to stay updated on all the action. Users can effortlessly track their favorite teams' performance with up-to-date standings for all National Football divisions and conferences. \n\nThe app also features customizable Widgets for both Home Screen and Lock Screen, offering at-a-glance information on upcoming games and current standings. With a sleek and user-friendly interface, Footbalify ensures navigating through National Football schedules and standings is a seamless experience.\n\nFootbalify is designed to enhance the overall National Football experience, providing quick, reliable updates and ensuring fans never miss a moment of their favorite sport.")
        }.scrollIndicators(.hidden)
            .multilineTextAlignment(.center)
            .font(.semiCustom(15))
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            .navigationTitle("About")
    }

    /// Computed property providing content of a FAQ screen
    var faqView: some View {
        return List {
            listItem(q: "q1", a: "a1")
            listItem(q: "q2", a: "a2")
            listItem(q: "q3", a: "a3")
            listItem(q: "q4", a: "a4")
            listItem(q: "q6", a: "a6")
            listItem(q: "q7", a: "a7")
        }.navigationTitle("FAQ")
            .scrollIndicators(.hidden)
        
        /// Method providing List item View used within FAQ List View
        func listItem(q: LocalizedStringKey,
                      a: LocalizedStringKey) -> some View {
            VStack(alignment: .leading) {
                Text(q)
                    .font(.extra20)
                    .padding(.bottom, 5)
                Text(a)
                    .font(.semiCustom(15))
                    .foregroundStyle(.gray)
            }.listRowBackground(Color.gray.opacity(0.1))
        }
    }

    // MARK: - Initialiser
    init(vm: SettingsVM) {
        _vm = StateObject(wrappedValue: vm)
    }
}

#Preview {
    SettingsView(vm: SettingsVM())
        .environmentObject(Factory())
}
