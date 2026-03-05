//
//  GameScreen.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 26.6.2024.
//

import UIKit

class GameView: UIViewController {
    
    var hasSetUI = false
    var pointUIisVisible = false
    var timer: Timer?
    
    let languageManager = LanguageManager()
    let gameFunctionality = GameFunctionality()
    let converter = TaskStringConverter()
    let UIBuilder = GameVCUI()
    
    var gameConfiguration: GameConfiguration!
    var UIElements: GameVCUIElements!
    var gameParameters: GameParameters?
    
    enum GamePhase {
        case preparing
        case pointInstructions
        case playing
        case ended
    }
    
    var phase: GamePhase = .preparing
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetUI {
            if C.debugApp { printGameDetails() }
            setUIElements()
            initializeGame()
            hasSetUI = true
        }
    }
    
//MARK: - Yes No & Screen tap
    
    @objc func handleYesTap() {
        if phase == .ended {
            navigationController?.popViewController(animated: true)
        } else if phase == .playing {
            scorePoint()
            newTask()
            popAnimation(for: UIElements.yesView!.container)
        }
    }
    
    @objc func handleNoTap() {
        if phase == .ended {
            navigationController?.popViewController(animated: true)
        } else if phase == .playing {
            newTask()
            popAnimation(for: UIElements.noView!.container)
            popCrossAnimation()
        }
    }
    
    @objc func handleScreenTap() {
        if phase == .ended {
            timer?.invalidate()
            timer = nil
            navigationController?.popViewController(animated: true)
        } else if phase == .playing {
            if pointUIisVisible {
                if C.debugApp { print("Point UI is visible, use buttons to proceed") }
                return
            } else {
                newTask()
            }
        } else if phase == .pointInstructions {
            beginGame()
        }
    }
    
//MARK: - Beginning
    
    private func initializeGame() {
        setGameParameters(category: gameConfiguration.gameCategory)
        UIElements.instructionView.isHidden = true
        if gameConfiguration.countPoints {
            phase = .pointInstructions
            animatePointInstructions()
        } else {
            phase = .playing
            beginGame()
        }
    }
    
    private func setGameParameters(category: Int) {
        
        //Game parameters are:
        //currentTask: Int, numberOfTasks: Int, playerData: [PlayerData]
        //p1indexes: [Int], p2indexes: [Int], tasksTemplates: [Task]
        
        if C.debugApp { print("--GENERATING GAME PARAMETERS--") }
        
        let players = gameConfiguration.players
        let language = languageManager.getSelectedLanguage()
        let hasPlusSub = IAPManager.shared.isSubscriptionActive()
        let gameCategory = gameConfiguration.gameCategory
        
        //Generate number of tasks based on shorter round status
        var numberOfTasks: Int {
            if gameConfiguration.shorterRound { return 15 } else { return 30 }
        }
        
        
        //Generate tiers based on slider value (Only for extreme mode)
        let tiers = gameFunctionality.generateTierIndexes(sliderValue: gameConfiguration.intensityValue, numberOfTasks: numberOfTasks)
        if C.debugApp { print("Tiers for game: \(tiers)") }
        
        //Generate player data
        let playerData = gameFunctionality.generatePlayerData(players: players)
        
        //Generate player indexes
        var p1indexes: [Int] = []
        var p2indexes: [Int] = []
        
        if gameCategory == 1 {
            let playerIndexes = gameFunctionality.generatePlayerIndexesForDatemode(players: players, numberOfTasks: numberOfTasks)
            p1indexes = playerIndexes.p1
            p2indexes = playerIndexes.p2
        } else {
            let playerIndexes = gameFunctionality.generatePlayerIndexes(players: players, numberOfTasks: numberOfTasks)
            p1indexes = playerIndexes.p1
            p2indexes = playerIndexes.p2
        }
        
        //Generate task templates
        var tasktemplates: [Task] {
            switch gameCategory {
            case 0:
                return gameFunctionality.generateTaskTemplatesForBasicGame(numberOfTasks: numberOfTasks, language: language, hasPlusSub: hasPlusSub)
            case 1:
                return gameFunctionality.generateTaskTemplatesForDatemode(numberOfTasks: numberOfTasks, language: language)
            case 2:
                return gameFunctionality.generateTaskTemplatesForBasicGame(numberOfTasks: numberOfTasks, language: language, hasPlusSub: hasPlusSub)
            case 3:
                return gameFunctionality.generateTaskTemplatesForExtremeMode(numberOfTasks: numberOfTasks, language: language, tiers: tiers)
            default:
                return gameFunctionality.generateTaskTemplatesForBasicGame(numberOfTasks: numberOfTasks, language: language, hasPlusSub: hasPlusSub)
            }
        }
        
        gameParameters = GameParameters(currentTask: 0, numberOfTasks: numberOfTasks, playerData: playerData, p1indexes: p1indexes, p2indexes: p2indexes, tasksTemplates: tasktemplates)
        
       // if C.useDebugTasks { gameParameters?.tasksTemplates = gameFunctionality.generateDebugTaskTemplates()
           // print("Using debug tasks")
     //   }
        
        if C.debugApp { checkGameParameters() }
        
    }
    
    private func beginGame() {
        UIElements.instructionView.isHidden = true
        timer?.invalidate()
        timer = nil
        UIView.animate(withDuration: 0.3) {
            self.UIElements.backGroundImage.alpha = 1.0
        }
        phase = .playing
        let category = gameConfiguration.gameCategory
        if category == 1 {
            if C.debugApp { print("Date mode: showing instructions before starting the game") }
            displayDatemodeInstructions()
            togglePointUI(showPointUI: false)
        } else {
            newTask()
        }
    }
    
    private func displayDatemodeInstructions() {
        
        let language = languageManager.getSelectedLanguage()
        let startingPlayer = gameParameters!.playerData.last!
        var template: String {
            if language == "fi" {
                return DateTasksFI().instuctions(startingPlayer: startingPlayer.name)
            } else {
                return DateTasksEN().instuctions(startingPlayer: startingPlayer.name)
            }
        }
        
        UIElements.yesView?.container.isHidden = true
        UIElements.noView?.container.isHidden = true
        
        let attributedString = converter.attributedText(for: template, highlight1: startingPlayer.name, highlight2: "XXXXXXX", color1: startingPlayer.color, color2: .red)
        
        
        UIElements.taskLabel.attributedText = attributedString
        performShakingAnimation()
        
    }
    
