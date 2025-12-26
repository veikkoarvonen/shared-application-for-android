//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit

class GameSelectView: UIViewController, valueDelegate, LanguageReloader {
    
//MARK: Variables & IBOutlets
    
    var players: [String] = []
    var categoryForGame: Int = 0
    var tierValueForGame: Float = 3.0
    var drinkValueForGame: Float = 3.0
    var shouldPopProVC: Bool = false
    let languageManager = LanguageManager()
    var UIElements = GameSelectVCUI()
    var hasSetUI = false
    
    @IBOutlet weak var tableView: UITableView!
    
//MARK: - UI Elements
    
    var settingsButtonLabel = UIView()
    var settingsView: SettingsViewComponents?
    var settingsViewIsEnabled = false
    var countPointsInGame = false
    var isShorterRound = false
    
//MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: C.gamemodeCell, bundle: nil), forCellReuseIdentifier: C.gamemodeNIb)
        tableView.dataSource = self
        tableView.delegate = self
        reloadBackButtonLanguage()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetUI {
            setUpUI()
            hasSetUI = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldPopProVC && !IAPManager.shared.isSubscriptionActive() {
            performSegue(withIdentifier: "pro", sender: self)
            shouldPopProVC = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "34" {
            let destinationVC = segue.destination as! GameView
            
            destinationVC.gameConfiguration = GameConfiguration(players: players, numberOfTasks: 30, gameCategory: categoryForGame, intensityValue: tierValueForGame, penaltyValue: drinkValueForGame, countPoints: countPointsInGame, shorterRound: isShorterRound)
        } else if segue.identifier == "team" {
            let destinationVC = segue.destination as! TeamView
            
            destinationVC.gameConfiguaration = TeamModeConfiguration(players: players, numberOfTasks: 30, countPoints: true, shorterRound: isShorterRound, teamConfigurationIndexes: [])
        }
    }
    
    func reloadBackButtonLanguage() {
        let backText = languageManager.localizedString(forKey: "BACK")
        self.navigationItem.backBarButtonItem?.title = backText
    }
    
    
//MARK: - Objc functions
    
    @objc private func handleGearTap() {
        print("Gear icon tapped")
        if settingsViewIsEnabled {
            disableSettingsView()
        } else {
            enableSettingsView()
        }
    }
    
    @objc private func handleCrossTap() {
        print("Cross icon tapped")
        if settingsViewIsEnabled {
            disableSettingsView()
        } else {
            enableSettingsView()
        }
    }
    
    @objc private func pointSwitchChanged(_ sender: UISwitch) {
        guard IAPManager.shared.isSubscriptionActive() else {
            performSegue(withIdentifier: "pro", sender: self)
            sender.isOn = false
            return
        }
        print("Point switch is now: \(sender.isOn)")
        countPointsInGame = sender.isOn
    }
    
    @objc private func lengthSwitchChanged(_ sender: UISwitch) {
        guard IAPManager.shared.isSubscriptionActive() else {
            performSegue(withIdentifier: "pro", sender: self)
            sender.isOn = false
            return
        }
        print("Length switch is now: \(sender.isOn)")
        isShorterRound = sender.isOn
    }
    
//MARK: - Settings view slide
    
    private func enableSettingsView() {
        guard let container = settingsView?.container else { return }
        
        settingsViewIsEnabled = true
        view.isUserInteractionEnabled = false
        animateSettingsGear(clockWise: true)
        tableView.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut]) {
            container.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            self.settingsButtonLabel.transform = CGAffineTransform(rotationAngle: .pi * 2)
            self.tableView.alpha = 0.3
            self.navigationController?.navigationBar.alpha = 0.3
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
            //print("Settingsview frame: \(self.settingsView!.container.frame)")
        }
    }

    
    private func disableSettingsView() {
        guard let container = settingsView?.container else { return }
        
        container.isHidden = false
        settingsViewIsEnabled = false
        view.isUserInteractionEnabled = false
        animateSettingsGear(clockWise: false)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn]) {
            container.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
            self.settingsButtonLabel.transform = CGAffineTransform(rotationAngle: .pi * -2)
            self.tableView.alpha = 1.0
            self.navigationController?.navigationBar.alpha = 1.0
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
            self.tableView.isUserInteractionEnabled = true
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
        }
    }
    
    private func animateSettingsGear(clockWise: Bool) {
        let gear = settingsButtonLabel

        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        
        var rotationValue: CGFloat {
            if clockWise {
                return CGFloat.pi * 2
            } else {
                return CGFloat.pi * -2
            }
        }
        
        rotation.toValue = rotationValue
        rotation.duration = 0.5
        rotation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        gear.layer.add(rotation, forKey: "rotate")
    }


    
    
//MARK: - Handle cells' sliders value change
    
    func setValue(to: Float, forTier: Bool) {
        if forTier {
            tierValueForGame = to
        } else {
            drinkValueForGame = to
        }
    }
    
