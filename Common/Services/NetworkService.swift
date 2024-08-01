//
//  NetworkService.swift
//  Footbalify
//
//  Created by Adam Jassak on 31/07/2024.
//

import Foundation
import OSLog

/// Protocol defining all Network service stubs
protocol NetworkServiceProto {
    func getData(from address: String) async -> Data
}

/// Implementation of Network Service Protocol
struct NetworkService: NetworkServiceProto {
    func getData(from address: String) async -> Data {
        guard let url = URL(string: address) else {
            Logger.generic.error("Incorrect URL String passed to URL initialiser.")
            return Data()
        }
        do {
            let data = try await URLSession.shared.data(from: url).0
            return data
        } catch {
            Logger.generic.error("\(error)")
            return Data()
        }
    }
}
