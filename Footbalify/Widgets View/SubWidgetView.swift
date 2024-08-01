//
//  SubWidgetView.swift
//  Footbalify
//
//  Created by Adam Jassak on 25/07/2024.
//

import SwiftUI

/// SwiftUI View displaying Widget's Sub screen
struct SubWidgetView: View {
    @State private var showSheet = false
    @State private var frameWidth = CGFloat()
    let widget: WidgetKind
    var body: some View {
        ZStack {
            Color.colorMainBg.ignoresSafeArea()
            VStack {
                Image(widget.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: frameWidth/1.5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.gray))
                Label(
                    title: { Text("How to add a Widget?") },
                    icon: { Image(systemName: "info.bubble") }
                )
                .font(.extra20)
                .padding(10)
                .background(.atlantaFalcons)
                .clipShape(
                RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    showSheet.toggle()
                }
                    .padding(.top, 50)
                Spacer()
            }
            GeometryReader { geo in
                Color.clear.onAppear {
                    frameWidth = geo.size.width
                }
            }
        }.foregroundStyle(.white)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(widget.rawValue)
                    .font(.extra20)
                    .fixedSize(horizontal: false,
                               vertical: true)
            }
        }
        .sheet(isPresented: $showSheet) {
            HelpWidgetView()
        }
    }
}

#Preview {
    SubWidgetView(widget: .divisionLeaderSmall)
}
