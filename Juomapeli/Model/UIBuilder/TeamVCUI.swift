//
//  TeamVCUI.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 2.12.2025.
//

import UIKit

struct TeamVCUI {
    
    let languagemanager = LanguageManager()
    
    func generateBackGroundImage(viewFrame: CGRect, safeArea: UIEdgeInsets, countPoints: Bool) -> UIImageView {
        
        let selectedLanguage = languagemanager.getSelectedLanguage()
        
        var backGroundImageString: String {
            if selectedLanguage == "fi" {
                if countPoints {
                    return "pisteet_raibale"
                } else {
                    return "raibale_OIKEESTIOIKEESTI"
                }
            } else {
                if countPoints {
                    return "raibale_uus_enkku"
                } else {
                    return "jampartycup_raibale"
                }
            }
        }
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: backGroundImageString)
        backgroundImage.frame = CGRect(x: 0.0, y: safeArea.top, width: viewFrame.width, height: viewFrame.height - safeArea.top - safeArea.bottom)
        
        return backgroundImage
        
    }
    
    func generateTaskLabel(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UILabel {
        
        let taskLabel = UILabel()
        taskLabel.text = ""
        taskLabel.font = UIFont.systemFont(ofSize: 18.0)
        taskLabel.textAlignment = .center
        taskLabel.numberOfLines = 0
        taskLabel.textColor = .black
        if C.testUIWithColors {taskLabel.backgroundColor = .yellow  }
            
            
            let height: CGFloat = 300.0
            let width: CGFloat = viewFrame.width - 150
            let x: CGFloat = 75
            let y: CGFloat = (viewFrame.height - safeArea.top - safeArea.bottom) / 2 + safeArea.top - (height / 2)
            
            taskLabel.frame = CGRect(x: x, y: y, width: width, height: height)
            
            if C.testUIWithColors { taskLabel.backgroundColor = .yellow }
            
            return taskLabel
            
        }
    
    func generateRedTeamButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> PointButtonComponents {
        
        let yesView = UIImageView()
        yesView.image = UIImage(named: "kuppi_puna")
        yesView.clipsToBounds = false // 👈 important!

        // Add shadow
        yesView.layer.shadowColor = UIColor.black.cgColor
        yesView.layer.shadowOpacity = 0.08
        yesView.layer.shadowOffset = CGSize(width: 0, height: 4)
        yesView.layer.shadowRadius = 6
        
        let width: CGFloat = 170.0
        let heigth: CGFloat = 85.0
        let x: CGFloat = 25.0
        let y: CGFloat = viewFrame.height - safeArea.bottom - 85.0 - heigth
        
        yesView.frame = CGRect(x: x, y: y, width: width, height: heigth)
        
        if C.testUIWithColors { yesView.backgroundColor = .green }
        
        let label = UILabel()
        label.text = "1"
        label.font = UIFont(name: "Optima-Bold", size: 25.0)
        label.textAlignment = .center
        label.textColor = .black
        
        label.frame = CGRect(x: 65.0, y: 0.0, width: 85.0, height: 85.0)
        
        yesView.addSubview(label)
        
        return PointButtonComponents(container: yesView, label: label)
        
    }
        
    func generateBlueTeamButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> PointButtonComponents {
        
        let noView = UIImageView()
        noView.image = UIImage(named: "kuppi_sini")
        noView.clipsToBounds = false // 👈 important!

        // Add shadow
        noView.layer.shadowColor = UIColor.black.cgColor
        noView.layer.shadowOpacity = 0.08
        noView.layer.shadowOffset = CGSize(width: 0, height: 4)
        noView.layer.shadowRadius = 6
        
        let width: CGFloat = 170.0
        let heigth: CGFloat = 85.0
        let x: CGFloat = viewFrame.width - 25.0 - width
        let y: CGFloat = viewFrame.height - safeArea.bottom - 85 - heigth
        
        noView.frame = CGRect(x: x, y: y, width: width, height: heigth)
        
        if C.testUIWithColors { noView.backgroundColor = .green }
        
        let label = UILabel()
        label.text = "1"
        label.font = UIFont(name: "Optima-Bold", size: 25.0)
        label.textAlignment = .center
        label.textColor = .black
        
        label.frame = CGRect(x: 15.0, y: 0.0, width: 85.0, height: 85.0)
        
        noView.addSubview(label)
        
        return PointButtonComponents(container: noView, label: label)
        
    }
    
    func generatePointInstructionView(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UIView {
        //let language = LanguageManager().getSelectedLanguage()
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 10
        
        let x: CGFloat = 30.0
        let width: CGFloat = viewFrame.width - 2 * x
        let height: CGFloat = 200.0
        let y: CGFloat = (viewFrame.height - safeArea.bottom - safeArea.top) / 2 + safeArea.top - height / 2
        
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        
        let bgLabel = UILabel()
        bgLabel.backgroundColor = .white
        bgLabel.layer.cornerRadius = 10
        bgLabel.layer.masksToBounds = true  // IMPORTANT
        view.addSubview(bgLabel)
        bgLabel.frame = view.bounds
        
        
        let label = UILabel()
        label.text = languagemanager.localizedString(forKey: "POINT_INSTRUCTIONS_TEAM")
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.backgroundColor = .white
        
        // Rounded corners + clipping
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true  // IMPORTANT
        view.addSubview(label)
        label.frame = CGRect(x: 10, y: 10, width: view.frame.width - 20, height: view.frame.height - 20)
        
        return view
    }
    
    func generateRedTeamView(viewFrame: CGRect) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "redTeamColor")
        view.frame = CGRect(x: 0, y: 0, width: viewFrame.width / 2, height: viewFrame.height)
        if C.testUIWithColors { view.alpha = 0.4 }
        return view
    }
    
    func generateBlueTeamView(viewFrame: CGRect) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "blueTeamColor")
        view.frame = CGRect(x: viewFrame.width / 2, y: 0, width: viewFrame.width / 2, height: viewFrame.height)
        if C.testUIWithColors { view.alpha = 0.4 }
        return view
    }
    
    func generatePlayerLabel(viewFrame: CGRect, player: String) -> UILabel {
        
        let width = viewFrame.width / 2 - 10
        let x = viewFrame.width / 2 - width / 2 - 5.0
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "MarkerFelt-Wide", size: 15.0)
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "\(player)"
            
        label.frame = CGRect(x: x, y: 250.0, width: width, height: 50)
        
        return label
        
    }
    
    func generateRandomizeButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: C.purple)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20.0)
        button.titleLabel?.textAlignment = .center
        button.tintColor = .white
        button.setTitle(languagemanager.localizedString(forKey: "RANDOMIZE"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        let gap: CGFloat = 15.0
        let heigth: CGFloat = 50.0
        let x: CGFloat = gap
        let y: CGFloat = viewFrame.height - safeArea.bottom - heigth - gap - 20.0
        let width: CGFloat = viewFrame.width / 2 - gap * 2
        
        button.frame = CGRect(x: x, y: y, width: width, height: heigth)
        
        return button
    }
    
    func generateStartGameButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(named: C.purple)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 20.0)
        button.titleLabel?.textAlignment = .center
        button.tintColor = .white
        button.setTitle(languagemanager.localizedString(forKey: "START_TEAM_GAME"), for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        
        let gap: CGFloat = 15.0
        let heigth: CGFloat = 50.0
        let x: CGFloat = gap + viewFrame.width / 2
        let y: CGFloat = viewFrame.height - safeArea.bottom - heigth - gap - 20.0
        let width: CGFloat = viewFrame.width / 2 - gap * 2
        
        button.frame = CGRect(x: x, y: y, width: width, height: heigth)
        
        return button
    }
    
    func generateRedTeamHeaderView(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: C.wordGameFont, size: 25.0)
        label.text = languagemanager.localizedString(forKey: "RED_TEAM")
        label.backgroundColor = .clear
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 2, height: 2)
        
        if C.testUIWithColors { label.backgroundColor = .black }
        
        let gap: CGFloat = 5.0
        let heigth: CGFloat = 80.0
        let x: CGFloat = gap
        let y: CGFloat = safeArea.top
        let width: CGFloat = viewFrame.width / 2 - gap * 2
        
        label.frame = CGRect(x: x, y: y, width: width, height: heigth)
        return label
        
    }
    
    func generateBlueTeamHeaderView(viewFrame: CGRect, safeArea: UIEdgeInsets) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: C.wordGameFont, size: 25.0)
        label.text = languagemanager.localizedString(forKey: "BLUE_TEAM")
        label.backgroundColor = .clear
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 2, height: 2)
        
        if C.testUIWithColors { label.backgroundColor = .black }
        
        let gap: CGFloat = 5.0
        let heigth: CGFloat = 80.0
        let x: CGFloat = viewFrame.width / 2 + gap
        let y: CGFloat = safeArea.top
        let width: CGFloat = viewFrame.width / 2 - gap / 2
        
        label.frame = CGRect(x: x, y: y, width: width, height: heigth)
        return label
        
    }
    
}

