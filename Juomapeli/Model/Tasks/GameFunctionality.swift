//
//  Untitled.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 15.11.2025.
//

import UIKit

struct TaskStringConverter {
    
    func renderTemplate(_ template: String, values: [String: String]) -> String {
        var result = template
        for (key, value) in values {
            result = result.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return result
    }
    
    func renderPointScoringTemplate(player: String, language: String) -> String {
        if language == "fi" {
            return "Suorittiko \(player) tehtävän?"
        } else {
            return "Did \(player) complete the task?"
        }
    }
    
    func attributedText(for fullText: String, highlight1: String, highlight2: String, color1: UIColor, color2: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Attributes for the highlighted texts
        let highlight1Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color1,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let highlight2Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        // Apply attributes to highlight1
        let highlight1Range = (fullText as NSString).range(of: highlight1)
        if highlight1Range.location != NSNotFound {
            attributedString.addAttributes(highlight1Attributes, range: highlight1Range)
        }
        
        // Apply attributes to highlight2
        let highlight2Range = (fullText as NSString).range(of: highlight2)
        if highlight2Range.location != NSNotFound {
            attributedString.addAttributes(highlight2Attributes, range: highlight2Range)
        }
        
        return attributedString
    }

}

struct GameFunctionality {
    
    func generatePenaltyValue(baseline: Int, penaltySliderValue: Float) -> Int {
        
        let multiplier = (0.09735) * (penaltySliderValue * penaltySliderValue) + (0.15625)
        let amount = multiplier * Float(baseline)
        var finalNumber = amount.rounded()
        if finalNumber < 1 { finalNumber = 1 }
        return Int(finalNumber)
        
    }
        
        
//MARK: - Player data
    
    func generatePlayerData(players: [String]) -> [PlayerData] {
        var colors = Colors.colors
        colors.shuffle()
        
        var playerData: [PlayerData] = []
        
        for i in 0..<players.count {
            
            var color: UIColor {
                if i >= colors.count {
                    return .yellow
                } else {
                    return colors[i]
                }
            }
            
            let newPlayer = PlayerData(name: players[i], color: color, points: 0)
            playerData.append(newPlayer)
        }
        
        return playerData
        
    }
    
    func generatePlayerIndexes(players: [String], numberOfTasks: Int) -> (p1: [Int], p2: [Int]) {
        
        //Generate p1 indexes
        var p1indexes: [Int] = []
        var indexToInsert = 0
        
        for _ in 0..<numberOfTasks {
            if indexToInsert == players.count - 1 {
                p1indexes.append(indexToInsert)
                indexToInsert = 0
            } else {
                p1indexes.append(indexToInsert)
                indexToInsert += 1
            }
        }
        
        p1indexes.shuffle()
        
        var p2indexes: [Int] = []
        
        for i in 0..<numberOfTasks {
            var arrayForRandomP2 = Array(0..<players.count)
            arrayForRandomP2.remove(at: p1indexes[i])
            p2indexes.append(arrayForRandomP2.randomElement() ?? 0)
        }
        
        return (p1: p1indexes, p2: p2indexes)
        
    }
    
    func generatePlayerIndexesForDatemode(players: [String], numberOfTasks: Int) -> (p1: [Int], p2: [Int]) {
        
        guard players.count > 1 else {
            print("Less than 2 players! Cannot start game. (This should never occur)")
            return (p1: [], p2: [])
        }
        
        var p1index = 0
        var p2index = 1
        
        var p1indexes: [Int] = []
        var p2indexes: [Int] = []
        
        for _ in 0..<numberOfTasks {
            if p1index >= players.count {
                p1index = 0
                p1indexes.append(p1index)
                p1index += 1
            } else {
                p1indexes.append(p1index)
                p1index += 1
            }
            
            if p2index >= players.count {
                p2index = 0
                p2indexes.append(p2index)
                p2index += 1
            } else {
                p2indexes.append(p2index)
                p2index += 1
            }
            
        }
        
        return (p1: p1indexes, p2: p2indexes)
        
    }
    
//MARK: - Task data
    
