//
//  Settings.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 25.7.2024.
//

import UIKit
import StoreKit

class SettingsView: UIViewController {
    
    
//MARK: - NOTE: "Restore purchases funtionality in section 2, row 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let headers = Settings.headers
    let items = Settings.sections
    let ud = UD()
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setUpActivityIndicator()
      
    }
    
}

extension SettingsView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: C.purple)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = headers[section]
        label.font = UIFont(name: "Marker Felt", size: 18)
        label.textColor = .white
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Settings.sections[section]
        let count = section.count
        return count
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let section = Settings.sections[indexPath.section]
            let text = section[indexPath.row]
            cell.textLabel?.text = text
            cell.textLabel?.numberOfLines = 0
            cell.accessoryType = .disclosureIndicator
            if indexPath.section == 1 && indexPath.row == 0 {
                cell.accessoryType = .none
            }
            
//            if indexPath.section == 2 && indexPath.row == 0 &&
//                
//            }
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Handle cell selection
            tableView.deselectRow(at: indexPath, animated: true)
            
            let links = ["https://veikkoarvonen.github.io/juhlapeli/","https://veikkoarvonen.github.io/juhlapeli/HTML/tietosuoja.html","https://veikkoarvonen.github.io/juhlapeli/HTML/kauttoehdot.html","https://veikkoarvonen.github.io/juhlapeli/HTML/vastuullisuus.html"]
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    print("Perussivu")
                    openURL(link: links[0])
                } else if indexPath.row == 1 {
                    print("Tietosuoja")
                    openURL(link: links[1])
                } else if indexPath.row == 2 {
                    print("Käyttöehdot")
                    openURL(link: links[2])
                }
            } else if indexPath.section == 1 {
                if indexPath.row == 1 {
                    print("Vastuullisuus")
                    openURL(link: links[3])
                }
            } else if indexPath.section == 2 {
                if indexPath.row == 0 {
                    print("Restore button tapped")
                    if !IAPManager.shared.isSubscriptionActive() {
                        func restoreCallBackListener(response: purchaseResponse?, error: String?) {
                            print("restore call back ", response ?? "No Response")
                            if let error = error {
                                print("Error Occured during restore : ", error)
                                showAlert(alertText: "Error while restoring : \(error)")
                            } else if let response = response {
                                print("Restore success and product id is : ", response.productId, response.expiry)
                                showAlert(alertText: "Subscription restored : \(response.productId). Expiry at \(response.expiry)")
                            }
                            stopLoading()
                        }
                        startLoading()
                        IAPManager.shared.restore(callback: restoreCallBackListener)
                    }else{
                        // Create an alert controller
                        let alert = UIAlertController(title: "Alert",
                                                      message: "You already have an active subscription.",
                                                      preferredStyle: .alert)
                        
                        // Add an action (button) to dismiss the alert
                        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            print("OK button tapped")
                        }
                        alert.addAction(okAction)
                        
                        // Present the alert
                        present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            
        }
    
    
    func openURL(link: String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid URL or cannot be opened")
        }

    }
    
    func showAlert(alertText: String) {
        // Create an alert controller
        let alert = UIAlertController(title: "Alert",
                                      message: alertText,
                                      preferredStyle: .alert)
        
        // Add an action (button) to dismiss the alert
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button tapped")
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
    
    private func setUpActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)  // You can choose .medium or .large
        activityIndicator.center = view.center  // Center the spinner on the screen
        view.addSubview(activityIndicator)  // Add it to the view hierarchy

        // Optionally, set a color
        activityIndicator.color = .black
    }
}
