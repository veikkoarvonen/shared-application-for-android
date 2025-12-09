//
//  TeamVC.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 2.12.2025.
//

import UIKit

class TeamView: UIViewController {
    
    var hasSetUI: Bool = false
    let UIBuilder = TeamVCUI()
    var UIElements: TeamUIElements!
    var gameConfiguaration: TeamModeConfiguration!
    var gameParameters: TeamModeParameters?
    let languageManager = LanguageManager()
    let gameFunctionality = TeamModeFunctionality()
    var timer: Timer?
    
    enum GamePhase {
        case settingTeams
        case instructions
        case playing
        case ended
    }
    
    var gamePhase: GamePhase = .settingTeams
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if C.debugApp { checkGameConfiguration() }
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetUI {
            hasSetUI = true
            setUI()
            updateUI(phase: gamePhase)
            randomizeTeams()
        }
    }
    
//MARK: - Objc functions
    
    @objc private func handleRandomizeTap() {
        print("Randomize tapped")
        if gamePhase == .settingTeams {
            randomizeTeams()
        }
    }

    @objc private func handleStartGameTap() {
        print("Start Game tapped")
        if gamePhase == .settingTeams {
            if canProceedToGame() {
                proceedToGame()
            } else {
                showAlert()
            }
        }
    }

    @objc private func handleScreenTap() {
        print("Screen tapped")
        switch gamePhase {
        case .instructions:
            gamePhase = .playing
            timer?.invalidate()
            timer = nil
            newTask()
            updateUI(phase: .playing)
        case .playing:
            if gameConfiguaration.countPoints { return }
            newTask()
        case .ended:
            navigationController?.popViewController(animated: true)
        default: return
        }
    }
    
    @objc private func handleRedTap() {
        print("Red tapped")
        if !gameConfiguaration.countPoints { return }
        if gamePhase == .playing {
            addPointsToRedTeam()
            newTask()
            if C.debugApp { printScoreboard() }
        }
    }
    
    @objc private func handleBlueTap() {
        print("Blue tapped")
        if !gameConfiguaration.countPoints { return }
        if gamePhase == .playing {
            addPointsToBlueTeam()
            newTask()
            if C.debugApp { printScoreboard() }
        }
    }
    
//MARK: - Team selection pan gesture
    
    //Handle team selection pan
    @objc private func handlePlayerPan(_ gesture: UIPanGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        
        // This is your "ID" (same as index in gameConfiguaration.players)
        let id = label.tag
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            // move the label with the finger
            label.center.x = CGFloat(label.center.x + translation.x,)
            gesture.setTranslation(.zero, in: view)
            
        case .ended, .cancelled:
            let vX = velocity.x

                if vX < -1000 {
                    // move to blue team
                    let targetX = view.frame.width * 0.25
                    moveTeamMember(index: id, toRed: true)
                    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
                        label.center.x = targetX
                    }
                } else if vX > 1000 {
                    // Move to blue team
                    let targetX = view.frame.width * 0.75
                    moveTeamMember(index: id, toRed: false)
                    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
                        label.center.x = targetX
                    }
                } else {
                    //Move to 25% or 75% based on whether the label center x is on left or right side of the view
                    let midpoint = view.frame.width / 2
                        let targetX: CGFloat
                        
                        if label.center.x < midpoint {
                            // Left half → red team
                            moveTeamMember(index: id, toRed: true)
                            targetX = view.frame.width * 0.25
                        } else {
                            // Right half → blue team
                            moveTeamMember(index: id, toRed: false)
                            targetX = view.frame.width * 0.75
                        }
                        
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                            label.center.x = targetX
                        }
                }
            
        default:
            break
        }
    }

    
