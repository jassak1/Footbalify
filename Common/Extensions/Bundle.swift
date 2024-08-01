//
//  Bundle.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

extension Bundle {
    /// Static method responsible for retrieval of Data from App Bundle's file
    ///
    ///  - Parameters:
    ///     - file: FileName (`AppConstant`) that will be read
    ///  - Returns: Data read from a file
    static func getDataContent(of file: AppConstant) throws -> Data {
        guard let url = self.main.url(forResource: file.rawValue, withExtension: nil) else {
            throw URLError(.badURL)
        }
        return try Data(contentsOf: url)
    }
}
