//
//  Logger.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import Foundation
import OSLog

extension Logger {
    /// Logger subsystem identifying Footbalify app
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""

    /// Generic Logger category, roofing all Log messages
    static var generic = Logger(subsystem: subsystem, category: "generic")
}
