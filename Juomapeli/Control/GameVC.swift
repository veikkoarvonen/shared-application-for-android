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
            if gameConfiguration.shorterRound { return 10 } else { return 30 }
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
/*

class GameView: UIViewController {
    
    var hasSetUI = false
    let languageManager = LanguageManager()
    let gameParameters = GameParameters()
    let converter = TaskStringConverter()
    var shouldUsePointButtons = false
    var shouldMoveToPointView = false
    
    //MARK: - Game parameters from previous VC
    
    var players: [String] = []
    var gameCategory: Int = 0
    var tierValue: Float = 3.0
    var drinkValue: Float = 1.0
    var countPoints: Bool = false
    var shorterGame: Bool = false
    var shouldReturn: Bool = false
    
    //MARK: - UIElements
    
    let UIElements = GameVCUI()
    var backGroundImage = UIImageView()
    var taskLabel = UILabel()
    var yesView = UIImageView()
    var noView = UIImageView()
    var pointLabel = UILabel()
    var timeLabel = UILabel()
    var wordLabelView: WordLabelComponents?
    
    //MARK: - Game parameters determined in this VC
    
    var currentTask: Int = 0
    var numberOfTasks: Int = 30
    var playerData: [PlayerData] = []
    var p1indexes: [Int] = []
    var p2indexes: [Int] = []
    var tasksTemplates: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if C.debugApp { printGameDetails() }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetUI {
            setUIElements()
            initializeGame()
            hasSetUI = true
        }
    }
    
    
    //MARK: - Objc functions
    
    @objc func handleYesTap() {
        //Return if game hass ended
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else if gameCategory == 2 {
            
        } else {
            scorePoint()
            newTask()
            shouldUsePointButtons = false
            togglePointButtonVisibility(hidden: true)
        }
    }
    
    @objc func handleNoTap() {
        //Return if game hass ended
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else if gameCategory == 2 {
            
        } else {
            newTask()
            shouldUsePointButtons = false
            togglePointButtonVisibility(hidden: true)
        }
    }
    
    @objc func handleScreenTap() {
        //Return if game hass ended
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else {
            //Check if should use point buttons to proceed
            if shouldUsePointButtons {
                if C.debugApp { print("Should use point buttons") }
                return
            }
            
            //Explain mode
            if gameCategory == 4 && !wordGameIsActive {
                displayCountDownTimer()
            //Team mode
            } else if gameCategory == 2 {
            
            //Basic & Date & Extreme
            } else {
                if shouldMoveToPointView {
                    displayPointScoringQuestion()
                    shouldMoveToPointView = false
                } else {
                    newTask()
                }
            }
        }
    }
    
    
    
//MARK: - Universal funtionality
    
    private func initializeGame() {
        
        if shorterGame { numberOfTasks = 8 }
        
        playerData = gameParameters.generatePlayerData(players: players)
        
        if gameCategory == 0 {
            initializeBasicgame()
        } else if gameCategory == 1 {
            initializeDatemode()
        } else if gameCategory == 2 {
            initializeTeammode()
        } else if gameCategory == 3 {
            initializeExtrememode()
        } else if gameCategory == 4 {
            initializeExplainmode()
        } else {
            print("Invalid game category")
            //navigationController?.popViewController(animated: true)
        }
    }
    
//MARK: - New task
    
    private func newTask() {
        
        //Check if gamemode is explain
        if gameCategory == 4 { return }
        
        //End game if task index is out of range
        if currentTask >= numberOfTasks {
            endGame()
            return
        }
        
        if C.debugApp { showCurrentTaskDetails() }
        
        //Display point label if counting points and task has scorable points
        let pointsToScore = tasksTemplates[currentTask].pointsToScore
        if countPoints && pointsToScore != 0 {
            pointLabel.text = "\(languageManager.localizedString(forKey: "POINTLABEL_TEXT")) \(pointsToScore)"
            pointLabel.isHidden = false
            shouldMoveToPointView = true
        } else {
            pointLabel.isHidden = true
        }
            
        updateTaskLabelText()
        performShakingAnimation()
        
        currentTask += 1
        
    }
    
    private func updateTaskLabelText() {
        //Generate task string
        let currentTaskStucture = tasksTemplates[currentTask]
        let template = currentTaskStucture.template
        let p1index = p1indexes[currentTask]
        let p2index = p2indexes[currentTask]
        let player1 = playerData[p1index]
        let player2 = playerData[p2index]
        var penalties = currentTaskStucture.baselinePenalty
        if gameCategory == 4 { penalties = gameParameters.generatePenaltyValue(baseline: penalties, penaltySliderValue: drinkValue) }
        let taskString = converter.renderTemplate(template, values: [
            "player1" : player1.name,
            "player2" : player2.name,
            "penalties" : String(penalties)
        ])
        let attributedText = converter.attributedText(for: taskString, highlight1: player1.name, highlight2: player2.name, color1: player1.color, color2: player2.color)
        taskLabel.attributedText = attributedText
    }
    
    private func displayPointScoringQuestion() {
        shouldUsePointButtons = true
        togglePointButtonVisibility(hidden: false)
        let p1index = p1indexes[currentTask - 1]
        let player1 = playerData[p1index]
        let converter = TaskStringConverter()
        let template = converter.renderPointScoringTemplate(player: player1.name, language: languageManager.getSelectedLanguage())
        let attributedString = converter.attributedText(for: template, highlight1: player1.name, highlight2: "", color1: player1.color, color2: .red)
        taskLabel.attributedText = attributedString
        performShakingAnimation()
    }
    
    private func scorePoint() {
        let pointsToScore = tasksTemplates[currentTask - 1].pointsToScore
        let playerWhoScoredIndex = p1indexes[currentTask - 1]
        playerData[playerWhoScoredIndex].points += pointsToScore
        
        if C.debugApp { print("\(playerData[playerWhoScoredIndex].name) scored \(pointsToScore) points") }
        
    }
    
//MARK: - UI Visibility
    
    private func togglePointUIVisibility(hidden: Bool) {
        pointLabel.isHidden = hidden
        yesView.isHidden = hidden
        noView.isHidden = hidden
        yesView.isUserInteractionEnabled = !hidden
        noView.isUserInteractionEnabled = !hidden
    }
    
    private func toggleWordLabelViewVisibility(hidden: Bool) {
        wordLabelView?.container.isHidden = hidden
        wordLabelView?.label.isHidden = hidden
    }
    
    private func togglePointButtonVisibility(hidden: Bool) {
        yesView.isHidden = hidden
        noView.isHidden = hidden
        yesView.isUserInteractionEnabled = !hidden
        noView.isUserInteractionEnabled = !hidden
    }
    
    
    private func performShakingAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        taskLabel.layer.add(shakeAnimation, forKey: "shake")
    }
    
    private func endGame() {
        if countPoints {
            displayScoreboard()
        } else {
            taskLabel.text = languageManager.localizedString(forKey: "GAME_OVER")
            performShakingAnimation()
            shouldReturn = true
        }
    }
    
//MARK: - Scoreboard
    
    private func displayScoreboard() {
        backGroundImage.isHidden = true
        taskLabel.isHidden = true
        yesView.isHidden = true
        noView.isHidden = true
        pointLabel.isHidden = true
        timeLabel.isHidden = true
        toggleWordLabelViewVisibility(hidden: true)
        
        let sortedPlayers = playerData.sorted { $0.points > $1.points }
        let labelWidth: CGFloat = view.frame.width - 30.0
        var yPosition: CGFloat = view.safeAreaInsets.top + 150.0
        let trophyArray = ["🥇","🥈","🥉"]
        
        for i in 0..<4 {
            //print("Running scoreboard loop")
            let label = UILabel()
            label.font = UIFont(name: C.wordGameFont, size: 30)
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
        shouldReturn = true
        
    }
    
    //MARK: - Basic game funtionality
    
    private func initializeBasicgame() {
        timeLabel.isHidden = true
        togglePointUIVisibility(hidden: true)
        toggleWordLabelViewVisibility(hidden: true)
        let language = languageManager.getSelectedLanguage()
        //let hasPlusSubscription = IAPManager.shared.isSubscriptionActive()
        let hasPlusSubscription = false
        let playerIndexes = gameParameters.generatePlayerIndexes(players: players, numberOfTasks: numberOfTasks)
        p1indexes = playerIndexes.p1
        p2indexes = playerIndexes.p2
        tasksTemplates = gameParameters.generateTaskTemplatesForBasicGame(numberOfTasks: numberOfTasks, language: language, hasPlusSub: hasPlusSubscription)
        if C.debugApp { runIndexSafetyCheck() }
        newTask()
        adjustPointLabel()
    }
    
    //MARK: - Date mode funtionality
    
    private func initializeDatemode() {
        timeLabel.isHidden = true
        toggleWordLabelViewVisibility(hidden: true)
        view.backgroundColor = UIColor(named: C.dateColor)
        let language = languageManager.getSelectedLanguage()
        p1indexes = gameParameters.generatePlayerIndexesForDatemode(players: players, numberOfTasks: numberOfTasks).p1
        p2indexes = gameParameters.generatePlayerIndexesForDatemode(players: players, numberOfTasks: numberOfTasks).p2
        tasksTemplates = gameParameters.generateTaskTemplatesForDatemode(numberOfTasks: numberOfTasks, language: language)
        checkPlayerIndexes()
        runIndexSafetyCheck()
        displayDatemodeInstructions()
        adjustPointLabel()
    }
    
    private func displayDatemodeInstructions() {
        let language = languageManager.getSelectedLanguage()
        let startingPlayer = players.last!
        var instructions: String = ""
        if language == "fi" { instructions = DateTasksFI().instuctions(startingPlayer: startingPlayer) }
        else
        { instructions = DateTasksEN().instuctions(startingPlayer: startingPlayer)}
        
        let p1 = playerData[p1indexes[currentTask]]
        let p2 = playerData[p2indexes[currentTask]]
        
        let attributedString = converter.attributedText(for: instructions, highlight1: p1.name, highlight2: p2.name, color1: p1.color, color2: p2.color)
        
        togglePointUIVisibility(hidden: true)
        
        taskLabel.attributedText = attributedString
    }
    
    //MARK: - Team mode funtionality
    
    private func initializeTeammode() {
        timeLabel.isHidden = true
        toggleWordLabelViewVisibility(hidden: true)
        view.backgroundColor = UIColor(named: C.teamColor)
    }
    
    //MARK: - Extreme mode funtionality
    
    private func initializeExtrememode() {
        toggleWordLabelViewVisibility(hidden: true)
        togglePointUIVisibility(hidden: true)
        timeLabel.isHidden = true
        let language = languageManager.getSelectedLanguage()
        let playerIndexes = gameParameters.generatePlayerIndexes(players: players, numberOfTasks: numberOfTasks)
        p1indexes = playerIndexes.p1
        p2indexes = playerIndexes.p2
        let tiers = gameParameters.generateTierIndexes(sliderValue: tierValue, numberOfTasks: numberOfTasks)
        tasksTemplates = gameParameters.generateTaskTemplatesForExtremeMode(numberOfTasks: numberOfTasks, language: language, tiers: tiers)
        adjustPointLabel()
        newTask()
    }
    
    //MARK: - Explain mode funtionality
    
    var wordGameIsActive = false
    var wordGamePoints = 0
    var wordGameTime = 10
    var words: [String] = []
    var currentWord = 0
    var timer: Timer?
    
    private func initializeExplainmode() {
        yesView.isHidden = true
        noView.isHidden = true
        timeLabel.isHidden = true
        toggleWordLabelViewVisibility(hidden: true)
        view.backgroundColor = UIColor(named: C.explainColor)
        taskLabel.text = languageManager.localizedString(forKey: "WORDGAME_INSTRUCTIONS")
        if languageManager.getSelectedLanguage() == "fi" {
            words = WordsFI.words
        } else {
            words = WordsEN.words
        }
        words.shuffle()
    }
    
    private func newWord(didScorePoint: Bool) {
        currentWord += 1
    }
    
    private func displayCountDownTimer() {
        wordGameIsActive = true
        timeLabel.isHidden = false
        taskLabel.isHidden = true
        centerTimeLabel()
        view.isUserInteractionEnabled = false
        backGroundImage.isHidden = true
        
        var count = 3
        animateCountdownNumber("\(count)", for: timeLabel)

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            count -= 1

            if count == 0 {
                timer.invalidate()
                self.beginWordgameTime()
            } else if count > 0 {
                self.animateCountdownNumber("\(count)", for: self.timeLabel)
            } else {
                timer.invalidate()
                self.beginWordgameTime()
            }
        }
    }
    
    private func beginWordgameTime() {
        resetTimeLabelPosition()
        pointLabel.isHidden = false
        pointLabel.text = "\(languageManager.localizedString(forKey: "POINTS")): \(wordGamePoints)"
        toggleWordLabelViewVisibility(hidden: false)
        wordLabelView?.label.text = words[currentWord]
        animateCountdownNumber("\(wordGameTime)", for: timeLabel)
        view.isUserInteractionEnabled = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.wordGameTime -= 1
            self.animateCountdownNumber("\(self.wordGameTime)", for: self.timeLabel)
            
            if self.wordGameTime <= 0 {
                timer.invalidate()
                self.timeLabel.text = "MOE"
            }
        }
    }

    private func animateCountdownNumber(_ text: String, for label: UILabel) {
        label.text = text
        label.alpha = 0.0
        label.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: [.curveEaseOut]) {
            label.alpha = 1.0
            label.transform = .identity
        }
    }

    
    
    
}





//MARK: - Extension: Set User Interface

extension GameView {
    
    private func setUIElements() {
        
        //Background image
        let bgImage = UIElements.generateBackGroundImage(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(bgImage)
        backGroundImage = bgImage
        
        //Task label
        let tLabel = UIElements.generateTaskLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(tLabel)
        taskLabel = tLabel
        
        //yesView
        let yView = UIElements.generateYesButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(yView)
        yesView = yView
        
        // ➕ Add tap recognizer
        let yesTap = UITapGestureRecognizer(target: self, action: #selector(handleYesTap))
        yView.isUserInteractionEnabled = true
        yView.addGestureRecognizer(yesTap)
        
        
        //noView
        let nView = UIElements.generateNoButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(nView)
        noView = nView
        
        // ➕ Add tap recognizer
        let noTap = UITapGestureRecognizer(target: self, action: #selector(handleNoTap))
        nView.isUserInteractionEnabled = true
        nView.addGestureRecognizer(noTap)
        
        
        //Point label
        let pLabel = UIElements.generatePointLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(pLabel)
        pointLabel = pLabel
        
        //Time label
        let cLabel = UIElements.generateTimeLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(cLabel)
        timeLabel = cLabel
        
        //Word Label
        let wlabel = UIElements.generateWordLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(wlabel.container)
        wordLabelView = wlabel
        
        
        // ➕ Add tap recognizer to the whole view
        let mainTap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(mainTap)
    }
    
    private func adjustPointLabel() {
        pointLabel.frame.origin.y = taskLabel.frame.minY - 25 - pointLabel.frame.height
        pointLabel.font = UIFont(name: C.wordGameFont, size: 20)
    }
    
    private func centerTimeLabel() {
        let x = view.frame.width / 2 - timeLabel.frame.width / 2
        let y: CGFloat = (view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) / 2 + view.safeAreaInsets.top - (timeLabel.frame.height / 2)
        timeLabel.frame = CGRect(x: x, y: y, width: timeLabel.frame.width, height: timeLabel.frame.height)
    }
    
    private func resetTimeLabelPosition() {
        let width: CGFloat = 100
        let height: CGFloat = 50
        let x: CGFloat = view.frame.width / 2 - width / 2
        let y: CGFloat = view.frame.height - 100.0 - height
        timeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func setBackgroundImageForPoints() {
        backGroundImage.image = UIImage(named: "pisteet_raibale")
    }

    
}

//MARK: - Only for debugging below this point

extension GameView {
    
    private func printGameDetails() {
        var gameName: String {
            switch gameCategory {
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
        print("Intensity meter in position: \(tierValue)")
        print("Penalty meter in position: \(drinkValue)")
        print("Counting points: \(countPoints)")
        print("Having shorter game: \(shorterGame)")
    }
    
    private func checkTaskAmount(array: [Task]) {
        print("Tasks in array: \(array.count)")
    }
    
    private func checkTaskTemplateFunctionality(array: [Task]) {
        for item in array {
            let converter = TaskStringConverter()
            let templateForTask = converter.renderTemplate(item.template, values: [
                "player1" : "Veikko",
                "player2" : "Mirka",
                "penalties" : String(3)
            ])
            print(templateForTask)
        }
    }
    
    private func checkPlayerData() {
        for i in 1...playerData.count {
            print("Player #\(i): \(playerData[i-1].name), color: \(playerData[i-1].color), points: \(playerData[i-1].points)")
        }
    }
    
    private func checkPlayerIndexes() {
        print("Player 1 indexes: \(p1indexes)")
        print("Player 2 indexes: \(p2indexes)")
    }
    
    private func checkTaskTemplates() {
        for template in tasksTemplates {
            print(template.template)
        }
    }
    
    private func runIndexSafetyCheck() {
        print("--RUNNING INDEX SAFETY CHECK:--")
        print("Number of tasks for the game: \(numberOfTasks)")
        print("Task templates in array: \(tasksTemplates.count)")
        print("p1 indexes in array: \(p1indexes.count)")
        print("p2 indexes in array: \(p2indexes.count)")
        
        guard numberOfTasks == tasksTemplates.count && tasksTemplates.count == p1indexes.count && p1indexes.count == p2indexes.count else {

            print("WARNING: game parameters' count don't match. App may crash during the game!")
            return
        }

    }
    
    private func showCurrentTaskDetails() {
        print("Current task on display: index \(currentTask)")
        print("Player 1: \(playerData[p1indexes[currentTask]].name)")
        print("Player 2: \(playerData[p2indexes[currentTask]].name)")
        print("Points to score: \(tasksTemplates[currentTask].pointsToScore)")
    }
    
}

/*
 
 */

