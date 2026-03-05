//
//  Tier3FI.swift
//  Juomapeli
//
//  Created by Valeria Rehokainen on 18.11.2025.
//

import Foundation

struct Tier3FITasks {
    
    static let tasks = [
        Task(
                template:"{player1}, Mikä on pisin aikasi ilman suihkua? Vastaa tai ota {penalties} rankaisevaa.",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "Voiko pettämisen antaa anteeksi? Äänestäkää! Vähemmistö ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "{player1}, nuolaise pelaajan {player2} napaa tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, suutele jokaisen pelaajan nenää tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, keksi eroottinen lempinimi jokaiselle pelaajalle tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, riisu pelaajan {player2} sukat hampaillasi tai ota {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 4
                ),
                Task(
                template:            "Antakaa vuorotellen poskisuudelma oikealla puolellanne istuvalle pelaajalle. Kieltäytyjälle {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, kuiskaa salaisuus pelaajalle {player2}. Jos hän ei reagoi mitenkään, ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, mikä on suurin fantasiasi? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, puhu kolmen kierroksen ajan ilman, että huulesi koskettavat. Jos epäonnistut, ota {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, päätä, kuka pelaajista ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "{player1}, sulje silmät ja ojenna etusormesi. {player2} laittaa valitsemansa kehonosansa sormeasi vasten. Jos arvaat, mikä ruumiinosa on kyseessä, säästyt {penalties} rankaisevalta",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "Jokainen pelaaja voihkaisee kerran. {player1} aloittaa. Kieltäytyjä ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, anna 30 sekunnin jalkahieronta pelaajalle {player2} tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, ota {penalties} rankaisevaa tai poskiläimäisy pelaajalta {player2}",
                pointsToScore: 3,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, laita seuraavat ruumiinosat viehättävyysjärjestykseen: kainalot, varpaat, korvat",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, niin monta punnerrusta kuin sinä teet, {player2} ottaa rankaisevia",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, röyhtäise tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, jos sinun pitäisi harrastaa roolileikkiä pelaajan {player2} kanssa, miksi pukeutuisitte? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, Oletko ihastunut kehenkään tällä hetkellä? Vastaa tai ota {penalties} rankaisevaa.",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, Oletko ikinä syönyt räkää? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, tee 10 punnerrusta tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, näytä viimeisin kuva puhelimesi ”Kätketyt” -albumista tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, ota paita pois loppupelin ajaksi tai {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, näytä parhaimmat tanssiliikkeesi seuraavan 15 sekunnin ajan tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 6
                ),
                Task(
                template:            "Jokainen pelaaja laulaa sana kerrallaan Irwin Goodmanin kappaletta Ei tippa tapa. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "Jokainen pelaaja laulaa sana kerrallaan PMMP:n kappaletta Rusketusraidat. Se, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1} ja {player2}, pitäkää toisianne kädestä kiinni loppupelin ajan. Jos kätenne irtoaa kesken pelin, ottakaa molemmat {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, näytä seksikkäin ilme jonka osaat tehdä tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, freestyle-räppää aiheesta: 'Olen rakastunut pelaajaan {player2}' tai ota {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 5
                ),
                Task(
                template:            "{player1}, riisu valitsemasi vaatekappale tai ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, leikkaa saksilla pieni pala hiuksiasi tai ota {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, voihkaise aina ennen rankaisevaa loppupelin ajan. Aina unohtaessasi ota  {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "{player1}, mikä on kiusallisin tilanne treffeillä, johon olet joutunut? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, paras kehonosa vastakkaisella sukupuolella? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, anna pelaajan {player2} kutittaa sinua 10 sekunnin ajan. Jos naurat, ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, flirttaile niin monella kielellä jotain järkevää kuin osaat. Jokaista kieltä kohden muut ottavat {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "{player1}, istu pelaajan {player2} syliin kolmen vuoron ajaksi. Kieltäytyjälle {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "Ota {penalties} rankaisevaa, jos voisit harrastaa seksiä jonkun huoneessa olevan pelaajan kanssa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, vastaa kaikkeen ”kyllä” seuraavan minuutin ajan tai ota 5 rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 5
                ),
                Task(
                template:            "{player1}, montaako ihmistä olet suudellut? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, oletko omasta mielestäsi hyvä sängyssä? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, mikä on isoin asia, josta olet valehdellut?? Vastaa tai ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, näytä ahegao-ilmeesi tai ota {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 5
                ),
                Task(
                template:            "Jokainen pelaaja esittelee itsensä mahdollisimman seksikkäästi. Kieltäytyjä/alisuoriutuja ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1} ja {player2}, vaihtakaa vaatteet keskenänne loppupelin ajaksi (alkkareita lukuunottamatta). Kieltäytyjä ottaa 7 rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 7
                ),
                Task(
                template:            "Jokainen pelaaja nimeää vuorollaan jonkin seksilelun tai -välineen. Pelaaja, joka jäätyy ensimmäisenä, ottaa {penalties} rankaisevaa. {player1} aloittaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, haista pelaajan {player2} korvia tai ota {penalties} rankaisevaa",
                pointsToScore: 3,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, vaihda paitaa pelaajan {player2} kanssa. Kieltäytymisestä {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, pomputa rintalihaksiasi yhteensä 10 kertaa. Jos et osaa, ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, haista vuorotellen jokaisen pelaajan kaulaa. Pelaaja, joka tuoksuu mielestäsi parhaimmalta, ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1} ja {player2}, tehkää yhdessä jooga-asento Vene (Navasana). Jos epäonnistutte, ottakaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, ota {player2} reppuselkään loppupelin ajaksi. Kieltäytymisestä {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, ota {player2} syliin loppupelin ajaksi. Kieltäytymisestä {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, sulje silmät. {player2} laittaa valitsemansa sormen suuhusi. Jos arvaat mikä sormi on kyseessä, säästyt {penalties} rankaisevalta",
                pointsToScore: 3,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, esitä raivostunutta 15 sekunnin ajan. Jos suoriudut muiden mielestä hyvin, säästyt {penalties} rankaisevalta",
                pointsToScore: 4,
                baselinePenalty: 5
                ),
                Task(
                template:            "{player1} ja {player2}, halatkaa toisianne loppupelin ajan niin, että vatsanne ovat jatkuvassa kosketuksessa. Epäonnistumisesta {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 5
                ),
                Task(
                template:            "{player1}, esitä känniläistä 15 sekuntia tai ota {penalties} rankaisevaa",
                pointsToScore: 4,
                baselinePenalty: 5
                ),
                Task(
                template:            "{player1}, kerro nolo muisto. Jos muut pelaajat eivät pidä sitä nolona, ota {penalties} rankaisevaa",
                pointsToScore: 2,
                baselinePenalty: 3
                ),
                Task(
                template:            "Kaikki sinkut ottavat {penalties} rankaisevaa, tai suutelevat samaa sukupuolta olevan pelaajan kanssa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "{player1}, laita soimaan valitsemasi biisi. Jos joku pelaajista ei tykkää biisistä, ota {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, pidätä hengitystäsi 30 sekuntia. Jos epäonnistut, ota {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, kerro paras setämies-vitsisi. Jos muut ei naura, ota {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "Jokainen pelaaja kertoo pahimman tekemänsä rikoksen. Pahin rikollinen ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 4
                ),
                Task(
                template:            "Heteroin pelaaja ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "{player1}, laita valitsemasi biisi soimaan. Jos se ei saa ketään pelaajaa nauramaan, ota {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "Eniten työttömältä näyttävä pelaaja ottaa {penalties} rankaisevaa. Äänestäkää riitatilanteen sattuessa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, jos sinulla on tatuointeja, näytä niistä yksi ja ota {penalties} rankaisevaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "Jokainen itsensä feministiksi luokitteleva pelaaja ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
                Task(
                template:            "Jokainen pelaaja puhuu ja käyttäytyy tästedes kuin mitä kohteliain hienohelma. Ensimmäinen etikettiä rikkova törkysuu ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "Jokainen pelaaja esittää tästedes liioitellusti vastakkaisen sukupuolen edustajaa. Pelaaja, jolla menee ensimmäisenä maku ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, saat puhua vain englantia loppupelin ajan. Ota tästedes {penalties} rankaisevaa jokaista muulla kielellä puhuttua toteamusta kohden",
                pointsToScore: 0,
                baselinePenalty: 3
                ),
                Task(
                template:            "{player1}, esitä että esiinnyt loppuunmyydyllä keikalla ja anna muille pelaajille ennennäkemätön 15 sekunnin show. Jos et saa pelaajilta aplodeja, ota {penalties} huikkaa",
                pointsToScore: 1,
                baselinePenalty: 3
                ),
                Task(
                template:            "Parhaimman hiusrajan omaava pelaaja ottaa {penalties} rankaisevaa",
                pointsToScore: 0,
                baselinePenalty: 2
                ),
              Task(template: "{player1}, taputa käsiäsi siihen tahtiin, missä tykkäät harrastaa seksiä tai juo {penaslties} huikkaa",
             pointsToScore: 2,
             baselinePenalty: 5),
        Task(
            template: "{player1}, kuinka kiimainen olet tällä hetkellä 1-10? Vastaa tai ota {penalties} rankaisevaa",
            pointsToScore: 2,
            baselinePenalty: 4
        ),
        Task(
            template: "Jokainen pelaaja, joka on joskus kokenut yhden yön jutun, ottaa {penalties} rankaisevaa",
            pointsToScore: 0,
            baselinePenalty: 3
        ),
        Task(
            template: "Jokainen pelaaja, joka on avoin avoimelle suhteelle, ottaa {penalties} rankaisevaa",
            pointsToScore: 0,
            baselinePenalty: 4
        ),
        Task(
            template: "{player1}, jos saisit harrastaa seksiä vain yhden henkilön kanssa loppuelämäsi ajan, kuka se olisi? Vastaa tai ota {penalties} rankaisevaa",
            pointsToScore: 2,
            baselinePenalty: 3
        ),
        

    ]
    
}