//MARK: - Team selection phase
    
    //Randomize teams in game configuration
    private func randomizeTeams() {
        var teamIndexArray: [Int] = []
        var addToRed: Bool = true
        for _ in 0..<gameConfiguaration.players.count {
            let index = addToRed ? 0 : 1
            addToRed.toggle()
            teamIndexArray.append(index)
        }
        
        teamIndexArray.shuffle()
        gameConfiguaration.teamConfigurationIndexes = teamIndexArray
        
        if C.debugApp { print("Players: \(gameConfiguaration.players)") }
        if C.debugApp { print("Team index array: \(teamIndexArray)") }
        
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) { [self] in
            for i in 0..<UIElements.playerLabels.count {
                if teamIndexArray[i] == 0 {
                    UIElements.playerLabels[i].center.x = view.frame.width * 1 / 4
                } else {
                    UIElements.playerLabels[i].center.x = view.frame.width * 3 / 4
                }
            }
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
        }
    }
    
    //Move one player between teams
    private func moveTeamMember(index: Int, toRed: Bool) {
        let indexToMove: Int = toRed ? 0 : 1
        gameConfiguaration.teamConfigurationIndexes[index] = indexToMove
        if C.debugApp { print("Players: \(gameConfiguaration.players)") }
        if C.debugApp { print("Team index array: \(gameConfiguaration.teamConfigurationIndexes)") }
    }
    
    //Check if teams are equal, return boolean
    private func canProceedToGame() -> Bool {
        let redTeamCount = gameConfiguaration.teamConfigurationIndexes.filter { $0 == 0 }.count
        let blueTeamCount = gameConfiguaration.teamConfigurationIndexes.filter { $0 == 1 }.count
        
        let difference = redTeamCount - blueTeamCount
        
        if abs(difference) > 1 {
            if C.debugApp { print("Cannot proceed, unequal teams! (R:\(redTeamCount) B:\(blueTeamCount))") }
            return false
        }
        
        return true
    }
    
    //Alert if teams are not equal
    private func showAlert() {
        let alert = UIAlertController(
            title: languageManager.localizedString(forKey: "TEAM_ERROR_HEADER"),
            message: languageManager.localizedString(forKey: "TEAM_ERROR_MESSAGE"),
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    //Proceed to instructions or playing, depending if count points
    private func proceedToGame() {
        gamePhase = gameConfiguaration.countPoints ? .instructions : .playing
        if C.debugApp { print("Proceeding to game!, current phase: \(gamePhase)") }
        updateUI(phase: gamePhase)
        setGameParameters()
        if C.debugApp { checkGameParameters() }
        if gamePhase == .playing { newTask() } else { animateTeamSelectionLabels() }
    }
    
    private func animateTeamSelectionLabels() {
            
            var count = 0
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
                count += 1
                if C.debugApp { print(count) }
                if count == 1 {
                    popAnimation(for: UIElements.redTeamButton!.container)
                    popRedPointAnimation()
                }
                if count == 2 {
                    popAnimation(for: UIElements.blueTeamVButton!.container)
                    popBluePointAnimation()
                }
                print(count)
                if count == 5 {
                    count = 0
                }
            }
    }
    
//MARK: - Playing phase
    
    //Set game parameters before starting the game
    private func setGameParameters() {
        
        let language = languageManager.getSelectedLanguage()
        let numberOfTasks: Int = gameConfiguaration.shorterRound ? 10 : 20
        var taskTemplates: [Task] = language == "fi" ? TeamsFITasks.tasks : TeamsENTasks.tasks
        taskTemplates.shuffle()
        taskTemplates = Array(taskTemplates.prefix(numberOfTasks))
        
        var redTeam = Team(name: languageManager.localizedString(forKey: "RED_TEAM"), players: [], points: 0, color: .red)
        var blueTeam = Team(name: languageManager.localizedString(forKey: "BLUE_TEAM"), players: [], points: 0, color: .blue)
        for i in 0..<gameConfiguaration.players.count {
            let index: Int = gameConfiguaration.teamConfigurationIndexes[i]
            if index == 0 {
                redTeam.players.append(gameConfiguaration.players[i])
            } else {
                blueTeam.players.append(gameConfiguaration.players[i])
            }
        }
        
        var teamIndexes: [Int] {
            var addToRed: Bool = true
            var indexes: [Int] = []
            for _ in 0..<numberOfTasks {
                let index = addToRed ? 0 : 1
                indexes.append(index)
                addToRed.toggle()
            }
            indexes.shuffle()
            return indexes
        }
        
        gameParameters = TeamModeParameters(currentTask: 0, numberOfTasks: numberOfTasks, taskTemplates: taskTemplates, teamIndexes: teamIndexes, parametersAreSet: true, redTeam: redTeam, blueTeam: blueTeam)
    }
    
    //Display new task based on game parameters. End game if index out of range
    private func newTask() {
        guard gameParameters!.parametersAreSet else {
            print("WARNING! Game parameters not set when calling newTask()")
            return
        }
        let currentTaskIndex = gameParameters!.currentTask
        
        if currentTaskIndex >= gameParameters!.numberOfTasks {
            endGame()
            if C.debugApp { print("Task index exeeded - ending game") }
            return
        }
        
        if C.debugApp { printCurrentTaskDetails() }
        
        let testTemplate = TeamsFITasks.testTemplate
        let currentTemplate = gameParameters!.taskTemplates[currentTaskIndex]
        
        
        let currentTeamIndex = gameParameters!.teamIndexes[currentTaskIndex]
        let currentTeam = currentTeamIndex == 0 ? gameParameters!.redTeam! : gameParameters!.blueTeam!
        let opponentTeam = currentTeamIndex == 0 ? gameParameters!.blueTeam! : gameParameters!.redTeam!
        
        let p1 = currentTeam.players.randomElement()!
        let p2 = opponentTeam.players.randomElement()!
        
        let taskTemplate = gameFunctionality.renderTemplate(currentTemplate.template, values: [
            "team1" : currentTeam.name,
            "player1" : p1,
            "player2" : p2,
            "penalties" : String(currentTemplate.baselinePenalty)
        ])
        
        let attributedString = gameFunctionality.attributedText(for: taskTemplate, highlight1: currentTeam.name, highlight2: p1, highlight3: p2, color1: currentTeam.color, color2: currentTeam.color, color3: opponentTeam.color)
        UIElements.taskLabel.attributedText = attributedString
        
        UIElements.redTeamButton?.label.text = String(currentTemplate.pointsToScore)
        UIElements.blueTeamVButton?.label.text = String(currentTemplate.pointsToScore)
        
        performShakingAnimation()
        
        gameParameters!.currentTask += 1
    }
    
    //Shake task label
    private func performShakingAnimation() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-9, 9, -6, 6, -3, 3, 0]
        UIElements.taskLabel.layer.add(shakeAnimation, forKey: "shake")
    }
    
    //Add points to red (Checks index based on game parameters
    private func addPointsToRedTeam() {
        guard gameParameters!.parametersAreSet else {
            print("WARNING! Game parameters not set when calling addPointsToRedTeam()")
            return
        }
        let currentTaskIndex = gameParameters!.currentTask
        let pointsToAdd: Int = (gameParameters?.taskTemplates[currentTaskIndex - 1].pointsToScore)!
        gameParameters?.redTeam?.points += pointsToAdd
        popRedPointAnimation()
        popAnimation(for: UIElements.redTeamButton!.container)
        if C.debugApp {
            print("Adding \(pointsToAdd) to red team points from task index: \(currentTaskIndex - 1)")
        }
    }
    
    //Add points to blue (Checks index based on game parameters
    private func addPointsToBlueTeam() {
        guard gameParameters!.parametersAreSet else {
            print("WARNING! Game parameters not set when calling addPointsToBlueTeam()")
            return
        }
        let currentTaskIndex = gameParameters!.currentTask
        let pointsToAdd: Int = (gameParameters?.taskTemplates[currentTaskIndex - 1].pointsToScore)!
        gameParameters?.blueTeam?.points += pointsToAdd
        popBluePointAnimation()
        popAnimation(for: UIElements.blueTeamVButton!.container)
        if C.debugApp {
            print("Adding \(pointsToAdd) to blue team points from task index: \(currentTaskIndex - 1)")
        }
    }
    
    private func popRedPointAnimation() {
        let interval = 1.0
        let label = UILabel()
        let currentTaskIndex = gameParameters!.currentTask
        var pointsToAdd: Int {
            if gamePhase == .playing {
                return (gameParameters?.taskTemplates[currentTaskIndex - 1].pointsToScore)!
            } else {
                return 1
            }
        }
        label.text = "\(pointsToAdd)"
        label.font = UIFont.boldSystemFont(ofSize: 150)
        label.textAlignment = .center
        label.textColor = UIColor(named: "redTeamColor")
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 150)

        // Position above yes button
        label.center = CGPoint(
            x: UIElements.redTeamButton!.container.center.x,
            y: UIElements.redTeamButton!.container.center.y - 120
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
    
    private func popBluePointAnimation() {
        let interval = 1.0
        let label = UILabel()
        let currentTaskIndex = gameParameters!.currentTask
        var pointsToAdd: Int {
            if gamePhase == .playing {
                return (gameParameters?.taskTemplates[currentTaskIndex - 1].pointsToScore)!
            } else {
                return 1
            }
        }
        label.text = "\(pointsToAdd)"
        label.font = UIFont.boldSystemFont(ofSize: 150)
        label.textAlignment = .center
        label.textColor = UIColor(named: "blueTeamColor")
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 150)

        // Position above no button
        label.center = CGPoint(
            x: UIElements.blueTeamVButton!.container.center.x,
            y: UIElements.blueTeamVButton!.container.center.y - 120
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
    
    //For team button pop
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
    
//MARK: - End game
    
    //End game - Display scoreboard of counting points
    private func endGame() {
        if C.debugApp { print("Ending game") }
        gamePhase = .ended
        updateUI(phase: gamePhase)
        if gameConfiguaration.countPoints {
            if C.debugApp { print("Counting points: moving to scoreboard function") }
            displayScoreBoard()
        } else {
            if C.debugApp { print("not counting points, showing end game text") }
            UIElements.taskLabel.text = languageManager.localizedString(forKey: "GAME_OVER")
            performShakingAnimation()
        }
    }
    
    //Scoreboard generation
    private func displayScoreBoard() {
        
        guard gameParameters!.parametersAreSet else {
            print("WARNING: game parameters not set when displaying scoreboard. Exiting function")
            return
        }
        
        if C.debugApp { print("Displaying scoreboard!") }
        
        var scoreBoardStringArray: [String] = []
        
        let redTeam = gameParameters!.redTeam!
        let blueTeam = gameParameters!.blueTeam!
        
        let headerString = redTeam.points == blueTeam.points ? languageManager.localizedString(forKey: "TIE") : languageManager.localizedString(forKey: "POINTS")
        scoreBoardStringArray.append(headerString)
        
        if blueTeam.points > redTeam.points {
            scoreBoardStringArray.append("🥇 \(blueTeam.name) (\(blueTeam.points))")
            scoreBoardStringArray.append("🥈 \(redTeam.name) (\(redTeam.points))")
        } else {
            scoreBoardStringArray.append("🥇 \(redTeam.name) (\(redTeam.points))")
            scoreBoardStringArray.append("🥈 \(blueTeam.name) (\(blueTeam.points))")
        }
        var y: CGFloat = view.safeAreaInsets.top + 100.0
        
        var labelsToAdd: [UILabel] = []
        
        for i in 0...2 {
            let label = UILabel()
            label.textAlignment = .center
            label.font = i == 0 ? UIFont(name: C.wordGameFont, size: 40) : UIFont(name: "Optima-Bold", size: 30)
            label.textColor = .white
            label.text = scoreBoardStringArray[i]
            label.shadowColor = UIColor.black
            label.shadowOffset = CGSize(width: 2, height: 2)
            labelsToAdd.append(label)
            label.frame = CGRect(x: 0, y: y, width: view.frame.width, height: 50)
            if i == 0 { y += 80.0 } else { y += 50.0 }
        }
        
        labelsToAdd[0].text = ""
        view.addSubview(labelsToAdd[0])
        let text = languageManager.localizedString(forKey: "SCOREBOAD_HEADER")
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in labelsToAdd[0].text?.append(letter)
            }
            charIndex += 1
        }
        
        view.addSubview(labelsToAdd[1])
        view.addSubview(labelsToAdd[2])
        
        labelsToAdd[1].alpha = 0.0
        labelsToAdd[1].transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        labelsToAdd[2].alpha = 0.0
        labelsToAdd[2].transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) { [self] in
                labelsToAdd[1].alpha = 1.0
                labelsToAdd[1].transform = .identity
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut]) { [self] in
                labelsToAdd[2].alpha = 1.0
                labelsToAdd[2].transform = .identity
            }
        }
            
    }
    
}