class GameView: UIViewController {
    
//MARK: - Variables & constants
    
    var tapGesture: UITapGestureRecognizer?
    let languageManger = LanguageManager()
    
    //Game parameters from previous VC
    var players: [String] = []
    var gameCategory: Int = 0
    var tierValue: Float = 3.0
    var drinkValue: Float = 1.0
    
    //Game elements
    let numberOfTasks = 30
    var currentTask = 0
    var taskLabel = UILabel()
    var shouldReturn = false
    
    //word explanation
    var points: Int = 0
    var pointLabel = UILabel()
    var timeLabel = UILabel()
    var words: [String] = []
    let gameTime: Int = 60
    var countdownTime: Int = 0
    var timer: Timer?
    var rButton = UIImageView()
    var lButton = UIImageView()
    
    //Generate based on info from previous VC
    var p1list: [Player] = []
    var p2list: [Player] = []
    var tiers: [Int] = []
    var tasksIndexes: [Int] = []
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var timebar: UIProgressView!
    
//MARK: - ViewDidLoad & Screen tap
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setGameParameters()
        prepareGame()
        runIndexSafetyCheck()
        printGameParameters()
    }
    
    @objc func handleScreenTap() {
        
        guard !shouldReturn else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        if gameCategory == 3 {
            addButtons()
            addPointLabel()
            taskLabel.text = words[currentTask]
            currentTask += 1
            setTimer()
            tapGesture?.isEnabled = false
            timebar.isHidden = false
        } else {
            newTask()
        }
    }
    
