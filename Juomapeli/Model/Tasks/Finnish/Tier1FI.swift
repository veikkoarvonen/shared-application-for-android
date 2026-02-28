//
//  Tier1FI.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 18.11.2025.
//

import Foundation

struct Tier1FITasks {
    
    static let tasks = [
        Task(
        template:"{player1}, nimeä viisi Jediritaria Tähtiensota-elokuvista tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, jos olisit peruna, tulisitko mieluummin kuorituksi vai keitetyksi? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "Jokainen pelaaja, joka on alle 180 cm pitkä, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, niin monta punnerrusta kuin sinä teet, {player2} ottaa rankaisevia",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, Telepatiahaaste! Yrittäkää sanoa pelaajan {player2} kanssa sama sana samaan aikaan. Jos epäonnistutte otatte molemmat {penalties} rankaisevaa. Kategoria: väri",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Kertokaa tarina sana kerrallaan. Pelaaja, joka jäätyy ensimmäisenä ottaa {penalties} rankaisevaa. Aloittakaa myötäpäivään pelaajasta {player1}",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, veikkaa, missä pisteessä jokainen pelaaja on seuraavan 5 vuoden päästä",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, nimeä 10 sekunnissa 5 maata jotka alkavat kirjaimella S tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, nimeä 7 Disney-prinsessaa 15 sekunnissa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, tee 10 punnerrusta tai ota {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, keksi jokaiselle pelaajalle uusi lempinimi",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, imitoi pelaajista valitsemaasi henkilöä niin pitkään, että joku arvaa ketä imitoit",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, kerro jokin paheesi tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, kuuluuko ananas pizzaan?, ota niin monta rankaisevaa kuin pelaajia on eri mieltä kanssasi",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, luettele suomalaisten aakkosten vokaalit takaperin. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, mainitse jokin hyvä ominaisuus pelaajassa {player2}",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, nimeä 4 James Bond -näyttelijää 10 sekunnissa. Epäonnistumisesta {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, puhu niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut ottavat {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1} päättää kategorian. Ensimmäinen joka ei osaa nimetä uutta asiaa, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, sano 5 kertaa putkeen ”mustan kissan paksut posket” ilman että kieli menee solmuun, tai ota 4 rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, sano 5 kertaa putkeen ”käki istui keskellä keskioksaa” ilman että kieli menee solmuun, tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, sano 5 kertaa putkeen ”yksikseskös yskiskelet, itsekseskös itkeskelet” ilman että kieli menee solmuun, tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, nimeä 10 NATO-maata 10:ssä sekunnissa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, nimeä 5 Suomen maakuntaa 10:ssä sekunnissa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, sano kaksi legendaarista one-lineria Terminator-elokuvasarjasta tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, keksi lempinimi jokaiselle pelaajalle",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, haasta {player2} kivi, paperi, sakset -peliin. Häviäjälle {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, imitoi jotain näyttelijää 10 sekunnin ajan. Jos muut eivät arvaa ketä esität, ota {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, Kerro jokin biisi, jota inhoat? Vastaa tai ota {penalties} rankaisevaa.",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "Vesiputous! {player1} aloittaa. Edetkää myötäpäivään",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, sano 5 kertaa putkeen ”Floridan broileri ja reilu litra maitoa” ilman että kieli menee solmuun, tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, Millainen oli ensisuudelmasi? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, Kuka on kuumin tietämäsi julkkis? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, Kuka on kuuluisin henkilö, kenen numero sinulla on? Vastaa tai ota {penalties} rankaisevaa.",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "Jokainen pelaaja laulaa sana kerrallaan kappaletta Minttu sekä Ville. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Jokainen pelaaja laulaa sana kerrallaan Mirellan kappaletta Timanttei. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Jokainen pelaaja laulaa sana kerrallaan Kasmirin kappaletta Vadelmavene. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Jokainen pelaaja laulaa sana kerrallaan Käärijän kappaletta Cha Cha Cha. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Jokainen pelaaja laulaa sana kerrallaan JVG:n kappaletta Ikuinen vappu. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, päätä, kuka pelaajista ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 5
        ),
        Task(
        template:            "Pelaaja, jolla on pienin jalka, ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "Pelkäätkö enemmän korkeita vai ahtaita paikkoja? Äänestäkää! Vähemmistö ottaa {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, milloin viimeksi nolasit itsesi ja miten? Vastaa tai ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, seuraavan 3 kierroksen ajan et saa puhua, vaan joudut esittämään asiasi äänettömästi Mr. Beanin tyyliin. Jos epäonnistut tai kieltäydyt, {penalties} rankaisevaa",
        pointsToScore: 0,
        baselinePenalty: 6
        ),
        Task(
        template:            "{player1}, sinulla on 10 sekuntia aikaa ottaa käteesi jokin punainen esine. Jos epäonnistut, ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, kerro hauska fakta tai tarina pelaajasta {player2}. Jos et keksi mitään, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, laula Suvivirren ensimmäinen säkeistö virheettömästi. Epäonnistumisesta {penalties} rankaisevaa",
        pointsToScore: 3,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, laula Maamme-laulun ensimmäinen säkeistö virheettömästi. Epäonnistumisesta {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "{player1}, sano pelaajan {player2} kokonimi. Jos et tiedä sitä, on aika ottaa {penalties} rankaisevaa ja tutustua pelitoveriisi paremmin",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
        template:            "{player1}, tee jokin olettamus pelaajasta {player2}. Jos osut oikeaan, hän ottaa {penalties} rankaisevaa. Muuten otat itse {penalties}",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
        template:            "Jokainen pelaaja kertoo vuorollaan vitsin. Jos vitsi ei naurata, ottaa sen kertoja {penalties} rankaisevaa. Saatte 15 sekuntia aikaa valmistautua, {player1} aloittaa",
        pointsToScore: 0,
        baselinePenalty: 4
        ),
        Task(
        template:            "{player1}, mikä on pelaajan {player2} syntymäpäivä ja -vuosi? Jos arvaat oikein, hän ottaa {penalties} rankaisevaa. Jos väärin, otat itse {penalties}",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
        template:            "Pelaaja jolla on matalin ääni ottaa {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 2
        ),
        Task(
            template:            "{player1}, hyräile valitsemaasi 90-luvun biisiä. Jos muut pelaajat eivät 10 sekunnissa arvaa mitä hyräilet, ota {penalties} rankaisevaa",
        pointsToScore: 1,
        baselinePenalty: 3
        ),
        Task(
            template:            "{player1}, sinulla on 15 sekuntia aikaa luetella kuukaudet takaperin. Epäonnistuessasi ota {penalties} rankaisevaa",
        pointsToScore: 2,
        baselinePenalty: 2
        ),
        Task(
            template: "{player1} vs {player2}, kehumiskilpailu! Kehukaa toisianne vuorotellen. Ensimmäinen joka jäätyy ottaa {penalties} rankaisevaa. {player1} aloittaa",
            pointsToScore: 3,
            baselinePenalty: 4
        )
    ]
    
}
