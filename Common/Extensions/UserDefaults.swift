//
//  UserDefaults.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

extension UserDefaults {
    /// Static property holding UserDefault's Shared container
    static let sharedSuite = UserDefaults(suiteName: AppConstant.appGroupContainer.rawValue)

    /// Method retrieving value persisted in UserDefault's shared container
    ///
    ///  - Parameters:
    ///     - key: `DefaultKey` space associated with persisted value
    ///     - defaultValue: Default value of property, when none persisted value is found
    static func getValue<T>(for key: DefaultKey, defaultValue: T) -> T {
        UserDefaults.sharedSuite?.object(forKey: key.rawValue) as? T ?? defaultValue
    }

    /// Method responsible for persisting provided value in UserDefault's shared container
    ///
    ///  - Parameters:
    ///     - key: `DefaultKey` associated with persisted value
    ///     - value: Value that will be persisted
    static func setValue<T>(for key: DefaultKey, value: T) {
        UserDefaults.sharedSuite?.setValue(value, forKey: key.rawValue)
    }
}
