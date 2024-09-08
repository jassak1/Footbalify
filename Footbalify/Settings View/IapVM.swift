//
//  IapVM.swift
//  Footbalify
//
//  Created by Adam Jassak on 17/08/2024.
//

import SwiftUI
import StoreKit
import OSLog

/// InApp Screen's ViewModel
class IapVM: ObservableObject {
    // MARK: - Properties
    /// In App purchase service
    var iapService: IapServiceProto
    /// Collection of promo images displayed on Iap Screen
    @Published var promoImages: [Image] = [.init(.promo1), .init(.promo2),
                                           .init(.promo3), .init(.promo4), .init(.promo5)]
    /// Combine's timer used for shuffling promo Images
    var timer = Timer.publish(every: 4, on: RunLoop.main, in: .common).autoconnect()
    /// T&C URL
    let termsUrl = URL(string: AppConstant.tcUrl.rawValue)!
    /// Privacy policy URL
    let privacyUrl = URL(string: AppConstant.privacyUrl.rawValue)!
    /// InApp's Product
    @Published var product: Product? = nil
    /// Price of a InApp's product
    @Published var productPrice = String()
    /// Boolean observer indicating whether alert message shall be displayed
    @Published var showAlert = false
    /// Transaction listener observing current Inap purchase status
    var iapListener: Task<Void, Error>? = nil

    // MARK: - Methods
    /// Method responsible for taking action upon pressing the purchase button
    func purchaseItem() {
        Task { @MainActor in
            do {
                try await iapService.purchaseItem(item: product)
                showAlert = true
            } catch {
                Logger.generic.error("\(error)")
            }
        }
    }

    // MARK: - Initialiser
    init(iapService: IapServiceProto) {
        self.iapService = iapService

        iapListener = iapService.transactionListener()
        Task { @MainActor in
            do {
                product = try await iapService.fetchProduct()
                productPrice = product?.displayPrice ?? String()
            } catch {
                Logger.generic.error("\(error)")
            }
        }
    }
}
