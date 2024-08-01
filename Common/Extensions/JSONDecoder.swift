//
//  JSONDecoder.swift
//  Footbalify
//
//  Created by Adam Jassak on 11/07/2024.
//

import Foundation

extension JSONDecoder {
    /// Method responsible for decoding provided JSON Data into a specific Codable Type
    /// Defaults to custom ISO8601 Date decoding strategy
    static func decodeJson<T: Codable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.ISO8601NoSeconds)
        return try decoder.decode(T.self, from: data)
    }
}