//MARK: - Reload language
    
    func reloadUILanguage() {
        tableView.reloadData()
        reloadBackButtonLanguage()
        print("Reloading language in Game select VC")
        guard (settingsView != nil) else {
            print("SettingsView is nil, cannot reload language")
            return
        }
        settingsView?.pointHeaderLabel.text = languageManager.localizedString(forKey: "POINTS_HEADER")
        settingsView?.pointDescLabel.text = languageManager.localizedString(forKey: "POINTS_DESCRIPTION")
        settingsView?.lengthHeaderLabel.text = languageManager.localizedString(forKey: "LENGTH_HEADER")
        settingsView?.lengthDescLabel.text = languageManager.localizedString(forKey: "LENGTH_DESCRIPTION")
    }
    
    

}

//MARK: - TableView mathods

extension GameSelectView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalHeight: Double = 160
        let extremeHeight: Double = 220
        if indexPath.row == 3 {
            return extremeHeight + 140
        } else {
            return normalHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.gamemodeNIb, for: indexPath) as! GameModeCell
        cell.delegate = self
        
        //Headers and rules
        cell.intensityMeter.text = languageManager.localizedString(forKey: "INTENSITY_METER")
        cell.penaltyMeter.text = languageManager.localizedString(forKey: "PENALTY_METER")
        
        if indexPath.row == 0 {
            cell.header.text = languageManager.localizedString(forKey: "HEADER_BASIC")
            cell.rules.text = languageManager.localizedString(forKey: "PARAGRAPH_BASIC")
        } else if indexPath.row == 1 {
            cell.header.text = languageManager.localizedString(forKey: "HEADER_DATES")
            cell.rules.text = languageManager.localizedString(forKey: "PARAGRAPH_DATES")
        } else if indexPath.row == 2 {
            cell.header.text = languageManager.localizedString(forKey: "HEADER_TEAM")
            cell.rules.text = languageManager.localizedString(forKey: "PARAGRAPH_TEAM")
        } else if indexPath.row == 3 {
            cell.header.text = languageManager.localizedString(forKey: "HEADER_EXTREME")
            cell.rules.text = languageManager.localizedString(forKey: "PARAGRAPH_EXTREME")
        } else {
            cell.header.text = languageManager.localizedString(forKey: "HEADER_EXPLAIN")
            cell.rules.text = languageManager.localizedString(forKey: "PARAGRAPH_EXPLAIN")
        }
        
        cell.rules.font = .systemFont(ofSize: 15.8)
        
        if indexPath.row != 3 {
            cell.lowerView.isHidden = true
        } else {
            cell.lowerView.isHidden = false
        }
        
        if let imageView = cell.customImageView {
            imageView.image = Cells.images[indexPath.row]
        } else {
            print("Image view is nil")
        }
        
//MARK: - Override paywall here for colors
        
        let hasPlus = IAPManager.shared.isSubscriptionActive()
        
        if indexPath.row != 0 && !hasPlus {
            cell.header.textColor = .orange //Orange
        } else {
            cell.header.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var category: Int
        
        switch indexPath.row {
        case 0: category = 0
        case 1: category = 1
        case 2: category = 2
        case 3: category = 3
        case 4: category = 4
        default: category = 0
        }
        
        categoryForGame = category
        
        //MARK: - Override paywall here for testing
        let hasPlus = IAPManager.shared.isSubscriptionActive()
        
        //pro VC - User doesn't have plus sub
        if indexPath.row != 0 && !hasPlus {
            performSegue(withIdentifier: "pro", sender: self)
        //Next VC - User has plus sub or selects basic game
        } else {
            //pop pro VC after round if user doesn't have plus sub
            if !hasPlus { shouldPopProVC = true }
            if category == 2 {
                //Team mode
                performSegue(withIdentifier: "team", sender: self)
            } else if category == 4 {
                //Explain mode
                performSegue(withIdentifier: "word", sender: self)
            } else {
                //Basic, date & Extreme
                performSegue(withIdentifier: "34", sender: self)
            }
        }
    }
}

//MARK: - Set up UI

extension GameSelectView {
    
    private func setUpUI() {
        // Settings button (⚙️)
        let settingsButtonView = UIElements.generateSettingsButtonView(
            viewFrame: view.frame,
            safeArea: view.safeAreaInsets
        )
        view.addSubview(settingsButtonView)
        settingsButtonLabel = settingsButtonView  // assuming this is UIView
        
        // Settings modal view
        let components = UIElements.generateSettingsView(
            viewFrame: view.frame,
            safeArea: view.safeAreaInsets
        )
        
        view.addSubview(components.container)
        settingsView = components
        
        
        // 🔹 Tap on ⚙️ opens settings
        let openTap = UITapGestureRecognizer(target: self, action: #selector(handleGearTap))
        settingsButtonView.isUserInteractionEnabled = true
        settingsButtonView.addGestureRecognizer(openTap)
        
        
        // 🔹 Tap on ❌ closes settings
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(handleCrossTap))
        components.crossLabel.isUserInteractionEnabled = true
        components.crossLabel.addGestureRecognizer(closeTap)
        
        
        // 🔹 Switch targets
        components.pointSwitch.addTarget(
            self,
            action: #selector(pointSwitchChanged(_:)),
            for: .valueChanged
        )
        
        components.lengthSwitch.addTarget(
            self,
            action: #selector(lengthSwitchChanged(_:)),
            for: .valueChanged
        )
        
        //print("Settingsview frame: \(settingsView?.container.frame)")
        
    }
}
