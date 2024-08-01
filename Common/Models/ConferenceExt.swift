//
//  ConferenceExt.swift
//  Footbalify
//
//  Created by Adam Jassak on 15/07/2024.
//

import Foundation

extension Conference {
    var toDivision: Divisions {
        /// Computed property providing `Divisions` value associated with specific Conference
        if self == .afc {
            return .mainAfc
        } else {
            return .mainNfc
        }
    }
}