//MARK: - Word explanation
    
    private func displayWordGameInstructions() {
        if languageManger.getSelectedLanguage() == "en" {
            taskLabel.text = WordGame.startMessageEN
        } else {
            taskLabel.text = WordGame.startMessage
        }
    }
    
    @objc private func handleLeftButtonTap() {
        newWord(didScorePoint: false)
    }

    @objc private func handleRightButtonTap() {
        newWord(didScorePoint: true)
    }
    
    private func addButtons() {
        // Create the left button
        let leftButton = UIImageView()
        leftButton.image = UIImage(named: "wrong")
        view.addSubview(leftButton)
        leftButton.frame = CGRect(x: 100, y: 100, width: 70, height: 70)
        leftButton.center.y = view.frame.height * (3 / 4) - 50
        leftButton.center.x = view.frame.width * (1 / 3)
        leftButton.isUserInteractionEnabled = true
        lButton = leftButton

        // Add tap gesture recognizer to the left button
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLeftButtonTap))
        leftButton.addGestureRecognizer(leftTapGesture)

        // Create the right button
        let rightButton = UIImageView()
        rightButton.image = UIImage(named: "right")
        view.addSubview(rightButton)
        rightButton.frame = CGRect(x: 200, y: 100, width: 70, height: 70)
        rightButton.center.y = view.frame.height * (3 / 4) - 50
        rightButton.center.x = view.frame.width * (2 / 3)
        rightButton.isUserInteractionEnabled = true
        rButton = rightButton

        // Add tap gesture recognizer to the right button
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleRightButtonTap))
        rightButton.addGestureRecognizer(rightTapGesture)
    }

    
    private func newWord(didScorePoint: Bool) {
        guard words.count > currentTask else { return }
        if didScorePoint {
            points += 1
            if languageManger.getSelectedLanguage() == "en" {
                pointLabel.text = "Score: \(points)"
            } else {
                pointLabel.text = "Pisteet: \(points)"
            }
            
        }
        taskLabel.text = words[currentTask]
        currentTask += 1
        performShakingAnimation()
    }
    
    private func addPointLabel() {
        //"Pisteet" = "Points" in Finnish
        if languageManger.getSelectedLanguage() == "en" {
            pointLabel.text = "Score: \(points)"
        } else {
            pointLabel.text = "Pisteet: \(points)"
        }
        pointLabel.textAlignment = .center
        pointLabel.textColor = .white
        pointLabel.font = UIFont(name: C.wordGameFont, size: 30)
        view.addSubview(pointLabel)
        //pointLabel.backgroundColor = .black
        pointLabel.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 30)
    }
    
    private func setTimer() {
        countdownTime = gameTime
        timerFired()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        if countdownTime <= 0 {
            finishGame()
        } else {
            let progress = Float(countdownTime - 1) / Float(gameTime)
            UIView.animate(withDuration: 1.0, animations: {
                self.timebar.setProgress(progress, animated: true)
            })
            
            
            countdownTime -= 1
        }
    }
    
    private func finishGame() {
        timer?.invalidate()
        pointLabel.center.x = view.center.x
        pointLabel.center.y = view.center.y
        taskLabel.isHidden = true
        lButton.isHidden = true
        rButton.isHidden = true
        backImageView.isHidden = true
        timebar.isHidden = true
        performTypingAnimation()
        shouldReturn = true
        tapGesture?.isEnabled = true
    }
    
    private func performTypingAnimation() {
        pointLabel.text = ""
        var text = "Pisteet: \(points)"
        if languageManger.getSelectedLanguage() == "en" {
            text = "Score: \(points)"
        } else {
            text = "Pisteet: \(points)"
        }
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in self.pointLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
//MARK: - New task
    
    private func newTask() {
        
        if shouldReturn {
            navigationController?.popViewController(animated: true)
        } else if currentTask >= numberOfTasks {
            endGame()
        } else {
            print("current task index: \(currentTask)")
            let p1 = p1list[currentTask].name
            let p2 = p2list[currentTask].name
            let c1 = p1list[currentTask].color
            let c2 = p2list[currentTask].color
            let category = gameCategory
            let tier = tiers[currentTask]
            let dValue = drinkValue
            let tIndex = tasksIndexes[currentTask]
            
            let task = SingleTask(player1: p1, player2: p2, color1: c1, color2: c2, category: category, tier: tier, drinkValue: dValue, taskIndex: tIndex)
            taskLabel.attributedText = task.getTask()
            performShakingAnimation()
            currentTask += 1
        }
    }
    
//MARK: - Task label
    
    private func initializeTaskLabel() {
        taskLabel.numberOfLines = 0
        taskLabel.font = UIFont.systemFont(ofSize: 20)
        taskLabel.textAlignment = .center
        taskLabel.textColor = .black
        taskLabel.clipsToBounds = true
        taskLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
        taskLabel.center.x = view.center.x
        taskLabel.center.y = view.frame.height / 2
        view.addSubview(taskLabel)
    }
    
    private func performShakingAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        taskLabel.layer.add(shakeAnimation, forKey: "shake")
    }
    
    private func endGame() {
        //"Peli loppui" = "Game over" in Finnish
        taskLabel.text = languageManger.localizedString(forKey: "GAME_OVER")
        performShakingAnimation()
        shouldReturn = true
    }
    
