//
//  HelpWidgetView.swift
//  Footbalify
//
//  Created by Adam Jassak on 27/07/2024.
//

import SwiftUI

/// SwiftUI View displaying SetUP Guide for Adding Widgets
struct HelpWidgetView: View {
    @Environment(\.dismiss) private var dismiss
    let hsHelp = ["HS1", "HS2", "HS3", "HS4", "HS5", "HS6", "HS7"]
    let lsHelp = ["LS1", "LS2", "LS3", "LS4", "LS5", "LS6", "LS7"]
    @State private var currentSelection: HelpBtnSelection = .hs
    @State private var helpItems: [String] = []
    @State private var btnColors: [Color] = [.atlantaFalcons,
                                             .white,
                                             .gray,
                                             .black]
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorMainBg.ignoresSafeArea()
                VStack {
                    HStack {
                        selectionBtn(selection: .hs)
                        selectionBtn(selection: .ls)
                    }.frame(height: 40)
                        .lineLimit(1).minimumScaleFactor(0.5)
                        .padding()
                    TabView {
                        ForEach(helpItems, id: \.self) { item in
                            VStack {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .padding(.horizontal, 50)
                                Text(LocalizedStringKey(item))
                                    .padding()
                                    .font(.semiCustom(15))
                            }
                        }
                    }.tabViewStyle(.page)
                }
                .foregroundStyle(.white)
                .onAppear {
                    helpItems = hsHelp
                }
            }.navigationTitle("Widgets Setup")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "x.circle")
                            .fontWeight(.bold)
                            .foregroundStyle(.atlantaFalcons)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
        }
    }

    // MARK: - SubViews
    /// Custom SwiftUI View providing button selection
    func selectionBtn(selection: HelpBtnSelection) -> some View {
        var overlayText = String()
        var bgColor: Color = .black
        var fgColor: Color = .black
        switch selection {
        case .hs:
            overlayText = "Home Screen"
            bgColor = btnColors[0]
            fgColor = btnColors[1]
        case .ls:
            overlayText = "Lock Screen"
            bgColor = btnColors[2]
            fgColor = btnColors[3]
        }
        return RoundedRectangle(cornerRadius: 15)
            .foregroundStyle(bgColor)
            .overlay(Text(overlayText)
                .foregroundStyle(fgColor)
                .padding(.horizontal, 2))
            .font(.extraCustom(15))
            .onTapGesture {
                withAnimation(.snappy(duration: 0.1)) {
                    currentSelection = selection
                    helpItems = currentSelection == .hs ? hsHelp : lsHelp
                    btnColors = currentSelection == .hs ? [.atlantaFalcons,
                                                           .white,
                                                           .gray,
                                                           .black] : [.gray,
                                                                      .black,
                                                                      .atlantaFalcons,
                                                                      .white]
                }
            }
    }
}

#Preview {
    HelpWidgetView()
}

enum HelpBtnSelection {
    case hs
    case ls
}
