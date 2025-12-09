//
//  AddPlayers.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class AddPlayers: UIViewController, CellDelegate, LanguageReloader {
    
    var players: [String] = []
    var nextButton = UIButton()
    let languageManager = LanguageManager()
    var hasSetButton = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableVIew
        tableView.register(UINib(nibName: C.playerTextCell, bundle: nil), forCellReuseIdentifier: C.playerTextNib)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        //Gesture regognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        reloadBackButtonLanguage()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetButton {
            createNextButton()
            hasSetButton = true
        }
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "23" {
            let destinationVC = segue.destination as! GameSelectView
            destinationVC.players = players
        }
    }
 
//MARK: - Delegate Functions
    
    func deleteCell(at index: Int) {
        guard index <= players.count else { return }
        
        players.remove(at: index)
        tableView.reloadData()
    }
    
    func addPlayer(name: String, row: Int) {
        if row >= players.count {
            players.append(name)
        } else {
            players[row] = name
        }
        tableView.reloadData()
    }
    
//MARK: - Other functions
    
    private func createNextButton() {
        let button = UIButton()
        let startButtonText = languageManager.localizedString(forKey: "NEXT")
        button.setTitle(startButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 25)
        button.backgroundColor = UIColor(named: C.purple)
        button.setTitleColor(.white, for: .normal)
        nextButton = button
        let height = view.frame.height
        let safeBottom = view.safeAreaInsets.bottom
        let buttonHeigth = 45.0
        let bottomGap = 20.0
        //print("height = \(height)")
        //print("botton = \(safeBottom)")
        let y = height - safeBottom - bottomGap - buttonHeigth
        button.frame = CGRect(x: 50, y: y, width: 140, height: buttonHeigth)
        button.center.x = view.center.x
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        view.endEditing(true)
        print("Players_ \(players)")
        if players.count < 2 {
            let alertText = languageManager.localizedString(forKey: "PLAYER_ALERT")
            showErrorAlert(text: alertText)
        } else {
            performSegue(withIdentifier: "23", sender: self)
        }
    }
    
    func reloadUILanguage() {
        let nextButtonText = languageManager.localizedString(forKey: "NEXT")
        nextButton.setTitle(nextButtonText, for: .normal)
        tableView.reloadData()
        reloadBackButtonLanguage()
        print("Reloading language in Add players VC")
    }
}

//MARK: - TableView methods

extension AddPlayers: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.playerTextNib, for: indexPath) as! TableViewTextCell
        cell.delegate = self
        cell.setPlaceholder(text: languageManager.localizedString(forKey: "ADD_PLAYER"))
        cell.row = indexPath.row
        if indexPath.row < players.count {
            cell.textField.text = players[indexPath.row]
            cell.deleteButton.isHidden = false
        } else {
            //cell.textField.text = languageManager.localizedString(forKey: "ADD_PLAYER")
            cell.textField.text = ""
            cell.deleteButton.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

//MARK: - Screen tap & alert controller

extension AddPlayers {
    
    @objc func handleScreenTap() {
        view.endEditing(true)
    }
    
    func showErrorAlert(text: String) {
        // Create the alert controller
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        
        // Add the "Selvä" action. "Selvä" = "OK" in Finnish
        let okText = languageManager.localizedString(forKey: "OK_BUTTON")
        let closeAction = UIAlertAction(title: okText, style: .default, handler: nil)
        alertController.addAction(closeAction)
        
        // Present the alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadBackButtonLanguage() {
        let backText = languageManager.localizedString(forKey: "BACK")
        self.navigationItem.backBarButtonItem?.title = backText
    }
    
}