    func generateTaskTemplatesForBasicGame(numberOfTasks: Int, language: String, hasPlusSub: Bool) -> [Task] {
        
        var targetTaskArray: [Task] = (language == "fi") ? BasicGameTasksFI.tasks : BasicGameTasksEN.tasks
            
        if !hasPlusSub {
            if targetTaskArray.count > 30 {
                targetTaskArray = Array(targetTaskArray.prefix(30))
            }
        }
        
        targetTaskArray.shuffle()
        
        targetTaskArray = Array(targetTaskArray.prefix(numberOfTasks))
        
        return targetTaskArray
        
    }
    
    func generateDebugTaskTemplates() -> [Task] {
        var arrayToReturn: [Task] = []
        
        arrayToReturn.append(contentsOf: BasicGameTasksFI.tasks)
        arrayToReturn.append(contentsOf: BasicGameTasksEN.tasks)
        arrayToReturn.append(contentsOf: DateTasksFI.tasks)
        arrayToReturn.append(contentsOf: DateTasksEN.tasks)
        arrayToReturn.append(contentsOf: TeamsFITasks.tasks)
        arrayToReturn.append(contentsOf: TeamsENTasks.tasks)
        arrayToReturn.append(contentsOf: Tier1FITasks.tasks)
        arrayToReturn.append(contentsOf: Tier1ENTasks.tasks)
        arrayToReturn.append(contentsOf: Tier2FITasks.tasks)
        arrayToReturn.append(contentsOf: Tier2ENTasks.tasks)
        arrayToReturn.append(contentsOf: Tier3FITasks.tasks)
        arrayToReturn.append(contentsOf: Tier3ENTasks.tasks)
        arrayToReturn.append(contentsOf: Tier4FITasks.tasks)
        arrayToReturn.append(contentsOf: Tier5ENTasks.tasks)
        arrayToReturn.append(contentsOf: Tier5FITasks.tasks)
        arrayToReturn.append(contentsOf: Tier5ENTasks.tasks)
        
        return arrayToReturn
                             
    }
    
    func generateTaskTemplatesForDatemode(numberOfTasks: Int, language: String) -> [Task] {
        
        var targetTaskArray: [Task] = (language == "fi") ? DateTasksFI.tasks : DateTasksEN.tasks
        
        targetTaskArray.shuffle()
        targetTaskArray = Array(targetTaskArray.prefix(numberOfTasks))
        
        return targetTaskArray
        
    }
    
    func generateTierIndexes(sliderValue: Float, numberOfTasks: Int) -> [Int] {
        //print("Generating indexes with slider value: \(sliderValue)")
        
        var tiers: [Int] = []
        
        let minValue: Float = sliderValue - 1
        let maxValue: Float = sliderValue + 1
        
        for _ in 0..<numberOfTasks {
            
            let tierIndex = Float.random(in: minValue...maxValue)
            
            if tierIndex > 4.5 {
                tiers.append(5)
            } else if tierIndex > 3.5 {
                tiers.append(4)
            } else if tierIndex > 2.5 {
                tiers.append(3)
            } else if tierIndex > 1.5 {
                tiers.append(2)
            } else {
                tiers.append(1)
            }
            
        }
        
        return tiers
        
    }
    