//MARK: During game
    
    private func newTask() {
        
        let currentTaskIndex = gameParameters!.currentTask
        //End game if tasks have ended
        if currentTaskIndex >= gameParameters!.numberOfTasks {
            if C.debugApp { print("No more tasks, ending game") }
            endGame()
            return
        }
        
        timer?.invalidate()
        timer = nil
        
        if C.debugApp { showCurrentTaskDetails() }
        
        updateTasklabel()
        updatePointUI()
        
        performShakingAnimation()
        
        //Move to next task index
        gameParameters!.currentTask += 1
    }
    
    private func updateTasklabel() {
        let currentTaskIndex = gameParameters!.currentTask
        let currentTemplate = gameParameters!.tasksTemplates[currentTaskIndex]
        let p1index = gameParameters!.p1indexes[currentTaskIndex]
        let player1 = gameParameters!.playerData[p1index]
        let p2index = gameParameters!.p2indexes[currentTaskIndex]
        let player2 = gameParameters!.playerData[p2index]
        
        //Adjust penalties if playing extreme mode
        var penaltyValue = currentTemplate.baselinePenalty
        if gameConfiguration.gameCategory == 3 {
            penaltyValue = gameFunctionality.generatePenaltyValue(baseline: penaltyValue, penaltySliderValue: gameConfiguration.penaltyValue)
            if C.debugApp { print("Changing penalty value from \(currentTemplate.baselinePenalty) to \(penaltyValue)") }
        }
        
        //Convert and display task string
        let taskString = converter.renderTemplate(currentTemplate.template, values: [
            "player1" : player1.name,
            "player2" : player2.name,
            "penalties" : String(penaltyValue)
        ])
        
        let attributedString = converter.attributedText(for: taskString, highlight1: player1.name, highlight2: player2.name, color1: player1.color, color2: player2.color)
        
        UIElements.taskLabel.attributedText = attributedString
    }
    
    private func updatePointUI() {
        
        let currentTaskIndex = gameParameters!.currentTask
        let currentTemplate = gameParameters!.tasksTemplates[currentTaskIndex]
        
        
        let pointsToScore = currentTemplate.pointsToScore
        
        //Toggle point UI visibility based on current task
        if gameConfiguration.countPoints && pointsToScore > 0 {
            UIElements.yesView?.container.isHidden = false
            UIElements.noView?.container.isHidden = false
            togglePointUI(showPointUI: true)
            UIElements.yesView!.label.text = "+\(pointsToScore)"
            UIElements.noView!.label.text = "0"
        } else {
            togglePointUI(showPointUI: false)
        }
    }
    
    private func scorePoint() {
        let currentTaskIndex = gameParameters!.currentTask - 1
        let pointsToScore = gameParameters!.tasksTemplates[currentTaskIndex].pointsToScore
        let scoringPlayerIndex = gameParameters!.p1indexes[currentTaskIndex]
        gameParameters!.playerData[scoringPlayerIndex].points += pointsToScore
        popPlusAnimation(points: pointsToScore)
        
        if C.debugApp {
            print("Scoring \(pointsToScore) to player \(gameParameters!.playerData[scoringPlayerIndex].name)")
            printScoreboard()
        }
    }
    
    private func togglePointUI(showPointUI: Bool) {
        
        var alphaValue: CGFloat { if showPointUI { return 1 } else { return 0.3 } }
        
        if C.debugApp { print("Showing Point UI: \(showPointUI)") }
        
        UIView.animate(withDuration: 0.1) { [self] in
            UIElements.yesView?.container.alpha = alphaValue
            UIElements.noView?.container.alpha = alphaValue
            UIElements.yesView?.container.isUserInteractionEnabled = showPointUI
            UIElements.noView?.container.isUserInteractionEnabled = showPointUI
        }
        
        pointUIisVisible = showPointUI
        
    }
    
    private func performShakingAnimation() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        UIElements.taskLabel.layer.add(shakeAnimation, forKey: "shake")
    }
    
