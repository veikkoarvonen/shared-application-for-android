//
//  WordVC.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 2.12.2025.
//

import UIKit

class WordView: UIViewController {
    
    var hasSetUI = false
    var gameParameters: WordGameParameters!
    let UIBuilder = WordVCUI()
    var UIElements: WordVCUIElements!
    let languageManager = LanguageManager()
    
    enum GameState {
        case instructions
        case animation
        case playing
        case gameOver
    }
    
    var gameState: GameState = .instructions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetUI {
            hasSetUI = true
            setGameParameters()
            generateUI()
            displayInstructions()
        }
    }
    
    @objc func handleScreenTap() {
        if gameState == .instructions {
            displayAnimation()
        } else if gameState == .gameOver {
            navigationController?.popViewController(animated: true)
        }
    }

//MARK: - Pan gesture
    
    @objc private func handleWordPan(_ gesture: UIPanGestureRecognizer) {
           let translation = gesture.translation(in: view)
           let velocity = gesture.velocity(in: view)

           switch gesture.state {
           case .changed:
               let rotationAngle = translation.x / view.frame.width * (.pi / 4 )
               // Move the container
               UIElements.wordContainer!.container.transform = CGAffineTransform(
                   translationX: translation.x,
                   y: 0
               ).rotated(by: rotationAngle)
               
           case .ended, .cancelled:
               // Snap back or animate somewhere — your choice
                   if velocity.x < -1000 {
                       newWord(didScorePoint: false)
                   } else if velocity.x > 1000 {
                       newWord(didScorePoint: true)
                   } else {
                       if translation.x > view.frame.width / 4 {
                           newWord(didScorePoint: true)
                       } else if translation.x < view.frame.width / -4 {
                           newWord(didScorePoint: false)
                       } else {
                           UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) { [self] in
                               self.UIElements.wordContainer!.container.transform = .identity
                           }
                       }
                   }
               
               default: break
           }
       }
    
//MARK: Instructions
    
    private func displayInstructions() {
        UIElements.instructionLabel.text = languageManager.localizedString(forKey: "WORDGAME_INSTRUCTIONS")
        UIElements.timeLabel.isHidden = true
        UIElements.wordContainer?.container.isHidden = true
        UIElements.pointLabel.isHidden = true
    }
    
