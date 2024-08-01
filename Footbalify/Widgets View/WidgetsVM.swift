//
//  WidgetsVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 23/07/2024.
//

import SwiftUI

/// Widgets ViewModel
class WidgetsVM: ObservableObject {
    // MARK: - Properties
    /// Navigation path property used within Navigation Stack of a Widgets View
    @Published var navPath = NavigationPath()

    // MARK: - Methods
    /// Method providing Widget Image List Item Frame size
    ///
    ///  - Parameters:
    ///     - widget: Value of `WidgetKind` type
    ///
    ///  - Returns: `CGFloat` defining size of Image Item frame width
    func getFrameSize(widget: WidgetKind) -> CGFloat {
        if WidgetKind.smallWidgets.contains(widget) {
            return 100
        } else {
            return 150
        }
    }

    /// Method providing Widget Image Corner radius
    ///
    ///  - Parameters:
    ///     - widget: Value of `WidgetKind` type
    ///
    ///  - Returns: `CGFloat` defining size of a corner radius
    func getCornerRadius(widget: WidgetKind) -> CGFloat {
        if WidgetKind.smallWidgets.contains(widget) {
            return 10
        } else {
            return 5
        }
    }
}
