//
//  IAPManager.swift
//  IAPTest
//
//  Created by Fahad Mirza on 24/02/2025.
//
import UIKit
import StoreKit

public typealias SuccessBlock = () -> Void
public typealias FailureBlock = (Error?) -> Void
public typealias loadProductsBlock = (SKProductsResponse?) -> Void
public typealias purchaseCallBackBlock = (purchaseResponse?, String?) -> Void
public typealias purchaseResponse = (productId: String, expiry: Date)

let receiptValidationStatusCodes = [
    "0": "No Error",
    "21000": "The App Store could not read the JSON object you provided.",
    "21002": "The data in the receipt-data property was malformed.",
    "21003": "The receipt could not be authenticated.",
    "21004": "The shared secret you provided does not match the shared secret on file for your account.",
    "21005": "The receipt server is not currently available.",
    "21006": "This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response.",
    "21007": "This receipt is a sandbox receipt, but it was sent to the production service for verification.",
    "21008": "This receipt is a production receipt, but it was sent to the sandbox service for verification.",
]

class IAPManager : NSObject{
    
    // Shared secret. You can find this on your appstore connect account.
    private var sharedSecret = "fe071f324c184300998c79c0aaf564d6"
    
    @objc static let shared = IAPManager()
    private override init() {}
    
    private var loadProductsCallback : loadProductsBlock?
    private var purchaseCallBack : purchaseCallBackBlock?
    private var canSendPurchaseCall: Bool = false
    private var purchaseCallCount = 0
    
    // MARK:- Main methods
    func start() {
        SKPaymentQueue.default().add(self)
    }
    
    func loadProducts(productIds: Set<String>, callback: @escaping loadProductsBlock) {
        let request = SKProductsRequest.init(productIdentifiers: productIds)
        request.delegate = self
        request.start()
        loadProductsCallback = callback
    }
    
    func restore(callback: @escaping purchaseCallBackBlock) {
        purchaseCallBack = callback
        canSendPurchaseCall = true
        guard SKPaymentQueue.canMakePayments() else {
            print("user can not make purchases now")
            self.pushPurchaseCallBack(response: nil, error: "Restore not allowed. Please try again later.")
            return
        }
        SKPaymentQueue.default().restoreCompletedTransactions()
        print("restore called")
    }
    
    func purchase(product: SKProduct, callback: @escaping purchaseCallBackBlock){
        purchaseCallBack = callback
        canSendPurchaseCall = true
        guard SKPaymentQueue.canMakePayments() else {
            self.pushPurchaseCallBack(response: nil, error: "Purchase not allowed. Please try again later.")
            return
        }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        print("purchase called")
    }
    
    func expirationDateFor(_ identifier : String) -> Date?{
        return UserDefaults.standard.object(forKey: identifier) as? Date
    }
    
    private func pushPurchaseCallBack(response: purchaseResponse?, error: String?) {
        if canSendPurchaseCall {
            canSendPurchaseCall = false
            self.purchaseCallBack?(response, error)
        }
    }
    
    private func pushErrorInPurchaseCallBack(error: String?) {
        print("purchaseCallCount : ", purchaseCallCount)
        if purchaseCallCount == 0 {
            self.pushPurchaseCallBack(response: nil, error: error)
        } else {
            print("There are still requests in queue wait for them before sending error back")
        }
    }
    
    private func pushProductsCallBack(response: SKProductsResponse?) {
        self.loadProductsCallback?(response)
        self.loadProductsCallback = nil
    }
}

// MARK:- SKReceipt Refresh Request Delegate
extension IAPManager : SKRequestDelegate {
    
    func requestDidFinish(_ request: SKRequest) {
        print("request did finished with success")
        // Receipt request was a success now verify the receipt with 'verifyPurchase'
        if request is SKReceiptRefreshRequest {
            self.verifyPurchase()
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error){
        if request is SKReceiptRefreshRequest {
            print("receipt refresh request failed")
            self.refreshReceipt() // Send request again for fresh receipt
        }
        // Sk Products request failed
        if request is SKProductsRequest {
            self.pushProductsCallBack(response: nil)
        }
        print("request didFailWithError error: \(error.localizedDescription)")
    }
}

// MARK:- SKProducts Request Delegate
extension IAPManager: SKProductsRequestDelegate {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("response.products : ", response.products)
        