//MARK: - Animations
    
    //Label swiping animation (Beginning of the game)
    private func displayAnimation() {
        if C.debugApp { print("displaying animation, setting game state to animation") }
        let interval = 1.0
        let sideViewAlpha: CGFloat = 0.3
        gameState = .animation
        UIElements.wordContainer?.container.isHidden = false
        UIElements.wordContainer?.label.alpha = 0
        UIElements.wordContainer?.label.text = gameParameters.wordList.randomElement()!
        
        //Toggle UI elemetns with animation
        UIView.animate(withDuration: 0.2) { [self] in
            UIElements.backGroundImage.alpha = 0.0
            UIElements.wordContainer?.label.alpha = 1.0
            UIElements.instructionLabel.alpha = 0.0
            UIElements.timeLabel.alpha = 0.0
            UIElements.pointLabel.alpha = 0.0
        }
        
        let redView = UIBuilder.generateColorViews(viewFrame: view.frame).red
        let greenView = UIBuilder.generateColorViews(viewFrame: view.frame).green
        view.addSubview(redView)
        view.addSubview(greenView)

        //Slide word container right
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            popPointAnimation(didScorePoint: true)
            UIView.animate(withDuration: interval, delay: 0, options: [.curveEaseOut]) { [self] in
                greenView.alpha = sideViewAlpha
                UIElements.wordContainer?.container.transform =
                    CGAffineTransform(translationX: view.frame.width / 2, y: 0)
                    .rotated(by: .pi / 8)
            }
        }
        
        //Slide word container left
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + interval) { [self] in
            popPointAnimation(didScorePoint: false)
            UIView.animate(withDuration: interval, delay: 0, options: [.curveEaseOut]) { [self] in
                greenView.alpha = 0.0
                redView.alpha = sideViewAlpha
                UIElements.wordContainer?.container.transform =
                    CGAffineTransform(translationX: view.frame.width / -2, y: 0)
                    .rotated(by: .pi / -8)
            }
        }
        
        //Center word container
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + interval * 2) { [self] in
            UIView.animate(withDuration: interval, delay: 0, options: [.curveEaseOut]) { [self] in
                redView.alpha = 0.0
                UIElements.wordContainer?.container.transform =
                    CGAffineTransform(translationX: 0, y: 0)
                    .rotated(by: 0)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 + interval * 3) {
            redView.removeFromSuperview()
            greenView.removeFromSuperview()
            self.displayCountdown()
        }
    }
    
    //Countdown
    private func displayCountdown() {
        if C.debugApp { print("displaying countdown") }
        UIElements.wordContainer!.container.isHidden = true
        UIElements.timeLabel.alpha = 1.0
        UIElements.timeLabel.isHidden = false
        UIElements.timeLabel.center = CGPoint(x: view.center.x, y: view.center.y)
        gameParameters.currentTime = 3
        UIElements.timeLabel.text = "\(gameParameters.currentTime)"
        animateTimeLabel()
        gameParameters.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            gameParameters.currentTime -= 1
            if gameParameters.currentTime < 1 {
                if gameState == .animation {
                    startGame()
                } else {
                    endgame()
                }
            }
            UIElements.timeLabel.text = "\(gameParameters.currentTime)"
            animateTimeLabel()
        }
    }
    
    //Animate fading point
    private func popPointAnimation(didScorePoint: Bool) {
        let pLabel = UILabel()
        pLabel.font = UIFont.systemFont(ofSize: 70.0)
        pLabel.alpha = 0.7
        pLabel.textAlignment = .center
        pLabel.textColor = didScorePoint ? .green : .red
        pLabel.text = didScorePoint ? "+1" : "X"
        if C.testUIWithColors { pLabel.backgroundColor = .cyan }
        let x = didScorePoint ? view.frame.width * 0.7 - 50 : view.frame.width * 0.3 - 65
        let y = view.frame.height * 0.4
        let size = 100.0
        pLabel.frame = CGRect(x: x, y: y, width: size, height: size)
        view.addSubview(pLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseOut]) {
            pLabel.transform = CGAffineTransform(translationX: 0, y: -100.0)
            pLabel.alpha = 0.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            pLabel.removeFromSuperview()
        }
    }
    
    //Animate time label (Mario Kart style!)
    private func animateTimeLabel() {
        UIElements.timeLabel.alpha = 0.0
        UIElements.timeLabel.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) { [self] in
            UIElements.timeLabel.alpha = 1.0
            UIElements.timeLabel.transform = .identity
        }
    }
    
    //Make word container appear from nothing - NOTE: Does not affect position!
    private func popWordContainer() {
        // Start tiny and invisible
        let label = UIElements.wordContainer!.container
        label.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        label.alpha = 0
        label.isHidden = false
        
        UIView.animate( withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [.curveEaseOut]
        ) {
            label.transform = .identity   // back to normal size
            label.alpha = 1               // fully visible
        }
    }
    
    //Typing animation for point view (In the end)
    private func performTypingAnimationForPointView() {
        UIElements.pointLabel.text = ""
        let text = "\(languageManager.localizedString(forKey: "POINTS")): \(gameParameters.points)"
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in self.UIElements.pointLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
//MARK: - During game
    
    private func startGame() {
        if C.debugApp { print("Staring game: setting game state to playing") }
        gameState = .playing
        gameParameters.currentTime = gameParameters.gameTime
        gameParameters.wordList.shuffle()
        
        //TOGGLE UI
        // Time label
        UIElements.timeLabel.center.y = UIElements.timeLabelOriginY
        
        //Point label
        UIElements.pointLabel.isHidden = false
        let pointsString = languageManager.localizedString(forKey: "POINTS")
        UIElements.pointLabel.text = "\(pointsString): \(gameParameters.points)"
        
        //Word container
        UIElements.wordContainer!.container.alpha = 1.0
        UIElements.wordContainer?.container.isHidden = false
        UIElements.wordContainer?.label.text = gameParameters.wordList[gameParameters.currentWord]
        popWordContainer()
        
        //Add pan gesture for word container
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleWordPan(_:)))
        UIElements.wordContainer!.container.isUserInteractionEnabled = true
        UIElements.wordContainer!.container.addGestureRecognizer(pan)
        
        //Fade in point label
        UIView.animate(withDuration: 0.5) {
            self.UIElements.pointLabel.alpha = 1.0
        }
        
    }
    
    private func newWord(didScorePoint: Bool) {
        //Move to next word
        
        if gameParameters.currentWord < gameParameters.wordList.count { gameParameters.currentWord += 1 }
        
        
        //Add point and pop animation
        if didScorePoint { gameParameters.points += 1 }
        popPointAnimation(didScorePoint: didScorePoint)
        
        //Update point label
        UIElements.pointLabel.text = "\(languageManager.localizedString(forKey: "POINTS")): \(gameParameters.points)"
        UIElements.wordContainer?.label.text = gameParameters.wordList[gameParameters.currentWord]
        
        //Perform animation
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { [self] in
            if didScorePoint {
                UIElements.wordContainer!.container.transform = CGAffineTransform(translationX: view.frame.width, y: 0).rotated(by: .pi / 4)
            } else {
                UIElements.wordContainer!.container.transform = CGAffineTransform(translationX: -view.frame.width, y: 0).rotated(by: .pi / -4)
            }
        }, completion: { finished in
            self.view.isUserInteractionEnabled = true
            self.UIElements.wordContainer!.container.transform = .identity
            self.popWordContainer()
        })
    }
    