//MARK: - Prepare game and parameters
    
    private func setBackgroundImage() {
        if languageManger.getSelectedLanguage() == "en" {
            backImageView.image = UIImage(named: "jampartycup_raibale")
        }
    }
    
    private func setGameParameters() {
        var isDateCategory: Bool = false
        if gameCategory == 1 {
            isDateCategory = true
        }
        
        let game = GameManager()
        let playerLists = game.generatePlayerLists(players: players, numberOfTasks: numberOfTasks, isDateCategory: isDateCategory)
        p1list = playerLists.p1
        p2list = playerLists.p2
        tiers = game.generateTierList(sliderValue: tierValue, numberOfTasks: numberOfTasks)
        tasksIndexes = game.generateTaskIndexes(category: gameCategory, numberOfTasks: numberOfTasks, tiers: tiers)
        
        if languageManger.getSelectedLanguage() == "en" {
            words = WordGame.wordsEN
        } else {
            words = WordGame.words
        }
        
        
        words.shuffle()
    }
    
    private func prepareGame() {
        timebar.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        tapGesture = tapGestureRecognizer
        self.view.addGestureRecognizer(tapGestureRecognizer)
        initializeTaskLabel()
        
        if gameCategory == 1 {
            view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)
        }
        
        if gameCategory != 3 {
            newTask()
        }
        
        if gameCategory == 3 {
            displayWordGameInstructions()
            view.backgroundColor = .blue
        }
        
    }
    