        let productList = response.products
//        Check invalid products
//        for invalidIdentifier in response.invalidProductIdentifiers {
//           print(invalidIdentifier)
//        }
        // Check if there are any products available.
        if productList.count > 0 {
//            print(" Products found")
//            for cProduct in productList {
//                print("cProduct : ", cProduct)
//                print("cProduct.localizedTitle : ", cProduct.localizedTitle)
//                print("cProduct.localizedDescription : ", cProduct.localizedDescription)
//                print("cProduct.priceLocale : ", cProduct.priceLocale)
//                print("cProduct.price : ", cProduct.price)
//            }
            self.pushProductsCallBack(response: response)
        } else {
//            print("No products found")
            self.pushProductsCallBack(response: nil)
        }
    }
}

// MARK:- SKPayment Transaction Observer
extension IAPManager: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("paymentQueue : ")
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                purchaseCallCount += 1
                print("purchased case called : ", purchaseCallCount)
                self.verifyPurchase()
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .restored:
                purchaseCallCount += 1
                print("restored case called : ", purchaseCallCount)
                self.verifyPurchase()
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                print("failed case called")
                print("purchase error : \(transaction.error?.localizedDescription ?? "")")
                self.pushPurchaseCallBack(response: nil, error: transaction.error?.localizedDescription ?? "Purchase Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .deferred, .purchasing:
                print("deferred, .purchasing case called")
                break
            default:
                print("default case called")
                break
            }
        }
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("paymentQueueRestoreCompletedTransactionsFinished : called")
        if (queue.transactions.count == 0)
        {
            print("Nothing to restore...")
            self.pushPurchaseCallBack(response: nil, error: "There is nothing to restore.")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
         //HANDLE error here
        print("restore error handler : ", error.localizedDescription)
        self.pushPurchaseCallBack(response: nil, error: error.localizedDescription)
    }
    
    func getReceiptURL() -> URL? {
        return Bundle.main.appStoreReceiptURL
    }
    
    func verifyPurchase() {
        if let isExist = try? self.getReceiptURL()?.checkResourceIsReachable(), isExist == true {
            do{
//                let receipt = try Data(contentsOf: self.getReceiptURL()!, options: .alwaysMapped)
                print("validating receipt : ")
                #if DEBUG
                    let urlString = "https://sandbox.itunes.apple.com/verifyReceipt"
                #else
                    let urlString = "https://buy.itunes.apple.com/verifyReceipt"
                #endif
                let receiptData = try Data(contentsOf: self.getReceiptURL()!).base64EncodedString()
                let requestData = ["receipt-data" : receiptData, "password" : self.sharedSecret, "exclude-old-transactions" : true] as [String : Any]
                var request = URLRequest(url: URL(string: urlString)!)
                request.httpMethod = "POST"
                request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                let httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])
                request.httpBody = httpBody
                
                URLSession.shared.dataTask(with: request)  { (data, response, error) in
                    DispatchQueue.main.async {
                        self.purchaseCallCount -= 1
                        print("updating receipt response : ", self.purchaseCallCount)
//                        print("verifyPurchase error : ", error ?? "No Error")
//                        print("verifyPurchase response : ", response ?? "No response")
//                        print("verifyPurchase data : ", data ?? "No data")
                        if data != nil {
                            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments){
//                                print("json : ", json)
                                self.parseReceipt(json as! Dictionary<String, Any>)
                            }
                        } else {
                            print("error validating receipt: \(error?.localizedDescription ?? "")")
                            self.pushErrorInPurchaseCallBack(error: error?.localizedDescription ?? "Receipt validation request failed.")
                        }
                    }
                }.resume()
            }
            catch
            {
                print("No Receipt found. Request for receipt : ")
                refreshReceipt()
            }
        } else {
            print("Receipt URL not found. Request for receipt : ")
            refreshReceipt()
        }
    }
    
    /* It's the most simple way to get latest expiration date. Consider this code as for learning purposes. You shouldn't use current code in production apps.
     This code doesn't handle errors or some situations like cancellation date.
     */
    private func parseReceipt(_ json : Dictionary<String, Any>) {
//        print("parsing the receipt : ")
        let statusCode = json["status"] as? Int
        print("statusCode : ", statusCode ?? "No code found")
        if let statusCode = statusCode {
            if statusCode == 0 {
                guard let receipts_array = json["latest_receipt_info"] as? [Dictionary<String, Any>] else {
                    print("receipts_array not found ")
                    self.pushErrorInPurchaseCallBack(error: "Latest receipt info not found in during receipt validation")
                    return
                }
                var subscriptionFound = false
                for receipt in receipts_array {
                    let productID = receipt["product_id"] as! String
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
                    if let date = formatter.date(from: receipt["expires_date"] as! String) {
                        print("receipt date ; ", date)
                        if date > Date() {
                            print("Subscription not expired : ")
                            
                            // do not save expired date to user defaults to avoid overwriting with expired date
                            saveProductInfoIfValid(newDate: date, productID: productID) // save latest expiry and latest product info
                            let response = (productId: productID, expiry: date)
                            self.pushPurchaseCallBack(response: response, error: nil)
                            subscriptionFound = true
                        }else {
//                            print("Subscription expired : ")
                        }
                    }
                }
                /// Subscription success handeld Now only handle the failed case.
                if subscriptionFound == false {
                    self.pushErrorInPurchaseCallBack(error: "Receipt found but subscription is expired")
                }
            } else {
                if let receiptError = receiptValidationStatusCodes[String(statusCode)] {
                    print("parseReceipt :  error : ", receiptError)
                    self.pushErrorInPurchaseCallBack(error: receiptError)
                } else {
                    self.pushErrorInPurchaseCallBack(error: "We're currently unable to verify your receipt. If you have an active subscription, please try using the 'Restore' option.")
                }
            }
        } else {
            self.pushErrorInPurchaseCallBack(error: "Receipt status code failed")
        }
    }
    
    /*
     Private method. Should not be called directly. Call verifyPurchase instead.
    */
    private func refreshReceipt() {
        let request = SKReceiptRefreshRequest(receiptProperties: nil)
        request.delegate = self
        request.start()
    }
    
    private func saveProductInfoIfValid(newDate: Date, productID: String) {
        let userDefaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV" // Use the same format as saved
        
        // Check if the product_expiry key exists in UserDefaults
        if let savedDateString = userDefaults.string(forKey: "product_expiry") {
            // Convert saved expiry date string back to Date
            if let savedDate = dateFormatter.date(from: savedDateString) {
                // Compare the new date with the saved expiry date
                if newDate > savedDate {
                    // Save the new date and product ID if new date is greater
                    userDefaults.set(productID, forKey: "productID")
                    userDefaults.set(dateFormatter.string(from: newDate), forKey: "product_expiry")
                    print("New date is greater. Saved new date and product ID.")
                } else {
                    print("The new date is not greater than the saved date. No changes made.", savedDate)
                }
            } else {
                print("Invalid saved expiry date format.")
            }
        } else {
            // No date saved yet, so save the new date and product ID
            userDefaults.set(productID, forKey: "productID")
            userDefaults.set(dateFormatter.string(from: newDate), forKey: "product_expiry")
            print("No expiry date found. Saved new date and product ID.")
        }
    }
    
    func isSubscriptionActive() -> Bool {
        let userDefaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV" // The format used when saving
        
        // Check if productID and product_expiry are available in UserDefaults
        if let _ = userDefaults.string(forKey: "productID"),
           let savedDateString = userDefaults.string(forKey: "product_expiry") {
            
            // Convert the saved expiry date string back to Date
            if let savedDate = dateFormatter.date(from: savedDateString) {
                // Check if the saved date is in the future (meaning subscription is still active)
                let currentDate = Date()
                
                if savedDate > currentDate {
                    // Subscription is still active
                    print("Subscription is active.")
                    print("Expiry: \(savedDate)")
                    return true
                } else {
                    // Subscription has expired
                    print("Subscription has expired.")
                    return false
                }
            } else {
                print("Invalid expiry date format.")
                return false
            }
        } else {
            // Either productID or product_expiry is missing
            print("Product ID or Expiry date not found.")
            return false
        }
    }
}
