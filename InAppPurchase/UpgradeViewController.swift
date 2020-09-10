//
//  UpgradeViewController.swift
//  InAppPurchase
//
//  Created by ramil on 10.09.2020.
//

import UIKit
import StoreKit

class UpgradeViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    
    var myProduct: SKProduct?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchProducts()
    }
    
    @IBAction func didTabBuy() {
        
        guard let myProduct = myProduct else {
            return
        }
        
        if SKPaymentQueue.canMakePayments() {
            
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    
    func fetchProducts() {
        // com.ri.InAppPurchase.nonconsumable
        
        let request = SKProductsRequest(productIdentifiers: ["com.ri.InAppPurchase.nonconsumable"])
        
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if let product = response.products.first {
            
            myProduct = product
            
            print(product.productIdentifier)
            print(product.price)
            print(product.priceLocale)
            print(product.localizedTitle)
            print(product.localizedDescription)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
            
            case .purchasing:
                // no op
                break
                
            case .purchased, .restored:
                // unlock their item
                
                UserDefaults.standard.set(true, forKey: "ads_removed")
                
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            case .failed, .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
                
            default:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                break
            }
        }
    }


}
