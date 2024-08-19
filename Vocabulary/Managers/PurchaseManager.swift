//
//  PurchaseManager.swift
//  Vocabulary
//
//  Created by Кирилл Щёлоков on 19.08.2024.
//

import SwiftUI
import ApphudSDK
import AdServices

@MainActor
final class PurchaseManager: ObservableObject {

    @Published private(set) var paywall: ApphudPaywall!
    @Published private(set) var appProduct: ApphudProduct!
    @Published private(set) var isSubscribed: Bool = false

    static let shared = PurchaseManager()

    private init() {
        Apphud.start(apiKey: "app_3eX2ZXy4fPmsZQ1z3nNxstpa6wTJoi")
        Task {
            if let asaToken = try? AAAttribution.attributionToken() {
                Apphud.addAttribution(data: nil, from: .appleAdsAttribution, identifer: asaToken, callback: nil)
            }
        }
        obtainProducts { paywalls in
            let product = paywalls.flatMap(\.products).first(where: {$0.productId == "product_id"})!
            self.paywall = paywalls.first(where: { $0.identifier == product.paywallIdentifier })
            self.appProduct = product
        }
        self.isSubscribed = Apphud.hasPremiumAccess()
    }

    private func obtainProducts(completion: @escaping (([ApphudPaywall]) -> Void)) {
        Apphud.paywallsDidLoadCallback { (paywalls, _) in
            completion(paywalls)
        }
    }

    func makePurchase(completion: @escaping(Bool) -> Void) {
        Apphud.purchase(appProduct) { [weak self] result in
            DispatchQueue.main.async {
#if DEBUG
                self?.isSubscribed = true
                completion(true)
#else
                if let subscription = result.subscription, subscription.isActive() {
                    self?.isSubscribed = true
                    completion(true)
                } else {
                    completion(false)
                }
#endif
            }
        }
    }

    func restorePurchase(completion: @escaping(Bool) -> Void) {
        Apphud.restorePurchases { [weak self] subscriptions, purchases, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Restore purchases failed: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                if let subscriptions = subscriptions, subscriptions.contains(where: { $0.isActive() }) {
                    self?.isSubscribed = true
                    completion(true)
                    return
                }

                if let purchases = purchases, purchases.contains(where: { $0.isActive() }) {
                    self?.isSubscribed = true
                    completion(true)
                    return
                }

                completion(false)
            }
        }
    }
}