//MARK: End game
    
    private func endGame() {
        phase = .ended
        if gameConfiguration.countPoints {
            if C.debugApp { print("Counting points, displaying scoreboard") }
            displayScoreboard()
        } else {
            UIElements.taskLabel.text = languageManager.localizedString(forKey: "GAME_OVER")
            performShakingAnimation()
        }
    }
    
    private func displayScoreboard() {
        UIElements.backGroundImage.isHidden = true
        UIElements.taskLabel.isHidden = true
        UIElements.yesView!.container.isHidden = true
        UIElements.noView!.container.isHidden = true
      
        
        let sortedPlayers = gameParameters!.playerData.sorted { $0.points > $1.points }
        let labelWidth: CGFloat = view.frame.width - 30.0
        var yPosition: CGFloat = view.safeAreaInsets.top + 150.0
        let trophyArray = ["🥇","🥈","🥉"]
        
        let label = UILabel()
        label.font = UIFont(name: "Optima-Bold", size: 30)
        label.font = UIFont(name: C.wordGameFont, size: 40)
        label.textAlignment = .center
        label.shadowColor = UIColor.black
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.textColor = .white
        view.addSubview(label)
        label.frame = CGRect(x: 15.0, y: yPosition, width: labelWidth, height: 50)
        yPosition += 80.0
        
        label.text = ""
        let text = languageManager.localizedString(forKey: "SCOREBOAD_HEADER")
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in label.text?.append(letter)
            }
            charIndex += 1
        }
        
        var labelsToInsert: [UILabel] = []
        
        for i in 0...2 {
            if i >= sortedPlayers.count { break }
            let label = UILabel()
            label.font = UIFont(name: "Optima-Bold", size: 30)
            label.textAlignment = .center
            label.textColor = .white
            label.shadowColor = UIColor.black
            label.shadowOffset = CGSize(width: 2, height: 2)
            label.alpha = 0.0
            view.addSubview(label)
            label.frame = CGRect(x: 15.0, y: yPosition, width: labelWidth, height: 50)
            label.text = "\(trophyArray[i]) \(sortedPlayers[i].name): (\(sortedPlayers[i].points))"
            labelsToInsert.append(label)
            yPosition += 50.0
        }
        
        timer?.invalidate()
        timer = nil
        
        var indexForNextLabel: Int = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [self] timer in
            if C.debugApp { print("Timer fired!") }
            if indexForNextLabel >= labelsToInsert.count {
                timer.invalidate()
            } else {
                let labelToAnimate = labelsToInsert[indexForNextLabel]
                labelToAnimate.alpha = 0.0
                labelToAnimate.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) { [self] in
                    labelToAnimate.alpha = 1.0
                    labelToAnimate.transform = .identity
                }
            }
            indexForNextLabel += 1
        }
 /*
        for i in 0..<4 {
            //print("Running scoreboard loop")
            let label = UILabel()
            label.font = UIFont(name: "Optima-Bold", size: 30)
            label.textAlignment = .center
            label.textColor = .white
            label.frame = CGRect(x: 15.0, y: yPosition, width: labelWidth, height: 50)
            yPosition += 80.0
            
            if i == 0 {
                label.font = UIFont(name: C.wordGameFont, size: 40)
                view.addSubview(label)
                label.text = ""
                let text = languageManager.localizedString(forKey: "SCOREBOAD_HEADER")
                var charIndex = 0.0
                for letter in text {
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in label.text?.append(letter)
                    }
                    charIndex += 1
                }
            } else {
                if i > sortedPlayers.count {
                    break
                } else {
                    view.addSubview(label)
                    label.text = ""
                    let text = "\(trophyArray[i - 1]) \(sortedPlayers[i - 1].name) (\(sortedPlayers[i - 1].points))"
                    var charIndex = 0.0
                    for letter in text {
                        Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in label.text?.append(letter)
                        }
                        charIndex += 1
                    }
                }
            }
        }
  */
    }
    