//MARK: - Index safety check
    
    private func runIndexSafetyCheck() {
        
        let warningMessage = "Warning: one or more game parameters have invalid count!"
        
        guard p1list.count == 30 else {
            print(warningMessage)
            return
            
        }
        
        guard p2list.count == 30 else {
            print(warningMessage)
            return
            
        }
        
        guard tiers.count == 30 else {
            print(warningMessage)
            return
        }
        
        guard tasksIndexes.count == 30 else {
            print(warningMessage)
            return
        }
        
        print("Index safety check successful!")
        
    }
    
    private func printGameParameters() {
        print("Player 1 list: \(p1list)")
        print("Player 2 list: \(p2list)")
        print("Tiers for tasks: \(tiers)")
        print("Task indexes: \(tasksIndexes)")
    }
    
}

  
  //MARK: - Variables & constants
  
  //Game parameters from previous VC
  var players: [String] = []
  var gameCategory: Int = 0
  var tierValue: Float = 3.0
  var drinkValue: Float = 1.0
  
  //Game elements
  let numberOfTasks = 30
  var currentTask = 0
  var label = UILabel()
  var headLabel = UILabel()
  var shouldReturn = false
  
  //Generate based on info from previous VC
  var p1list: [Player] = []
  var p2list: [Player] = []
  var tiers: [Int] = []
  var tasksIndexes: [Int] = []
  
  //MARK: - Functions
  
  override func viewDidLoad() {
  super.viewDidLoad()
  prepareGame()
  let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
  self.view.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc func handleScreenTap() {
  if shouldReturn {
  navigationController?.popViewController(animated: true)
  shouldReturn = false
  } else {
  headLabel.removeFromSuperview()
  newTask()
  }
  }
  
  func prepareGame() {
  var isDateCategory: Bool {
  if gameCategory == 1 {
  return true
  } else {
  return false
  }
  }
  let game = GameManager()
  let players = game.generatePlayerLists(players: players, numberOfTasks: numberOfTasks, isDateCategory: isDateCategory)
  p1list = players.p1
  p2list = players.p2
  tiers = game.generateTierList(sliderValue: tierValue, numberOfTasks: numberOfTasks)
  tasksIndexes = game.generateTaskIndexes(category: gameCategory, numberOfTasks: numberOfTasks, tiers: tiers)
  if isDateCategory {
  view.backgroundColor = UIColor(red: 184/255.0, green: 108/255.0, blue: 165/255.0, alpha: 1.0)
  }
  newTask()
  }
  
  func newTask() {
  setLabel()
  if currentTask >= numberOfTasks {
  label.text = "Peli loppui!"
  shouldReturn = true
  } else {
  let p1 = p1list[currentTask].name
  let p2 = p2list[currentTask].name
  let c1 = p1list[currentTask].color
  let c2 = p2list[currentTask].color
  let tier = tiers[currentTask]
  let index = tasksIndexes[currentTask]
  let task = SingleTask(player1: p1, player2: p2, color1: c1, color2: c2, category: gameCategory, tier: tier, drinkValue: drinkValue, taskIndex: index)
  label.attributedText = task.getTask()
  }
  performShakingAnimation()
  currentTask += 1
  }
  
  //MARK: - UI elements & functionality
  
  func setLabel() {
  label.removeFromSuperview()
  label.numberOfLines = 0
  label.font = UIFont.systemFont(ofSize: 20)
  label.textAlignment = .center
  label.textColor = .black
  label.clipsToBounds = true
  label.frame = CGRect(x: 0, y: 0, width: 200, height: 250)
  label.center.x = view.center.x
  label.center.y = view.frame.height / 2
  view.addSubview(label)
  performShakingAnimation()
  }
  
  func performShakingAnimation() {
  let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
  shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
  shakeAnimation.duration = 0.3
  shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
  label.layer.add(shakeAnimation, forKey: "shake")
  }
  
  func setHeadLabel() {
  headLabel.text = "Ohjeet"
  headLabel.numberOfLines = 0
  headLabel.font = UIFont.boldSystemFont(ofSize: 24)
  headLabel.textAlignment = .center
  headLabel.textColor = .red
  headLabel.clipsToBounds = true
  headLabel.frame = CGRect(x: 0, y: 100, width: 200, height: 250)
  headLabel.center.x = view.center.x
  view.addSubview(headLabel)
  }
  
  }
  
  */