//MARK: - User interface

extension TeamView {
    
    private func setUI() {
        
        view.backgroundColor = UIColor(named: "teamMode")
        
        //backGroundImage
        let bgImage = UIBuilder.generateBackGroundImage(viewFrame: view.frame, safeArea: view.safeAreaInsets, countPoints: gameConfiguaration.countPoints)
        view.addSubview(bgImage)
        
        //Task label
        let tLabel = UIBuilder.generateTaskLabel(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(tLabel)
        if gameConfiguaration.countPoints { tLabel.center.y -= 90 }
        
        //Point instruction button
        let iView = UIBuilder.generatePointInstructionView(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(iView)
        
        //Red team view
        let rView = UIBuilder.generateRedTeamView(viewFrame: view.frame)
        view.addSubview(rView)
        
        //Blue team view
        let bView = UIBuilder.generateBlueTeamView(viewFrame: view.frame)
        view.addSubview(bView)
        
        //Red team button
        let rtButton = UIBuilder.generateRedTeamButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        rtButton.container.isUserInteractionEnabled = true
        let redTap = UITapGestureRecognizer(target: self, action: #selector(handleRedTap))
        rtButton.container.addGestureRecognizer(redTap)
        view.addSubview(rtButton.container)
        
        //Blue team button
        let btButton = UIBuilder.generateBlueTeamButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        btButton.container.isUserInteractionEnabled = true
        let blueTap = UITapGestureRecognizer(target: self, action: #selector(handleBlueTap))
        btButton.container.addGestureRecognizer(blueTap)
        view.addSubview(btButton.container)
        
        // Randomize button
        let rButton = UIBuilder.generateRandomizeButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        rButton.isUserInteractionEnabled = true
        let rTap = UITapGestureRecognizer(target: self, action: #selector(handleRandomizeTap))
        rButton.addGestureRecognizer(rTap)
        view.addSubview(rButton)

        // Start game button
        let tButton = UIBuilder.generateStartGameButton(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        tButton.isUserInteractionEnabled = true
        let tTap = UITapGestureRecognizer(target: self, action: #selector(handleStartGameTap))
        tButton.addGestureRecognizer(tTap)
        view.addSubview(tButton)

        //Red team header
        let rHeader = UIBuilder.generateRedTeamHeaderView(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(rHeader)
        
        //Blue team header
        let bHeader = UIBuilder.generateBlueTeamHeaderView(viewFrame: view.frame, safeArea: view.safeAreaInsets)
        view.addSubview(bHeader)
        
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.addGestureRecognizer(screenTap)

        var playerLabels: [UILabel] = []
        
        for i in 0..<gameConfiguaration.players.count {
            let playerLabel = UIBuilder.generatePlayerLabel(viewFrame: view.frame, player: gameConfiguaration.players[i])
            playerLabel.tag = i
            playerLabel.isUserInteractionEnabled = true
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePlayerPan(_:)))
            playerLabel.addGestureRecognizer(pan)
            view.addSubview(playerLabel)
            playerLabels.append(playerLabel)
        }
        
        UIElements = TeamUIElements(backGroundImage: bgImage, taskLabel: tLabel, redTeamButton: rtButton, blueTeamVButton: btButton, instructionView: iView, redView: rView, blueView: bView, redHeader: rHeader, blueHeader: bHeader, randomizeButton: rButton, startButton: tButton, playerLabels: playerLabels)
        
        positionPlayerLabels()
       
    }
    
    private func positionPlayerLabels() {
        let labels = UIElements.playerLabels
        let playerCount = labels.count
        
        guard playerCount > 0 else { return }
        
        let topBorder = view.safeAreaInsets.top + 85
        let bottomBorder = view.safeAreaInsets.bottom + 90
        let availableHeight = view.frame.height - topBorder - bottomBorder
        
        let gap: CGFloat = 5
        let maxHeight: CGFloat = 50
        
        // Compute ideal height per label (including gaps)
        let blockHeight = availableHeight / CGFloat(playerCount)
        let labelHeight = min(maxHeight, blockHeight - gap * 2)
        
        var currentY = topBorder + gap
        
        for label in labels {
            // Always set the frame directly → avoids center mismatch
            label.frame = CGRect(
                x: label.frame.origin.x,
                y: currentY,
                width: label.frame.width,
                height: labelHeight
            )
            
            currentY += blockHeight
        }
    }
    
    private func updateUI(phase: GamePhase) {
        if C.debugApp { print("Updating UI with phase: \(phase)") }
        let countPoints = gameConfiguaration.countPoints
        switch phase {
        case .settingTeams:
            hideUIElements(redHeader: false, blueHeader: false, redView: false, blueView: false, playerLabels: false, startButton: false, randomizeButton: false, instructionView: true, taskLabel: true, backGroundImage: true, redTeamButton: true, blueTeamButton: true)
        case .instructions:
            hideUIElements(redHeader: true, blueHeader: true, redView: true, blueView: true, playerLabels: true, startButton: true, randomizeButton: true, instructionView: false, taskLabel: true, backGroundImage: false, redTeamButton: false, blueTeamButton: false)
        case .playing:
            hideUIElements(redHeader: true, blueHeader: true, redView: true, blueView: true, playerLabels: true, startButton: true, randomizeButton: true, instructionView: true, taskLabel: false, backGroundImage: false, redTeamButton: !countPoints, blueTeamButton: !countPoints)
        case .ended:
            hideUIElements(redHeader: true, blueHeader: true, redView: true, blueView: true, playerLabels: true, startButton: true, randomizeButton: true, instructionView: true, taskLabel: countPoints, backGroundImage: countPoints, redTeamButton: true, blueTeamButton: true)
        }
    }
    
    private func hideUIElements(redHeader: Bool, blueHeader: Bool, redView: Bool, blueView: Bool, playerLabels: Bool, startButton: Bool, randomizeButton: Bool, instructionView: Bool, taskLabel: Bool, backGroundImage: Bool, redTeamButton: Bool, blueTeamButton: Bool) {
        
        UIElements.redHeader.isHidden = redHeader
        UIElements.blueHeader.isHidden = blueHeader
        UIElements.redView.isHidden = redView
        UIElements.blueView.isHidden = blueView
        UIElements.startButton.isHidden = startButton
        UIElements.randomizeButton.isHidden = randomizeButton
        UIElements.instructionView.isHidden = instructionView
        UIElements.taskLabel.isHidden = taskLabel
        for label in UIElements.playerLabels {
            label.isHidden = playerLabels
        }
        
        UIView.animate(withDuration: 0.2) { [self] in
            UIElements.redHeader.alpha = redHeader ? 0 : 1
            UIElements.blueHeader.alpha = blueHeader ? 0 : 1
            UIElements.redView.alpha = redView ? 0 : 1
            UIElements.blueView.alpha = blueView ? 0 : 1
            UIElements.startButton.alpha = startButton ? 0 : 1
            UIElements.randomizeButton.alpha = randomizeButton ? 0 : 1
            UIElements.instructionView.alpha = instructionView ? 0 : 1
            UIElements.taskLabel.alpha = taskLabel ? 0 : 1
            UIElements.backGroundImage.alpha = backGroundImage ? 0 : 1
            UIElements.redTeamButton?.container.alpha = redTeamButton ? 0 : 1
            UIElements.blueTeamVButton?.container.alpha = blueTeamButton ? 0 : 1
            for label in UIElements.playerLabels {
                label.alpha = playerLabels ? 0 : 1
            }
        }
        
        
    }

}

//MARK: - Only for debugging beloew this point

extension TeamView {
    
    private func checkGameConfiguration() {
        print("--GAME CONFIGURATION:--")
        print("Players: \(gameConfiguaration.players) total: \(gameConfiguaration.players.count)")
        print("Counting points: \(gameConfiguaration.countPoints)")
        print("Is shorter round: \(gameConfiguaration.shorterRound)")
    }
    
    private func checkGameParameters() {
        
        guard gameParameters != nil && gameParameters?.redTeam != nil && gameParameters?.blueTeam != nil && gameParameters?.teamIndexes != nil else {
            print("WARNING: Game parameters are not set!")
            return
        }
        
        print("--GAME PARAMETERS:--")
        print("Numer of tasks for game: \(gameParameters!.numberOfTasks)")
        print("Number of task templates: \(gameParameters!.taskTemplates.count)")
        print("Team indexes: \(gameParameters!.teamIndexes)")
        print("Red team players:")
        for player in gameParameters!.redTeam!.players {
            print(player)
        }
        print("Blue team players:")
        for player in gameParameters!.blueTeam!.players {
            print(player)
        }

    }
    
    private func printCurrentTaskDetails() {
        print("Showing task on index: \(gameParameters!.currentTask)")
        let currentTeam = gameParameters?.teamIndexes[gameParameters!.currentTask] == 0 ? gameParameters!.redTeam!.name : gameParameters!.blueTeam!.name
        print("Current Team: \(currentTeam)")
    }
    
    private func printScoreboard() {
        guard gameParameters!.parametersAreSet else {
            return
        }
        
        print("SCOREBOARD: Red team has \(gameParameters!.redTeam!.points) points, Blue team has \(gameParameters!.blueTeam!.points) points")
    }
    
}
