//
//  ProView.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 25.7.2024.
//

import UIKit
import StoreKit

struct ProductInfo {
    var product: SKProduct?
    var isAvailable: Bool
}

class ProView: UIViewController {
    
    
    @IBOutlet weak var yearlyButton: UILabel!
    @IBOutlet weak var monthlyButton: UILabel!
    @IBOutlet weak var weeklyButton: UILabel!
    
    var activityIndicator: UIActivityIndicatorView!
    
    let weeklyKey = "weeklySubscription"
    let monthlyKey = "monthlySubscription"
    let yearlyKey = "yearlySubscription"
    
    let productIds: Set<String> = [
        "weeklySubscription",
        "monthlySubscription",
        "yearlySubscription"
    ]
    
    var productToBuy: [String: ProductInfo] = [:]
    
    // Example of checking if a product is available
    func isProductAvailable(productIdentifier: String) -> Bool? {
        return productToBuy[productIdentifier]?.isAvailable
    }
    
    func productsListener(response: SKProductsResponse?) {
        if let response = response {
//                print("productsCallback response : ", response)
            let productList = response.products
            for cProduct in productList {
//                    print("cProduct : ", cProduct)
//                    print("cProduct.localizedTitle : ", cProduct.localizedTitle)
//                    print("cProduct.localizedDescription : ", cProduct.localizedDescription)
//                    print("cProduct.priceLocale : ", cProduct.priceLocale)
//                    print("cProduct.price : ", cProduct.price)
                print("cProduct.productIdentifier : ", cProduct.productIdentifier)
                
                if var existingProductInfo = productToBuy[cProduct.productIdentifier] {
                    // If it exists, update its values
                    existingProductInfo.product = cProduct
                    existingProductInfo.isAvailable = true
                    productToBuy[cProduct.productIdentifier] = existingProductInfo
                    print("Product updated: \(existingProductInfo)")
                    DispatchQueue.main.async {
                        self.updateButtonStates() // update the button states
                    }
                } else {
                    // If the product doesn't exist, you can choose to add it (this part is optional)
                    print("Product not found in productToBuy dictionary: \(cProduct.productIdentifier)")
                }
            }
        }else {
            print("An error occured while fetching the product list")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        discountLabel()
        setUpActivityIndicator()
        loadProducts()
    }
    
    func purchaseCallBackListener(response: purchaseResponse?, error: String?) {
        print("purchase call back ", response ?? "No Response")
        if let error = error {
            print("Error Occured during purchase : ", error)
            showAlert(alertText: "Error while purchasing : \(error)")
        } else if let response = response {
            print("purchase success and product id is : ", response.productId, response.expiry)
            showAlert(alertText: "Subscription purchased : \(response.productId). Expiry at \(response.expiry)", isSuccess: true)
            print("Subscription purchased successfully move on now!!!!!!!")
        }
        stopLoading()
    }
    
    
    //Button for yearly subscription
    @objc func yearlyButtonTapped() {
        print("Yearly tapped")
        if let existingProductInfo = productToBuy[yearlyKey],
            existingProductInfo.isAvailable,
            let product = existingProductInfo.product {
            print("yearly product available to buy")
            startLoading()
            IAPManager.shared.purchase(product: product, callback: purchaseCallBackListener)
        } else {
            print("yearly product not available to buy")
        }
    }
    
    //Button for monthly subscription
    @objc func monthlyButtonTapped() {
        print("Monthly tapped")
        if let existingProductInfo = productToBuy[monthlyKey],
            existingProductInfo.isAvailable,
            let product = existingProductInfo.product {
            print("Monthly product available to buy")
            startLoading()
            IAPManager.shared.purchase(product: product, callback: purchaseCallBackListener)
        } else {
            print("Monthly product not available to buy")
        }
    }
    
    //Button for weekly subscription
    @objc func weeklyButtonTapped() {
        print("Weekly tapped")
        if let existingProductInfo = productToBuy[weeklyKey],
            existingProductInfo.isAvailable,
            let product = existingProductInfo.product {
            print("weekly product available to buy")
            startLoading()
            IAPManager.shared.purchase(product: product, callback: purchaseCallBackListener)
        } else {
            print("weekly product not available to buy")
        }
    }
    
    @IBAction func restoreButtonPressed(_ sender: UIButton) {
        print("Restore button tapped")
        func restoreCallBackListener(response: purchaseResponse?, error: String?) {
            print("restore call back ", response ?? "No Response")
            if let error = error {
                print("Error Occured during restore : ", error)
                showAlert(alertText: "Error while restoring : \(error)")
            } else if let response = response {
                print("Restore success and product id is : ", response.productId, response.expiry)
                showAlert(alertText: "Subscription restored : \(response.productId). Expiry at \(response.expiry)", isSuccess: true)
            }
            stopLoading()
        }
        startLoading()
        IAPManager.shared.restore(callback: restoreCallBackListener)
    }
    
}

extension ProView {
    private func setUpUI() {
        
        let roundness: CGFloat = 20
        
        yearlyButton.clipsToBounds = true
        monthlyButton.clipsToBounds = true
        weeklyButton.clipsToBounds = true
        yearlyButton.layer.cornerRadius = roundness
        monthlyButton.layer.cornerRadius = roundness
        weeklyButton.layer.cornerRadius = roundness
        weeklyButton.text = "   0.99€ / viikko" //"Viikko" = "week"
        monthlyButton.text = "   3.99€ / kuukausi" //"Kuukausi" = "Month"
        yearlyButton.text = "   9.99€ / vuosi" //"Vuosi" = "year"
        
        yearlyButton.isUserInteractionEnabled = true
        monthlyButton.isUserInteractionEnabled = true
        weeklyButton.isUserInteractionEnabled = true
        
        yearlyButton.translatesAutoresizingMaskIntoConstraints = false
        monthlyButton.translatesAutoresizingMaskIntoConstraints = false
        weeklyButton.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(yearlyButtonTapped))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(monthlyButtonTapped))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(weeklyButtonTapped))
        
        yearlyButton.addGestureRecognizer(tapGesture1)
        monthlyButton.addGestureRecognizer(tapGesture2)
        weeklyButton.addGestureRecognizer(tapGesture3)
        
        addShadow(to: yearlyButton)
        addShadow(to: monthlyButton)
        addShadow(to: weeklyButton)
    }
    
    private func discountLabel() {
        // Create the UIImageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "discount")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the UIImageView to the view
        view.addSubview(imageView)
        
        // Set constraints for the UIImageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            imageView.centerYAnchor.constraint(equalTo: yearlyButton.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),  // Adjust width as needed
            imageView.heightAnchor.constraint(equalToConstant: 200)  // Adjust height as needed
        ])
    }
    
    private func addShadow(to label: UILabel) {
        label.layer.shadowColor = UIColor.black.cgColor // Ensure the shadow color contrasts with the label's background
        label.layer.shadowOffset = CGSize(width: 2, height: 50) // Adjust to your preference
        label.layer.shadowOpacity = 0.7 // Ensure the opacity is high enough to see
        label.layer.shadowRadius = 10 // Adjust to your preference
    }
    
    private func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)  // You can choose .medium or .large
        activityIndicator.center = view.center  // Center the spinner on the screen
        view.addSubview(activityIndicator)  // Add it to the view hierarchy

        // Optionally, set a color
        activityIndicator.color = .black
    }
    
    private func loadProducts() {
        // Start StoreKit when the user views the subscription screen
        for productId in productIds {
            let productInfo = ProductInfo(product: nil, isAvailable: false)
            productToBuy[productId] = productInfo
        }
        
        IAPManager.shared.loadProducts(productIds: productIds, callback: productsListener)
    }
    
    func updateButtonStates() {
        for productId in productIds {
            // Check if the product is available
            if let productInfo = productToBuy[productId], productInfo.isAvailable {
                // Enable the button related to the product
                switch productId {
                case weeklyKey:
//                    weeklyButton.text = "   \(productInfo.product?.price ?? 0) / viikko"
                    if let product = productInfo.product {
                        let price = product.price
                        let priceLocale = product.priceLocale
                        
                        // Format the price
                        let priceFormatter = NumberFormatter()
                        priceFormatter.numberStyle = .currency
                        priceFormatter.locale = priceLocale
                                
                        if let formattedPrice = priceFormatter.string(from: price) {
                            print("weekly Product price: \(formattedPrice)")
                            weeklyButton.text = "   \(formattedPrice) / viikko"
                        }
                    }
                case monthlyKey:
                    if let product = productInfo.product {
                        let price = product.price
                        let priceLocale = product.priceLocale
                        
                        // Format the price
                        let priceFormatter = NumberFormatter()
                        priceFormatter.numberStyle = .currency
                        priceFormatter.locale = priceLocale
                                
                        if let formattedPrice = priceFormatter.string(from: price) {
                            print("monthly Product price: \(formattedPrice)")
                            monthlyButton.text = "   \(formattedPrice) / kuukausi"
                        }
                    }
                case yearlyKey:
                    if let product = productInfo.product {
                        let price = product.price
                        let priceLocale = product.priceLocale
                        
                        // Format the price
                        let priceFormatter = NumberFormatter()
                        priceFormatter.numberStyle = .currency
                        priceFormatter.locale = priceLocale
                                
                        if let formattedPrice = priceFormatter.string(from: price) {
                            print("yearly Product price: \(formattedPrice)")
                            yearlyButton.text = "   \(formattedPrice) / vuosi"
                        }
                    }
                default:
                    break
                }
            }
        }
    }
    
    func showAlert(alertText: String, isSuccess: Bool = false) {
        // Create an alert controller
        let alert = UIAlertController(title: "Alert",
                                      message: alertText,
                                      preferredStyle: .alert)
        
        // Add an action (button) to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button tapped")
            if (isSuccess) {
                self.dismiss(animated: true)
            }
        }
        alert.addAction(okAction)
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()  // Start the spinner animation
        view.isUserInteractionEnabled = false  // Disable user interaction while loading
    }
    
    // Stop the spinner when done
    func stopLoading() {
        activityIndicator.stopAnimating()  // Stop the spinner animation
        view.isUserInteractionEnabled = true  // Re-enable user interaction after loading
    }

}