struct TeamUIElements {
    var backGroundImage = UIImageView()
    var taskLabel = UILabel()
    var redTeamButton: PointButtonComponents?
    var blueTeamVButton: PointButtonComponents?
    var instructionView = UIView()
    var redView = UIView()
    var blueView = UIView()
    var redHeader = UILabel()
    var blueHeader = UILabel()
    var randomizeButton = UIButton()
    var startButton = UIButton()
    var playerLabels = [UILabel]()
    
    init(backGroundImage: UIImageView = UIImageView(), taskLabel: UILabel = UILabel(), redTeamButton: PointButtonComponents? = nil, blueTeamVButton: PointButtonComponents? = nil, instructionView: UIView = UIView(), redView: UIView = UIView(), blueView: UIView = UIView(), redHeader: UILabel = UILabel(), blueHeader: UILabel = UILabel(), randomizeButton: UIButton = UIButton(), startButton: UIButton = UIButton(), playerLabels: [UILabel] = [UILabel]()) {
        self.backGroundImage = backGroundImage
        self.taskLabel = taskLabel
        self.redTeamButton = redTeamButton
        self.blueTeamVButton = blueTeamVButton
        self.instructionView = instructionView
        self.redView = redView
        self.blueView = blueView
        self.redHeader = redHeader
        self.blueHeader = blueHeader
        self.randomizeButton = randomizeButton
        self.startButton = startButton
        self.playerLabels = playerLabels
    }
}