//MARK: Animations
    
    private func animatePointInstructions() {
        UIElements.instructionView.isHidden = false
        UIElements.instructionView.alpha = 0.0
        UIView.animate(withDuration: 0.3) { [self] in
            UIElements.instructionView.alpha = 1.0
            UIElements.backGroundImage.alpha = 0.3
        }
        
        var count = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            count += 1
            if count == 1 {
                popAnimation(for: UIElements.yesView!.container)
                popPlusAnimation(points: 0)
            }
            if count == 2 {
                popAnimation(for: UIElements.noView!.container)
                popCrossAnimation()
            }
            print(count)
            if count == 5 {
                count = 0
            }
        }
        
    }
    
    private func popAnimation(for element: UIView) {
        let scale = 1.1
        let interval = 0.1
        UIView.animate(withDuration: interval) {
            element.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            UIView.animate(withDuration: interval) {
                element.transform = .identity
            }
        }
    }
    
    private func popPlusAnimation(points: Int) {
        let interval = 1.0
        let label = UILabel()
        label.text = "+"
        if points > 0 { label.text = String(points) }
        label.font = UIFont.boldSystemFont(ofSize: 150)
        label.textAlignment = .center
        label.textColor = .green
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        // Position above yes button
        label.center = CGPoint(
            x: UIElements.yesView!.container.center.x,
            y: UIElements.yesView!.container.center.y - 120
        )
        
        view.addSubview(label)

        // Start slightly bigger
        label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        UIView.animate(withDuration: interval, delay: 0, options: [.curveEaseOut]) {
            // Move upward & shrink
            label.transform = CGAffineTransform(translationX: 0, y: -100)
                .scaledBy(x: 0.1, y: 0.1)
            label.alpha = 0.0
        } completion: { _ in
            label.removeFromSuperview()
        }
    }

    
    private func popCrossAnimation() {
        let interval = 1.0
        let label = UILabel()
        label.text = "X"
        label.font = UIFont.boldSystemFont(ofSize: 150)
        label.textAlignment = .center
        label.textColor = .red
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        // Position above no button
        label.center = CGPoint(
            x: UIElements.noView!.container.center.x,
            y: UIElements.noView!.container.center.y - 120
        )

        view.addSubview(label)

        // Start slightly bigger
        label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        UIView.animate(withDuration: interval, delay: 0, options: [.curveEaseOut]) {
            label.transform = CGAffineTransform(translationX: 0, y: -100)
                .scaledBy(x: 0.1, y: 0.1)
            label.alpha = 0.0
        } completion: { _ in
            label.removeFromSuperview()
        }
    }

    
}



//MARK: - UI Elements

extension GameView {
    
