//
//  Tier2EN.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 18.11.2025.
//

import Foundation

struct Tier2ENTasks {
    
    static let tasks = [
        Task(
        template:"{player1}, what's the longest you've gone without brushing your teeth? Answer or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "The player with the best butt takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:                    "The player with the biggest biceps takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, you’re not allowed to laugh for the rest of the game. If you fail, take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, what's an extraordinary thing you've done? Everyone who hasn’t done it take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, wear {player2}’s socks on your hands for the rest of the game or take {penalties} penalties.",
        pointsToScore: 3,
        baselinePenalty: 5
        ),
        Task(
        template:                    "Everyone makes baby noises. The worst performer takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, if your screen time is higher than {player2}’s, take {penalties} penalties. Otherwise, {player2} takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player2}, tell an interesting fact. Everyone who didn’t know it takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, rank these body parts in order of attractiveness: armpits, toes, ears — or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "Waterfall! {player1} starts. Continue counter-clockwise.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, impersonate one of the other players for 10 seconds or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, challenge {player2} to a thumb war. Loser takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:                    "{player1}, give each player a funny nickname or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, hug {player2} or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, tell a joke. If no one laughs, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, however many push-ups you do, {player2} takes that many penalties.",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, do 10 push-ups or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1} and {player2}, staring contest! Loser takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:                    "{player1}, imitate a lion for 15 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 5
        ),
        Task(
        template:                    "{player1}, let player {player2} style your hair for the rest of the game or take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, what's the most embarrassing situation you've been in? Answer or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, imitate a celebrity until others guess who it is. If you fail, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, what's your biggest fantasy? Answer or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, give your best pickup line. If others don’t find it funny, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 5
        ),
        Task(
        template:                    "Each player makes a weird noise. Anyone refusing takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, kneel before {player2} and propose — or take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, purr like a cat for 5 seconds or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "Next player to laugh takes {penalties} penalties!",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, go to the corner to 'shame' yourself for three rounds.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, name a song suitable for bedroom activities or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, freestyle rap about tonight. The others will judge if you get away without {penalties} penalties.",
        pointsToScore: 3,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, try licking your elbow. If you fail, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, what's your bench press max? For every 10 kg, give out {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 1
        ),
        Task(
        template:                    "{player1}, Telepathy challenge! Try to say the same car brand as {player2} at the same time. If you fail, both take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, give your best Goofy impression or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, play an air guitar for 15 seconds or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, whisper only for the next 3 rounds. If you fail, take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, make everyone laugh without talking. If you fail, take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, act like a baby for 2 rounds or take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:                    "Everyone imitates an animal in turn. The worst one takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 5
        ),
        Task(
        template:                    "{player1}, jump as high as you can. If the others aren’t convinced, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, hold a plank position for one minute. If you fail, take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, sing opera for 10 seconds or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1}, hum a song of your choice. If others can’t guess it in 15 seconds, take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, what’s your squat max? For every 10 kg, give out {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 1
        ),
        Task(
        template:                    "{player1}, if your heart rate is higher than {player2}’s, take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, do 5 somersaults or take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:                    "{player1} and {player2}, act out a dramatic breakup or both take {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 6
        ),
        Task(
        template:                    "{player1} vs {player2}! First to do 5 somersaults wins. Loser takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 5
        ),
        Task(
        template:                    "{player1}, meow like a cat for 10 seconds or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, do your best Tarzan jungle yell. If you don’t convince the others, take {penalties} penalties.",
        pointsToScore: 2,
        baselinePenalty: 5
        ),
        Task(
        template:                    "Next player to blink takes {penalties} penalties.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:                    "{player1}, howl like a wolf or take {penalties} penalties.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
            template: "{player1}, name 5 anime series in 10 seconds or take {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 3
        ),
        Task(
            template: "The oldest player must give the youngest player a life-changing piece of advice, or take {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 5
        ),
        Task(
            template: "Each player shares the worst thing they’ve done in the past week. The biggest scoundrel takes {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, keep a straight face for the next two rounds. For every time you make a facial expression, take {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 4
        ),
        Task(
            template: "{player1}, compliment {player1} all the way to the heavens! If you make them smile, you avoid {penalties} penalties. If they blush, they take {penalties} penalties themselves",
            pointsToScore: 2,
            baselinePenalty: 5
        ),
        Task(
            template: "Each player introduces themselves with a funny fact. The player with the dullest introduction takes {penalties} penalties. {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, kiss your own belly button. If you fail, take {penalties} penalties",
            pointsToScore: 3,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, tell {player2} something you would like them to know or take {penalties} penalties",
            pointsToScore: 2,
            baselinePenalty: 3
        ),
        Task(
            template: "Every player who has ever blocked an ex on social media takes {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, tell a secret that no other player knows about you yet, or take {penalties} penalties",
            pointsToScore: 2,
            baselinePenalty: 4
        ),
    ]
    
}