//MARK: - End game
    
    private func endgame() {
        if C.debugApp { print("Ending game: setting game state to game over") }
        gameState = .gameOver
        gameParameters.timer?.invalidate()
        gameParameters.timer = nil
        
        //Center point label
        UIElements.pointLabel.center.y = view.center.y
        performTypingAnimationForPointView()
        
        //remove others from view
        UIElements.wordContainer?.container.removeFromSuperview()
        UIElements.timeLabel.removeFromSuperview()
    }
    
}

extension WordView {
    
    private func setGameParameters() {
        let gameTime = 60
        var words: [String] {
            if languageManager.getSelectedLanguage() == "fi" {
                return WordGame.words
            } else {
                return WordGame.wordsEN
            }
        }
        
        gameParameters = WordGameParameters(gameTime: gameTime, currentTime: 0, wordList: words, timer: nil, points: 0, currentWord: 0)
    }
    
    private func generateUI() {
        view.backgroundColor = UIColor(named: "explainMode")
        
        //Background image
        let bgImage = UIBuilder.generateBackGroundImage(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(bgImage)
        
        //Instruction label
        let iLabel = UIBuilder.generateInstructionLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(iLabel)
        
        //Word label
        let wLabel = UIBuilder.generateWordLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(wLabel.container)
        
        //Time label
        let tLabel = UIBuilder.generateTimeLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(tLabel)
        
        //Point label
        let pLabel = UIBuilder.generatePointLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(pLabel)
        
        // ➕ Add tap recognizer to the whole view
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(mainTap)
        
        UIElements = WordVCUIElements(backGroundImage: bgImage, instructionLabel: iLabel, wordContainer: wLabel, timeLabel: tLabel, pointLabel: pLabel, timeLabelOriginY: tLabel.center.y)
        
        hasSetUI = true
        
    }
    
}
