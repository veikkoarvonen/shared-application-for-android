//
//  Tier2FI.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 18.11.2025.
//

import Foundation

struct Tier2FITasks {
    
    static let tasks = [
        Task(
        template:"{player1}, Mikä on pisin aikasi pesemättä hampaita? Vastaa tai ota {penalties} rankaisevaa.",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "Pelaaja, jolla on paras peppu, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:            "Pelaaja, jolla on isoin hauis, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, et saa nauraa loppupelin ajan. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, kerro jokin harvinianen asia, jota olet tehnyt. Kaikki ketkä eivät ole tehneet kyseistä asiaa, ottavat {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, laita pelaajan {player2} sukat käsiisi loppupelin ajaksi tai ota {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 5
        ),
        Task(
        template:            "Jokainen pelaaja imitoi vauvan ääniä. Huonoiten suoriutunut ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, jos puhelimesi ruutuaika on suurempi kuin pelaajalla {player2}, ota {penalties} rankaisevaa. Muussa tapauksessa {player2} ottaa {penalties} rankaisevaa.",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player2}, kerro jokin mielenkiintoinen fakta. Kaikki ketkä eivät tienneet sitä, ottavat {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat, tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "Vesiputous! {player1} aloittaa. Edetkää vastapäivään",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, imitoi jotain vastapelaajista 10 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, haasta pelaaja {player2} peukalopainiin. Häviäjälle {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, keksi hauska lempinimi jokaiselle pelaajalle tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, halaa pelaajaa {player2} tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, kerro vitsi. Jos muut pelaajat eivät naura, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, niin monta punnerrusta kuin sinä teet, {player2} ottaa rankaisevia",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, tee 10 punnerrusta tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1} ja {player2}, tuijotuskilpailu!. Häviäjä ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, imitoi leijonaa 15 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 5
        ),
        Task(
        template:            "{player1}, anna pelaajan {player2} stailata hiuksesi loppu pelin ajaksi, tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, mikä on kiusallisin tilanne, johon olet joutunut? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, imitoi jotain julkkista kunnes muut pelaajat arvaavat ketä esität. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, mikä on suurin fantasiasi? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, kerro paras iskurepliikkisi, jos muut eivät pidä sitä hauskana, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 5
        ),
        Task(
        template:            "Jokainen pelaaja päästää vuorollaan oudon äänen. Kieltäytyjä ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, polvistu pelaajan {player2} eteen ja kosi häntä, tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, kehrää kuin kissa 5 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "Seuraava pelaaja, joka nauraa ensimmäisenä, ottaa {penalties} rankaisevaa!",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, mene nurkkaan häpeämään kolmen vuoron ajaksi",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, Kerro jokin petipuuhiin sopiva biisi tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, freestyle-räppää tästä illasta. Muut pelaajat ovat tuomaristo ja päättävät, selviätkö rangaistukselta {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, yritä nuolaista kyynärpäätäsi. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, mikä on penkkimaksimisi? Jaa {penalties} rankaisevaa jokaista kymmentä kiloa kohden",
        pointsToScore: 0,
        baselinePenalty: 1
        ),
        Task(
        template:            "{player1}, Telepatiahaaste! Yrittäkää sanoa pelaajan {player2} kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat {penalties} rankaisevaa. Kategoria: automerkki",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, anna paras Hessu Hopo -imitaatiosi tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, soita ilmakitaraa 15 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, saat puhua vain kuiskaten seuraavan 3 kierroksen ajan. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, yritä saada muut pelaajat nauramaan puhumatta. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, esitä vauvaa seuraavan 2 kierroksen ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:            "Jokainen pelaaja imitoi jotain eläintä vuorollaan. Huonoiten suoriutunut ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 5
        ),
        Task(
        template:            "{player1}, hyppää niin korkealle kuin pystyt. Jos muut pelaajat ovat vakuuttuneita, säästyt {penalties} rankaisevalta",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, mene lankku-asentoon minuutiksi. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, laula oopperaa 10 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, hyräile valitsemaasi biisiä. Jos muut pelaajat eivät 15 sekunnissa arvaa mikä kappale on kyseessä, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, mikä on kyykkymaksimisi? Jaa {penalties} rankaisevaa jokaista kymmentä kiloa kohden",
        pointsToScore: 0,
        baselinePenalty: 1
        ),
        Task(
        template:            "{player1}, jos sykkeesi on korkeampi kuin pelaajalla {player2}, ota {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, tee 5 kuperkeikkaa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1} ja {player2}, esittäkää dramaattinen erotilanne keskenänne tai ottakaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 6
        ),
        Task(
        template:            "{player1} vastaan {player2}! Kumpi tekee ensimmäisenä 5 kuperkeikkaa, voittaa. Häviäjä ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 5
        ),
        Task(
        template:            "{player1}, mau'u kissan lailla 10 sekunnin ajan tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, anna näytteesi Tarzanin ikonisesta viidakkohuudosta. Jos et vakuuta muita pelaajia, ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 5
        ),
        Task(
        template:            "Seuraava pelaaja, joka räpäyttää silmiään, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, ulvo suden lailla tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, nimeä 5 animesarjaa 10 sekunnissa tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "Vanhin pelaaja antaa nuorimalle pelaajalle mullistavan elämänohjeen, tai ottaa {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 5
        ),
        Task(
        template:            "Jokainen pelaaja kertoo pahimman tekonsa viimeisen viikon aikana. Suurin lurjus ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, pidä kasvosi peruslukemilla seuraavan kahden kierroksen ajan. Jokaista ilmeilyä kohden ota {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, kehu pelaajaa {player1} maasta taivaisiin! Jos saat hänet hymyilemään, säästyt {penalties} rankaisevalta. Jos hän punastuu, hän ottaa itse {penalties}",
        pointsToScore: 2,
        baselinePenalty: 5
        ),
        Task(
        template:            "Jokainen pelaaja esittelee itsensä hauskan faktan kera. Tylsimmän esittelyn esittäjä ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, pussaa omaa napaasi. Jos et onnistu, ota {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 3
        ),
        Task(
            template: "{player1}, kerro pelaajalle {player2} jotain, mitä haluaisit hänen tietävän tai ota {penalties} rankaisevaa",
            pointsToScore: 2,
            baselinePenalty: 3
        ),
        Task(
            template: "Jokainen pelaaja, joka on joskus estänyt exänsä somessa, ottaa {penalties} rankaisevaa",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "{player1}, kerro salaisuus, jota yksikään pelaaja ei vielä tiedä sinusta, tai ota {penalties} rankaisevaa",
            pointsToScore: 2,
            baselinePenalty: 4
        ),
        
        


    ]
    
}
