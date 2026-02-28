//
//  Tear1EN.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 18.11.2025.
//

import Foundation

struct Tier1ENTasks {
    
    static let tasks = [
        Task(
        template:"{player1}, name five Jedi Knights from Star Wars movies or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, if you were a potato, would you rather be peeled or boiled? Answer or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "Every player under 6 ft tall takes {penalties} penalties",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, however many push-ups you do, {player2} takes that many penalties",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, Telepathy challenge! Try to say the same word as player {player2} at the same time. If you fail, both take {penalties} penalties. Category: color",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Tell a story one word at a time. The first player to freeze takes {penalties} penalties. Start clockwise from {player1}",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, guess where each player will be in 5 years",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, name 5 countries starting with the letter S in 10 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, name 7 Disney princesses in 10 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, do 10 push-ups or take {penalties} penalties",
        pointsToScore: 3,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, make up a new nickname for every player",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, imitate a player of your choice until someone guesses who it is",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, confess a guilty pleasure or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, does pineapple belong on pizza? Take as many penalties as there are players who disagree",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, list the English vowels in reverse order. If you fail, take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, name a good trait about player {player2}",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, name 4 James Bond actors in 10 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, say a sentence in as many languages as you can. For each language, others take {penalties} penalties",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1} picks a category. The first player who can't name a new thing takes {penalties} penalties",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, say 'Betty Botter bought some butter' five times fast without twisting your tongue or take 4 penalties",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, say 'I saw a kitten eating chicken in the kitchen' five times fast without messing up or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, name 10 NATO countries in 10 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, name 6 U.S. states in 10 seconds or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, quote two legendary one-liners from the Terminator movies or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, give a nickname to every player or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, challenge {player2} to rock-paper-scissors. Loser takes {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, imitate an actor of your choice for 10 seconds. If others don't guess the actor, take {penalties} penalties",
        pointsToScore: 3,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, name a song you hate or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "Waterfall! {player1} starts. Move clockwise",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, say 'Peter Piper picked a peck of pickled peppers' five times fast without a tongue twist or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, describe your first kiss or take {penalties} penalties",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, who's the hottest celebrity you know? Answer or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, who's the most famous person whose number you have? Answer or take {penalties} penalties",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
            template: "Each player sings Rihannas's song “Diamonds” one word at a time. The first person to freeze takes {penalties} penalties. {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "Each player sings Queens's song “Bohemian Rhapsody” one word at a time. The first person to freeze takes {penalties} penalties. {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "Each player sings The Weekend's song “Blinding Lights” one word at a time. The first person to freeze takes {penalties} penalties. {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "Each player sings Michael Jackson’s song “Billie Jean” one word at a time. The first person to freeze takes {penalties} penalties. {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, choose which player must take {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 5
        ),
        Task(
            template: "The player with the smallest foot takes {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "What scares you more: heights or tight spaces? Vote now! The minority takes {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, when was the last time you embarrassed yourself and how? Answer or take {penalties} penalties",
            pointsToScore: 2,
            baselinePenalty: 4
        ),
        Task(
            template: "{player1}, for the next 3 rounds you must communicate silently like Mr. Bean. If you fail or refuse, take {penalties} penalties",
            pointsToScore: 0,
            baselinePenalty: 6
        ),
        Task(
            template: "{player1}, you have 10 seconds to grab something red. If you fail, take {penalties} penalties",
            pointsToScore: 2,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, tell a funny fact or story about {player2}. If you can’t come up with anything, take {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, sing the first verse of “When Johnny Comes Marching Home” perfectly. Failure results in {penalties} penalties",
            pointsToScore: 3,
            baselinePenalty: 4
        ),
        Task(
            template: "{player1}, sing the first verse of Justin Bieber's Baby perfectly. Failure results in {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, say player {player2}’s full name. If you don’t know it, it’s time to take {penalties} penalties and get to know your teammate better",
            pointsToScore: 1,
            baselinePenalty: 2
        ),
        Task(
            template: "{player1}, make an assumption about {player2}. If you’re correct, they take {penalties} penalties. Otherwise you take {penalties} penalties yourself",
            pointsToScore: 2,
            baselinePenalty: 2
        ),
        Task(
            template: "Each player tells a joke in turn. If the joke doesn’t make anyone laugh, the person telling it takes {penalties} penalties. You have 15 seconds to prepare, {player1} starts",
            pointsToScore: 0,
            baselinePenalty: 4
        ),
        Task(
            template: "{player1}, what is {player2}’s birthday and birth year? If you guess correctly, they take {penalties} penalties. If you’re wrong, you take {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 2
        ),
        Task(
            template: "The player with the deepest voice takes {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 2
        ),
        Task(
            template: "{player1}, hum a 90s song of your choice. If the other players don't guess it within 10 seconds, take {penalties} penalties",
            pointsToScore: 1,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, you have 15 seconds to list the months in reverse order. If you fail, take {penalties} penalties",
            pointsToScore: 2,
            baselinePenalty: 2
        ),
        Task(
            template: "{player1} vs {player2}, compliment battle! Take turns complimenting each other. The first one to freeze takes {penalties} penalties. {player1} starts",
            pointsToScore: 3,
            baselinePenalty: 4
        )
    ]
    
}