    func generateTaskTemplatesForExtremeMode(numberOfTasks: Int, language: String, tiers: [Int]) -> [Task] {
        
        var taskTemplateArray: [Task] = []
        
        var t1array: [Task] = (language == "fi") ? Tier1FITasks.tasks : Tier1ENTasks.tasks
        var t2array: [Task] = (language == "fi") ? Tier2FITasks.tasks : Tier2ENTasks.tasks
        var t3array: [Task] = (language == "fi") ? Tier3FITasks.tasks : Tier3ENTasks.tasks
        var t4array: [Task] = (language == "fi") ? Tier4FITasks.tasks : Tier4ENTasks.tasks
        var t5array: [Task] = (language == "fi") ? Tier5FITasks.tasks : Tier5ENTasks.tasks
        
        t1array.shuffle()
        t2array.shuffle()
        t3array.shuffle()
        t4array.shuffle()
        t5array.shuffle()
        
        guard numberOfTasks == tiers.count else {
            print("Warning: Number of tasks does not match number of tier indexes. Returning empty array.")
            return []
        }
        
        for i in 0..<numberOfTasks {
            let tier = tiers[i]
            var targetArray: [Task]
            
            switch tier {
            case 1:
                targetArray = t1array
            case 2:
                targetArray = t2array
            case 3:
                targetArray = t3array
            case 4:
                targetArray = t4array
            case 5:
                targetArray = t5array
            default:
                targetArray = t1array
            }
            
            taskTemplateArray.append(targetArray[i])
            
        }
        
        return taskTemplateArray
        
    }
    
    func generateTaskIndexesForBasicGame(numberOfTasks: Int, currentLanguage: String, hasPlusSubscription: Bool) -> [Int] {
        
        
        var targetArray: [Task] {
            if currentLanguage == "fi" {
                return BasicGameTasksFI.tasks
            } else {
                return BasicGameTasksEN.tasks
            }
        }
        
        var amountOfTasksToRandomize: Int {
            if !hasPlusSubscription {
                return 30
            } else {
                return targetArray.count
            }
        }
        
        var indexArray = Array(0..<amountOfTasksToRandomize)
        indexArray.shuffle()
        
        var arrayToReturn: [Int] = []
        
        for i in 0..<numberOfTasks {
            arrayToReturn.append(indexArray[i])
        }
        
        return arrayToReturn
        
    }
    
}

struct TeamModeFunctionality {
    
    func generateTeams(players: [String]) -> (red: Team, blue: Team) {
        let languageManager = LanguageManager()
        var playersToAssign: [String] = players
        playersToAssign.shuffle()
        
        var redTeam = Team(name: languageManager.localizedString(forKey: "RED_TEAM"), players: [], points: 0, color: .red)
        var blueTeam = Team(name: languageManager.localizedString(forKey: "BLUE_TEAM"), players: [], points: 0, color: .blue)
        
        var addToRedTeam: Bool = true
        
        for player in playersToAssign {
            if addToRedTeam {
                redTeam.players.append(player)
            } else {
                blueTeam.players.append(player)
            }
            addToRedTeam.toggle()
        }
        
        return (red: redTeam, blue: blueTeam)
    }
    
    func renderTemplate(_ template: String, values: [String: String]) -> String {
        var result = template
        for (key, value) in values {
            result = result.replacingOccurrences(of: "{\(key)}", with: value)
        }
        return result
    }
    
    func attributedText(for fullText: String, highlight1: String, highlight2: String, highlight3: String, color1: UIColor, color2: UIColor, color3: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Attributes for the highlighted texts
        let highlight1Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color1,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let highlight2Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color2,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        let highlight3Attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color3,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        
        
        
        // Apply attributes to highlight1
        let highlight1Range = (fullText as NSString).range(of: highlight1)
        if highlight1Range.location != NSNotFound {
            attributedString.addAttributes(highlight1Attributes, range: highlight1Range)
        }
        
        // Apply attributes to highlight2
        let highlight2Range = (fullText as NSString).range(of: highlight2)
        if highlight2Range.location != NSNotFound {
            attributedString.addAttributes(highlight2Attributes, range: highlight2Range)
        }
        
        let highlight3Range = (fullText as NSString).range(of: highlight3)
        if highlight3Range.location != NSNotFound {
            attributedString.addAttributes(highlight3Attributes, range: highlight3Range)
        }
        
        return attributedString
    }
    
}
