//
//  GameVCUI.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 15.11.2025.
//

import UIKit

struct GameVCUI {
    
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
        
    func generateYesButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> PointButtonComponents {
        
        let yesView = UIImageView()
        yesView.image = UIImage(named: "points-right")
        yesView.clipsToBounds = false // 👈 important!

        // Add shadow
        yesView.layer.shadowColor = UIColor.black.cgColor
        yesView.layer.shadowOpacity = 0.08
        yesView.layer.shadowOffset = CGSize(width: 0, height: 4)
        yesView.layer.shadowRadius = 6
        
        let width: CGFloat = 170.0
        let heigth: CGFloat = 85.0
        let x: CGFloat = 25.0
        let y: CGFloat = viewFrame.height - safeArea.bottom - 110 - heigth
        
        yesView.frame = CGRect(x: x, y: y, width: width, height: heigth)
        
        if C.testUIWithColors { yesView.backgroundColor = .green }
        
        let label = UILabel()
        label.text = "+1"
        label.font = UIFont(name: "Optima-Bold", size: 25.0)
        label.textAlignment = .center
        label.textColor = .black
        
        label.frame = CGRect(x: 65.0, y: 0.0, width: 85.0, height: 85.0)
        
        yesView.addSubview(label)
        
        return PointButtonComponents(container: yesView, label: label)
        
    }
        
    func generateNoButton(viewFrame: CGRect, safeArea: UIEdgeInsets) -> PointButtonComponents {
        
        let noView = UIImageView()
        noView.image = UIImage(named: "points-wrong")
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
        label.text = "0"
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
        label.text = languagemanager.localizedString(forKey: "POINT_INSTRUCTIONS")
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
        
}

struct PointButtonComponents {
    let container: UIImageView
    let label: UILabel
}

struct GameVCUIElements {
    var backGroundImage = UIImageView()
    var taskLabel = UILabel()
    var yesView: PointButtonComponents?
    var noView: PointButtonComponents?
    var instructionView = UIView()
    
    init(backGroundImage: UIImageView = UIImageView(), taskLabel: UILabel = UILabel(), yesView: PointButtonComponents? = nil, noView: PointButtonComponents? = nil, instructionView: UIView = UIView()) {
        self.backGroundImage = backGroundImage
        self.taskLabel = taskLabel
        self.yesView = yesView
        self.noView = noView
        self.instructionView = instructionView
    }
}
