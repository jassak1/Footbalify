//
//  IapService.swift
//  Footbalify
//
//  Created by Adam Jassak on 17/08/2024.
//

import SwiftUI
import StoreKit
import OSLog

/// Protocol defining InApp's Service properties and methods
protocol IapServiceProto {
    /// Method responsible for retrieving Footbalify In App Product
    ///
    /// - Returns: Optional value of `Product` type
    func fetchProduct() async throws -> Product?

    /// Method responsible for listening to transaction updates (ran immediately when app starts)
    ///
    /// - Returns: Task<Void, Error>
    func transactionListener() -> Task<Void, Error>

    /// Method responsible for purchassing the Item (trigerred by Purchase button)
    ///
    /// - Parameters:
    ///     - item: Optional value of `Product` type
    func purchaseItem(item: Product?) async throws

    /// Method responsible for restoring purchased Item (trigerred by Restore purchase button)
    func restorePurchase() async
}

/// Implementation of Iap Service
struct IapService: IapServiceProto {
    func fetchProduct() async throws -> Product? {
        let allProducts = try await Product.products(for: [AppConstant.iapProductId.rawValue])
        let targetProduct = allProducts.first
        return targetProduct
    }

    func transactionListener() -> Task<Void, Error> {
        Task {
            for await result in Transaction.updates {
                switch result {
                case .verified(let transaction):
                    onPuchaseSuccess()
                    await transaction.finish()
                case .unverified:
                    Logger.generic.warning("In-app purchase: Not verified.")
                }
            }
        }
    }

    func purchaseItem(item: Product?) async throws {
        let result = try await item?.purchase()
        switch result {
        case .success(let verificationResult):
            switch verificationResult {
            case .unverified:
                Logger.generic.warning("In-app purchase: Not verified.")
                throw IapError.genericIapError
            case .verified(let signedType):
                onPuchaseSuccess()
                await signedType.finish()
            }
        case .userCancelled:
            Logger.generic.warning("In-app purchase: User cancelled.")
            throw IapError.genericIapError
        case .pending:
            Logger.generic.warning("In-app purchase: Pending.")
            throw IapError.genericIapError
        default:
            Logger.generic.warning("In-app purchase: Unknown error.")
            throw IapError.genericIapError
        }
    }

    func restorePurchase() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .unverified:
                Logger.generic.warning("In-app purchase: Not verified.")
            case .verified(let transaction):
                if transaction.productID == AppConstant.iapProductId.rawValue {
                    onPuchaseSuccess()
                    withUnsafeCurrentTask {
                        $0?.cancel()
                    }
                }
                await transaction.finish()
            }
        }
    }

    /// Private method responsible for taking action upon purchasing the PaddockPlus
    private func onPuchaseSuccess() {
        Logger.generic.info("Purchase succesfull")
    }
}

/// Custom Type defining InApp Purchases errors
enum IapError: Error {
    case genericIapError
}