    private func setUIElements() {
        
        if gameConfiguration.gameCategory == 1 {
            view.backgroundColor = UIColor(named: "dateMode")
            gameConfiguration.countPoints = false
        } else if gameConfiguration.gameCategory == 2 {
            
        } else if gameConfiguration.gameCategory == 4 {
            view.backgroundColor = .blue
        }
        
        //Background image
        let bgImage = UIBuilder.generateBackGroundImage(viewFrame: view.frame, safeArea: view.safeAreaInsets, countPoints: gameConfiguration.countPoints)
        view.addSubview(bgImage)
        
        //Task label
        let tLabel = UIBuilder.generateTaskLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(tLabel)
        
        //yesView
        let yView = UIBuilder.generateYesButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(yView.container)
        
        // ➕ Add tap recognizer
        let yesTap = UITapGestureRecognizer(target: self, action: #selector(handleYesTap))
        yView.container.isUserInteractionEnabled = true
        yView.container.addGestureRecognizer(yesTap)
        
        
        //noView
        let nView = UIBuilder.generateNoButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(nView.container)
        
        //InstructionView
        let iView = UIBuilder.generatePointInstructionView(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(iView)
        
        // ➕ Add tap recognizer
        let noTap = UITapGestureRecognizer(target: self, action: #selector(handleNoTap))
        nView.container.isUserInteractionEnabled = true
        nView.container.addGestureRecognizer(noTap)
        
        // ➕ Add tap recognizer to the whole view
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(mainTap)
        
        UIElements = GameVCUIElements(backGroundImage: bgImage, taskLabel: tLabel, yesView: yView, noView: nView, instructionView: iView)
        
        if gameConfiguration.countPoints {
            UIElements.taskLabel.transform = CGAffineTransform(translationX: 0, y: -90)
        } else {
            UIElements.yesView!.container.isHidden = true
            UIElements.noView!.container.isHidden = true
        }
        
    }
    
}

//MARK: - Only for debugging below this point

extension GameView {
    
    private func printGameDetails() {
        var gameName: String {
            switch gameConfiguration.gameCategory {
            case 0: return "Basic game"
            case 1: return "Date mode"
            case 2: return "Team mode"
            case 3: return "Extreme mode"
            case 4: return "Explain mode"
            default: return "Invalid category"
            }
        }
        print("-- GAME DETAILS: --")
        print("Selected gamemode is: \(gameName)")
        print("Intensity meter in position: \(gameConfiguration.intensityValue)")
        print("Penalty meter in position: \(gameConfiguration.penaltyValue)")
        print("Counting points: \(gameConfiguration.countPoints)")
        print("Having shorter game: \(gameConfiguration.shorterRound)")
    }
    
    private func checkGameParameters() {
        
        guard gameParameters != nil else {
            print("Cannot check player data, as it is nil")
            return
        }
        
        let numberOfTasks = gameParameters!.numberOfTasks
        print("Number of tasks for the game is: \(numberOfTasks)")
        let playerData = gameParameters!.playerData
        print("Player data has: \(playerData.count) players")
        let p1indexes = gameParameters!.p1indexes
        print("P1 indexes: \(p1indexes). Total: \(p1indexes.count). Max: \(p1indexes.max()!)")
        let p2indexes = gameParameters!.p2indexes
        print("P2 indexes: \(p2indexes). Total: \(p2indexes.count). Max: \(p2indexes.max()!)")
        let taskTemplates = gameParameters!.tasksTemplates
        print("Number of tasks templates: \(taskTemplates.count)")
        
        var hasDuplicates: Bool = false
        
        for i in 0..<p1indexes.count {
            if p1indexes[i] == p2indexes[i] {
                print("WARNING: P1 and P2 have the same task index at index: \(i)")
                hasDuplicates = true
            }
        }
        
        if !hasDuplicates { print("No duplicate task indexes in gameParameters") }
        
        let maxp1index: Int = p1indexes.max() ?? 0
        let maxp2index: Int = p2indexes.max() ?? 0
        
        if maxp1index > playerData.count || maxp2index > playerData.count {
            print("WARNING: One or both of the max task indexes is higher than the number of players, Application will crash!")
        } else {
            print("All player indexes inside are within range")
        }
        
        
        
    }
    
    private func showCurrentTaskDetails() {
        
        guard gameParameters != nil else {
            print("Cannot check task data, as it is nil")
            return
        }
        
        print("Showing task on index: \(gameParameters!.currentTask)")
        let playerData = gameParameters!.playerData
        let currentTaskIndex = gameParameters!.currentTask
        let currentP1index = gameParameters!.p1indexes[currentTaskIndex]
        let currentP2index = gameParameters!.p2indexes[currentTaskIndex]
        
        print("Players: P1: \(playerData[currentP1index].name), P2 \(playerData[currentP2index].name)")
        print("Points to score: \(gameParameters!.tasksTemplates[currentTaskIndex].pointsToScore)")
        print("Baseline penalty: \(gameParameters!.tasksTemplates[currentTaskIndex].baselinePenalty)")
    }
    
    private func printScoreboard() {
        print("--SCOREBOARD--")
        for i in 0..<gameParameters!.playerData.count {
            print("\(gameParameters!.playerData[i].name) has \(gameParameters!.playerData[i].points) points")
        }
    }
    
}
