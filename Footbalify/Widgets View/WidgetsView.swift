//
//  WidgetsView.swift
//  Footbalify
//
//  Created by Adam Jassak on 23/07/2024.
//

import SwiftUI

/// Widgets View
struct WidgetsView: View {
    @StateObject private var vm: WidgetsVM
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            ZStack {
                Color.colorMainBg.ignoresSafeArea()
                List {
                    Section(content: {
                        ForEach(WidgetKind.smallWidgets, id: \.self) { item in
                            listItemView(item: item)
                        }
                    }, header: {
                        Text("Small Widgets")
                            .font(.extra20)
                    } ).listRowBackground(Color.clear)
                    Section(content: {
                        ForEach(WidgetKind.mediumWidgets, id: \.self) { item in
                            listItemView(item: item)
                        }
                    }, header: {
                        Text("Medium Widgets")
                            .font(.extra20)
                    } ).listRowBackground(Color.clear)
                    Section(content: {
                        ForEach(WidgetKind.largeWidgets, id: \.self) { item in
                            listItemView(item: item)
                        }
                    }, header: {
                        Text("Large Widgets")
                            .font(.extra20)
                    } ).listRowBackground(Color.clear)
                }.listStyle(.plain)
                    .scrollIndicators(.hidden)
            }.navigationTitle("Widgets")
                .navigationDestination(for: WidgetKind.self) { widget in
                    SubWidgetView(widget: widget)
                }
        }
    }

    // MARK: - SubViews
    /// Custom SwiftUI View providing List Item content
    func listItemView(item: WidgetKind) -> some View {
        HStack {
            Image(item.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: vm.getFrameSize(widget: item))
                .clipShape(RoundedRectangle(cornerRadius: vm.getCornerRadius(widget: item)))
                .overlay(
                    RoundedRectangle(cornerRadius: vm.getCornerRadius(widget: item))
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.gray))
            Text(item.rawValue)
                .font(.extraItalicCustom(15))
                .padding(.leading, 10)
                .padding(.trailing, 5)
                .foregroundStyle(.atlantaFalcons)
            Spacer()
            Image(systemName: AppConstant.chevronRightIcon.rawValue)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
        }.onTapGesture {
            vm.navPath.append(item)
        }
    }

    init(vm: WidgetsVM) {
        _vm = StateObject(wrappedValue: vm)
    }
}

#Preview {
    WidgetsView(vm: WidgetsVM())
}
