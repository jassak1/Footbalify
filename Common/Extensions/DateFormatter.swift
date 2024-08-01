//
//  DateFormatter.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

extension DateFormatter {
    /// Custom ISO8601 date formatter, not containing seconds
    static var ISO8601NoSeconds: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
        formatter.timeZone = .gmt
        return formatter
    }
}
