//
//  ViewController.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit
import StoreKit

class Start: UIViewController {
    
//    let subData = SubscriptionData()
//    let subManager = SubscriptionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPManager.shared.start()  // initialize the IAP manager to handle auto renew subscriptions
        setUpUI()
        let hasActiveSubscription = IAPManager.shared.isSubscriptionActive()
        print("User has active subscription: \(hasActiveSubscription)")
       
    }
    
    
    
    

    @IBAction func startPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "12", sender: self)
    }
    
    private func setUpUI() {
        
        let ukot = UIImageView()
        ukot.image = UIImage(named: "20")
        ukot.contentMode = .scaleAspectFill
        ukot.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ukot)
        
        
        let image = UIImageView()
        image.image = UIImage(named: "alkutausta")
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        view.sendSubviewToBack(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ukot.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ukot.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ukot.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            ukot.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5)
        ])
    }
   
}

