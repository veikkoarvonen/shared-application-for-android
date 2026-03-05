//
//  Constants.swift
//  Juomapeli
//
//  Created by Veikko Arvonen on 1.7.2024.
//

import UIKit
import StoreKit

struct C {
    static let playerCell = "TableViewCell"
    static let playerNib = "tableViewCell"
    static let gamemodeCell = "GameModeCell"
    static let gamemodeNIb = "gameModeCell"
    static let playerTextCell = "TableViewTextCell"
    static let playerTextNib = "tableViewTextCell"
    
    static let purple = "brandPurple"
    static let blue = "brandBlue"
    static let dateColor = "dateMode"
    static let teamColor = "teamMode"
    static let explainColor = "explainMode"
    
    static let wordGameFont = "EricaOne-Regular"
    
    static let debugApp = true
    static let testUIWithColors = false
    static let useDebugTasks = false
    
    
}

//Data for tableView cells in GameSelect VC. Just copy & paste strings and leave the tableView cell size the same
struct Cells {
    static let images: [UIImage] = [
        UIImage(named: "basic")!,
        UIImage(named: "treffit")!,
        UIImage(named: "taisto")!,
        UIImage(named: "extreme")!,
        UIImage(named: "selita")!
    ]
    static let headers: [String] = ["Peruspeli", "Treffit", "Extreme", "Selitä!"]
    static let paragraphs: [String] = [
        "Monipuolisia tehtäviä ja haasteita, jotka takaavat räväkän meiningin pysyen kuitenkin hyvän maun rajoissa... juuri ja juuri.",
        "Syvällisiä, hauskoja ja mielenkiintoisia kysymyksiä ja tehtäviä, joiden avulla varmasti tutustut seuralaiseesi - myös pintaa syvemmältä.",
        "VAROITUS: Ei nynnyille! Alla olevista mittareista voit itse valita pelin intensiteetin ja rangaistushuikkien määrän.                                           HUOM: Tehtävät vaativat pahimmillaan äärimmäistä heittäytymistä, joten peli sopii ainoastaan kovimmille bilehileille!",
        "Sanaselitys! Sinulla on minuutti aikaa selittää pelikaverillesi niin monta sanaa, kuin kerkeät. Jokaisesta oikeasta vastauksesta saatte pisteen."
    ]
}

//Data for settings in Finnish language. You can copy & paste strings
struct Settings {
    
    struct English {
        static let headers: [String] = ["About", "Responsive playing", "Plus-subscription", "Language"]
        
        static let sections: [[String]] = [
            ["Juhlapeli Cup homepage", "Privacy Policy", "Terms of user"],
            ["Remember to take care of yourself and your fellow players. This game is intended for entertainment purposes only, and no one should be forced to continue playing if they don't want to. We are not responsible for any damages or consequences that may arise from irresponsible play.","Learn more about responsive playing"],
            ["Restore Purchases"],
            ["🇫🇮 Suomi","🇬🇧 English"]
        ]
    }
    
    struct Finnish {
        static let headers: [String] = ["Tietoa", "Vastuullisuus", "Plus-tilaus", "Kieli"]
        
        static let sections: [[String]] = [
            ["Juhlapeli Cup kotisivut", "Tietosuojakäytäntö", "Käyttöehdot"],
            ["Muista pitää itsestäsi ja pelitovereistasi huolta. Kyseinen peli on tarkoitettu ainoastaan viihteelliseen käyttöön, eikä ketään tule pakottaa jatkamaan peliä, ellei halua. Emme vastaa mistään vahingoista tai seuraamuksista, jotka voivat aiheutua vastuuttomasta pelaamisesta.","Lue lisää vastuullisuudesta"],
            ["Palauta ostot"],
            ["🇫🇮 Suomi","🇬🇧 English"]
        ]
    }

}


struct Colors {
    static let colors: [UIColor] = [
        UIColor(red: 0/255.0, green: 74/255.0, blue: 173/255.0, alpha: 1.0),   // #004AAD
        UIColor(red: 255/255.0, green: 0/255.0, blue: 207/255.0, alpha: 1.0),  // #FF00CF
        UIColor(red: 0/255.0, green: 35/255.0, blue: 255/255.0, alpha: 1.0),   // #0023FF
        UIColor(red: 166/255.0, green: 17/255.0, blue: 48/255.0, alpha: 1.0),  // #A61130
        UIColor(red: 39/255.0, green: 112/255.0, blue: 30/255.0, alpha: 1.0),  // #27701E
        UIColor(red: 255/255.0, green: 0/255.0, blue: 184/255.0, alpha: 1.0),  //#FF00B8
        UIColor.red,
        UIColor.orange
    ]
}

struct UD {
    
    let purchasedProductIDs: String = "purchasedProductIDs"
    
    func addKey(key: String) {
        UserDefaults.standard.set(key, forKey: purchasedProductIDs)
    }
    
    func setPlusVersionStatus(purchased: Bool) {
        
    }
    
    func hasPurchasedPlusVersion() -> Bool {
        return false
    }
    
}

struct WordGame {
    static let startMessage = "Sanaselityspeli! Sinulla on minuutti aikaa selittää pelitoverillesi niin monta sanaa, kuin kerkeät. Jokaisesta oikeasta vastauksesta saatte pisteen."
    
    static let startMessageEN = "Explain! You have 60 seconds to explain as many words as possible to your peer. Every correct answer gives you a point."
    
    //List of Finnish words to explain is here. You can copy & paste the array and leave content as it is
    
    static let words: [String] = ["Paavo Pesusieni", "Ikkuna", "Mike Tyson", "Petteri Orpo", "Riikka Purra", "Sanna Marin", "Kynttilä", "Yhdyntä", "Varvas", "Kynsilakka", "Huulet",
                                  "Pakara", "G-piste", "Etanoli", "Avatar", "Michael Jakcson", "Kondomi",
                                  "Soihtu", "Nuotti", "Kurkku", "Audi", "Oksennus", "Aakkoset", "Verhot",
                                  "Neitsyt Maria", "Palapeli", "Ahven", "Mato", "Ruuvimeisseli", "Kauhuelokuva",
                                  "Reissumies", "Kainalo", "Rautatieasema", "Taksi", "Yökerho", "Pizza",
                                  "Tatuointi", "Nuuska", "Kirkko", "Limusiini", "Sulkapallo", "Poninhäntä",
                                  "Nokia", "Muumipappa", "Homejuusto", "Poliisi", "Puumaja", "Pikkuhousut",
                                  "Roskakatos", "Nänni", "Kivi", "Puuhöylä", "Hiustenkuivaaja", "Ripsiväri",
                                  "Sex on the beach", "Karhu", "Karttakeppi", "Sukkahousut", "Välimeri",
                                  "Jean Sibelius", "Pururata", "Hammasraudat", "Henkselit", "Kebab",
                                  "Huumekoira", "Heroiini", "Nappikuulokkeet", "Napapiiri", "Revontulet",
                                  "Särkylääke", "Ananas", "Pahvilaatikko", "Vessapaperi", "Mukulakivi",
                                  "Makaronilaatikko", "Hammasharja", "Suihku", "Vesiputous", "Pantteri",
                                  "Kirosana", "Valokatkaisija", "Sanomalehti", "Koivu", "Ranskalaiset",
                                  "Mökki", "Laituri", "Suolavesi", "Sarvikuono", "Merirosvo", "Merenneito",
                                  "Olut", "Tiskirätti", "Tuhkimo", "Walt Disney", "Hissi", "Kerrostalo",
                                  "Puuseppä", "Leppäkerttu", "Yöperhonen", "Peruukki", "Kiuas", "Höyrysauna",
                                  "Sumu", "Krapula", "Väinämöinen", "Parsakaali", "Apina", "Kinkku",
                                  "Tarzan", "Pinokkio", "Sähkökitara", "Strippari", "Pöllö", "Tuhatjalkainen",
                                  "Pupilli", "Pilli", "Rusketusraidat", "Punaviini", "Lumilauta", "Lumiukko",
                                  "Punahilkka", "Rintaliivit", "Hiekkalinna", "Lonkero", "Hampurilainen",
                                  "Passi", "Emoji", "Rengas", "Sormus", "Vesimeloni", "Hunaja", "Nalle Puh",
                                  "Konsertti", "Korsetti", "Rusetti", "Kravaatti", "Pulu", "Kuukävely",
                                  "Astronautti", "Kolmio", "Sisilisko", "Taikina", "Rakko", "Käpy",
                                  "Helikopteri", "Liitovarjo", "Kieli", "Teräsmies", "Hämähäkkimies",
                                  "Lepakkomies", "Panda", "Korvakäytävä", "Sierain", "Hajuhaitta",
                                  "Patteri", "Faksi", "Kirjoituskone", "Imuri", "Kaulapanta", "Sähkötuoli",
                                  "Kantapää", "Kosteusvoide", "Huulikiilto", "Kirsikka", "Erektio", "Euro",
                                  "Käteinen", "Aalto", "Surffilauta", "Kallio", "Nukke", "Peili",
                                  "Alushousut", "Kameli", "Nikotiini", "Ekstaasi", "Tuuletin", "Amsterdam",
                                  "Quasimodo", "Pokaali", "Palli", "Puhelinluettelo", "Lankapuhelin",
                                  "Kuperkeikka", "Pelikaani", "Manga", "Varjo", "Saapas", "Herkkutatti",
                                  "Sademetsä", "Viidakko", "Betoni", "Kevytmoottoripyörä", "Kangastus",
                                  "Navetta", "Traktori", "Maito", "Kapteeni Koukku", "Peter Pan", "Spagetti",
                                  "Tusina", "Kuiskata", "Voihkia", "Potkaista", "Pipo", "Onkivapa", "Hiki",
                                  "Hyppynaru", "Levypaino", "Vaaka", "Akaa", "Linna", "Keitto", "Luontoäiti",
                                  "Simpukkapuhelin", "Savupiippu", "Takka", "Korttipakka", "Jokeri", "Sirkus",
                                  "Raitapaita", "Rosvo", "Mannapuuro", "Mörkö", "Riippumatto", "Luomiväri",
                                  "Kummitus", "Muikku", "Deja Vu", "Vesi", "Maa", "Tuli", "Ilma", "Rapu",
                                  "Saippuakauppias", "Hyppykeppi", "Pingispallo", "Sähkökatkos", "Uros",
                                  "Naaras", "Taputtaa", "Viitta", "Nenäliina", "Naamio", "Aivot",
                                  "Ylioppilas", "Velho", "Keiju", "Lankakerä", "Silinteri", "Puu", "Uni",
                                  "Pulla", "Taapero", "Potkulauta", "Asfaltti", "Pohje", "Perunamuussi",
                                  "Laama", "Lihapulla", "Junarata", "Vuoristorata", "Päärynä", "Nurkka",
                                  "Matto", "Kangaskassi", "Sänki", "Munuainen", "Keltuainen", "Ovikello",
                                  "Vara-avain", "Roskakatos", "Kaakao", "Toive", "Tappio", "Kylä",
                                  "Hölkätä", "Krusifiksi", "Patsas", "Aarrearkku", "Matkalaukku", "Härkä",
                                  "Kultakala", "Nuotio", "Elastinen", "Nuppineula", "Klemmari", "Biljardi",
                                  "Sielu", "Kassakaappi", "Laina", "Munasuojat", "Vedenkeitin", "Hella",
                                  "Korvakoru", "Siima", "Sima", "Häntä", "Vetoketju", "Verisuoni",
                                  "Varashälytin", "Majakka", "Satiiri", "Safiiri", "Tuoppi", "Jakkara",
                                  "Ukki", "Monokkeli", "Valtikka", "Tikkataulu", "Vastaväri", "Keskiaika",
                                  "Evoluutio", "Harava", "Kiipeilyteline", "Keinu", "Kiikkutuoli",
                                  "Pippuri", "Ilmalaiva", "Koulu", "Moottoritie", "Kylpyamme",
                                  "Astianpesukone", "Amiraali", "Aikataulu", "Aapinen", "Kaamos", "Sorsa",
                                  "Lepakko", "Koala", "Pahkasika", "Koppakuoriainen", "Hummeri", "Oranki",
                                  "Peura", "Siipi", "Majava", "Laiskiainen", "Haisunäätä", "Kaktus", "Ruusu",
                                  "Suppilovahvero", "Lampaankääpä", "Sateenkaari", "Saippuakupla", "Pisara",
                                  "Pyörremyrsky", "Lumihiutale", "Sormenjälki", "Rusina", "Avokado",
                                  "Paprika", "Juusto", "Maissi", "Inkivääri", "Porkkana", "Pähkinä",
                                  "Aivopähkinä", "Tuttipullo", "Viinilasi", "Lentopallo", "Jojo", "Bumerangi",
                                  "Liukumäki", "Leija", "Uimahalli", "Vene", "Jooga", "Teatteri", "Skootteri",
                                  "Mopo", "Poliisiauto", "Satelliitti", "Linnunrata", "Galaksi", "Ankkuri",
                                  "Vapaudenpatsas", "Kartta", "Karuselli", "Tulivuori", "Suihkulähde",
                                  "Toivomuskaivo", "Naapurusto", "Filmi", "Käkikello", "Herätyskello",
                                  "Timantti", "Jalokivi", "Jakoavain", "Mutteri", "Maitohammas", "Dynamiitti",
                                  "Rokote", "Piñata", "Viuhka", "Diskopallo", "Kirje", "Pulloposti",
                                  "Tussi", "Kuulakärkikynä", "Megafoni", "Spotify", "Puhekupla", "Sarjakuva",
                                  "Villasukka", "Sensei", "Erämaa", "Metsä", "Turvakaide", "Heijastin",
                                  "Kaurapuuro", "Riisipuuro", "Karjalanpiirakka", "Munkki", "Torttu",
                                  "Korvapuusti", "Mysli", "Pehmeä", "Karvainen", "Sääri", "Keihäs",
                                  "Leuanvetotanko", "Alennus", "Kapea", "Arvata", "Tietokirja", "Pensseli",
                                  "Sivellin", "Taiteilija", "Mustelma", "Nuudeli", "Puhe", "Kiire", "Virne",
                                  "Hernekeitto", "Pannulakku", "Lettu", "Sudenkorento", "Ihmissusi",
                                  "Peikko", "Heikko", "Kevennys", "Selaushistoria", "Albumi", "Sinkku",
                                  "Hammastikku", "Levä", "Hai", "Sammal", "Allas", "Lelu", "Lego", "Leveä",
                                  "Penni", "Autiotalo", "Erakko", "Luola", "Hakku", "Kirves", "Kuokka",
                                  "Kurpitsa", "Ontto", "Motto", "Sananlasku", "Hokema", "Hikka", "Punajuuri",
                                  "Trubaduuri", "Haarniska", "Meduusa", "Seireeni", "Syömäpuikko", "Paasto",
                                  "Viikonloppu", "Liima", "Ilmastointiteippi", "Lukko", "Sombrero",
                                  "Eliitti", "Etana", "Kuohukerma", "Kastemato", "Kuukivi", "Neliapila",
                                  "Kartonki", "Kuopus", "Serkku", "Vävy", "Aamuyö", "Marsu", "Paahtoleipä",
                                  "Leivänpaahdin", "Uuni", "Tiskiallas", "Pallomeri", "Verkko", "Katua",
                                  "Latu", "Maanjäristys", "Tuulenpuuska", "Pokkari", "Sokka", "Multa",
                                  "Pronssi", "Adjektiivi", "Verbi", "Homonyymi", "Maailmanennätys", "Putki",
                                  "Lumpeenlehti", "Sammakko", "Joutsen", "Ankka", "Sorsa", "Metsästäjä",
                                  "Shakki", "Pokeri", "Revolveri", "Valveuni", "Lautanen", "Aurinkolasit",
                                  "Kampa", "Aataminomena", "Kuningaskunta", "Narri", "Talonpoika", "Pelto",
                                  "Nukka", "Turkki", "Neandertalilainen", "Purkka", "Introvertti",
                                  "Ekstrovertti", "Motivaatio", "Lävistys", "Viski", "Pomppulinna",
                                  "Robin Hood", "Säkkituoli", "Säkkipilli", "Kiltti", "Steppikengät",
                                  "Noppa", "Lautapeli", "Elehtiä", "Vertaistuki", "Rotta", "Huppu", "Lumi",
                                  "Marilyn Monroe", "Daltonin veljekset", "Kleopatra", "Elvis Presley",
                                  "Beethoven", "Hevosenkenkä", "Joukahainen", "Lemminkäinen", "Perinne",
                                  "Umpikuja", "Jäävuori", "Marakassi", "Triangeli", "Toukka", "Nappi",
                                  "Niska", "Jänne", "Viivoitin", "Mikki Hiiri", "Uimapuku", "Nilkka",
                                  "Heureka", "Kenguru", "Pesäpallo", "Mikroaaltouuni", "Mulletti",
                                  "Abiturientti", "Magneetti", "Lupa", "Reikä", "Kaakeli", "Kaukosäädin",
                                  "Super Mario", "Sukeltaja", "Tulkki", "Jälki", "Kuhmu", "Kypärä", "Myssy",
                                  "Lyhty", "Sandaali", "Pirtelö", "Kuplamuovi", "Sukulainen", "Paimen",
                                  "Lappi", "Luunappi", "Ravintola", "Herra", "Rouva", "Nälkäkiukku", "Piilo",
                                  "Taskumatti", "Vesirokko", "Juoksuhiekka", "Pannu", "Kattila", "Valhe",
                                  "Eiffel-torni", "Pyramidi", "Norsu", "Sähköjohto", "Vyö", "Tanko",
                                  "Roskakori", "Pyykkikori", "Agentti", "Manageri", "Kuoro", "Orkesteri",
                                  "Moka", "Säikähtää", "Huutaa", "Kuumemittari", "Hame", "Kirjanmerkki",
                                  "Lippu", "Kipinä", "Avaimenperä", "Taskulamppu", "Soihtu", "Kirous",
                                  "Sadetanssi", "Sadepilvi", "Saari", "Kaapu", "Polkupyörä", "Sälekaihtimet",
                                  "Sinisilmäinen", "Kapellimestari", "Hieroja", "Miekka", "Viidakkoveitsi",
                                  "Appelsiini", "Sitruuna", "Noitarumpu", "Iglu", "Muuttoauto", "Muutto",
                                  "Karkki", "Suklaa", "Joulukuusi", "Pääsiäismuna", "Juhannuskokko",
                                  "Ilotulitus", "Afro", "Juice Leskinen", "Dingo", "Yhtye", "Vieteri",
                                  "Pelko", "Vaippa", "Sukkula", "Jono", "Lätäkkö", "Finni", "Puutarha",
                                  "Studio", "Virtahepo", "Pasila", "Kukkakimppu", "Balladi", "Huhu",
                                  "Puskaradio", "Taulu", "Säästöpossu", "Munakas", "Nyrkkeilyhanska",
                                  "Siemen", "Vitsi", "Kalteri", "Metro", "Mars", "Meteoriitti", "Saareke",
                                  "Kilpailu", "Muurahainen", "Banjo", "Basso", "Tikkari", "Rinkeli",
                                  "Mustavalkoinen", "Kyynel", "Sattuma", "Kapula", "Leipä", "Kauluspaita",
                                  "Toppi", "Moppi", "Räpylä", "Pensas", "Varasto", "Vessaharja", "Prosentti",
                                  "Pilvi", "Kipsi", "Kaijutin", "Neula", "Paljas", "Kruunu", "Ryömiä",
                                  "Punnerrus", "Panttivanki", "Kompakysymys", "Laulu", "Hymykuoppa",
                                  "Irokeesi", "Karata", "Karate", "Puhdistaa", "Korjata", "Kellua",
                                  "Mököttää", "Kalju", "Kalja", "Suolakurkku", "Lahja", "Yllätys",
                                  "Kaukoputki", "Kursori",
                                  "Puhelu", "Riita", "Kumartaa", "Niiata", "Närästys", "Maapallo", "Nimipäivä",
                                  "Labyrintti", "Laukku", "Kiina", "Saksa", "Italia", "Ranska", "Perna",
                                  "Maksa", "Munuainen", "Sydän", "Haima", "Refleksi", "Heijastus", "Kirkas",
                                  "Viheltää", "Terälehti", "Komeetta", "Kuumemittari", "Celsius", "Tynnyri",
                                  "Turku", "Espoo", "Vantaa", "Helsinki", "Tampere", "Oulu", "Lahti",
                                  "Keskijakaus", "Vapaapäivä", "Nukkua", "Yövalo", "Trampoliini", "Vaimo",
                                  "Normaali", "Spiraali", "Piruetti", "Kipu", "Nielaista", "Mieliala",
                                  "Kokaiini", "Ämpäri", "Tähdenlento", "Selli", "Jyväskylä", "Askel",
                                  "Graffiti", "Paperihaava", "Suuttua", "Kukkakaali", "New York", "Kärpänen",
                                  "Kummi", "Vuosisata", "Ruokamyrkytys", "Ramppi", "Kompastua", "Jarru",
                                  "Leka", "Häkki", "Poseeraus", "Alamainen", "Liivi", "Hiipiä", "Kurki",
                                  "Bambu", "CD-levy", "Deodorantti", "Hajuvesi", "Hammastahna", "VHS-kasetti",
                                  "Torni", "Pori", "Poro", "Hirvi", "Heinäsirkka", "Saapasjalkakissa",
                                  "Elokuva", "Uutinen", "Karjua", "Aivastaa", "Lammas", "Matrix", "Hirviö",
                                  "Adrenaliini", "Dopamiini", "Estrogeeni", "Testosteroni", "Silmälappu",
                                  "Laava", "Laastari", "Dollari", "Almu", "Satu", "Kehä", "Pula", "Rivi",
                                  "Jono", "Hapan", "Ansa", "Yhteiskunta", "Organismi", "Tuomio", "Pistorasia",
                                  "Jakorasia", "Äidinkieli", "Liikunta", "Musiikki", "Näyttelijä", "Unelma",
                                  "Rikas", "Konvehti", "Marmeladi", "Hillo", "Alasin", "Ilmasto", "Tilasto",
                                  "Raportti", "Portti", "Ovi", "Kuorsata", "Huomata", "Nyökätä", "Syyttää",
                                  "Suppilauta", "Voltti", "Venytellä", "Haistaa", "Maistaa", "Kiusallinen",
                                  "Kalkkuna", "Katkarapu", "Lähikauppa", "Crash Bandicoot", "Hymy", "Vaahto",
                                  "Chuck Norris", "Martin Luther King Jr", "Huutomerkki", "Kysymysmerkki",
                                  "Kaksoispiste", "Manikyyri", "Pehmuste", "Muste", "Prinssi", "Prinsessa",
                                  "Aavikko", "Korppikotka", "Hapankorppu", "Näkkileipä", "Strutsi", "Muna",
                                  "Turbulenssi", "Kerroshampurilainen", "Monologi", "Ajatella", "Tanssia",
                                  "Transsi", "Pasianssi", "Pata", "Pelastusrengas", "Oksa", "Ryppy", "Sana",
                                  "Sanaton"]
    
    static let wordsEN: [String] = [
        "Spongebob", "Window", "Mike Tyson", "Elon Musk", "Shakira", "Jennifer Lopez", "Candle", "Sex",
        "Toe", "Nail polish", "Lips", "Butt cheek", "Ethanol", "Avatar", "Michael Jackson", "Condom",
        "Torch", "Notebook", "Cucumber", "Audi", "Vomit", "Alphabet", "Curtains", "Virgin Mary", "Puzzle",
        "Perch", "Worm", "Screwdriver", "Horror movie", "Traveling man", "Armpit", "Train station", "Taxi",
        "Nightclub", "Pizza", "Tattoo", "Church", "Limousine", "Badminton", "Ponytail", "Nokia", "Blue cheese",
        "Police", "Treehouse", "Panties", "Trash shelter", "Nipple", "The Rock", "Woody", "Hairdryer", "Mascara",
        "Sex on the Beach", "Bear", "Pointer stick", "Pantyhose", "Mediterranean", "Jean Sibelius", "Forest track",
        "Braces", "Suspenders", "Kebab", "Puppy", "Heroin", "Earbuds", "Northern Lights", "Painkiller", "Pineapple",
        "Cardboard box", "Toilet paper", "Cobblestone", "Macaroni casserole", "Toothbrush", "Shower", "Waterfall",
        "Panther", "Swear word", "Light switch", "Newspaper", "Birch", "French fries", "Cottage", "Pier", "Saltwater",
        "Rhinoceros", "Pirate", "Mermaid", "Beer", "Dishcloth", "Cinderella", "Walt Disney", "Elevator", "Apartment building",
        "Carpenter", "Ladybug", "Moth", "Wig", "Fog", "Hangover", "Amor", "Broccoli", "Monkey", "Ham", "Tarzan", "Pinocchio",
        "Electric guitar", "Stripper", "Owl", "Centipede", "Pupil", "Whistle", "Tan lines", "Red wine", "Snowboard",
        "Snowman", "Little Red Riding Hood", "Bra", "Sandcastle", "Hamburger", "Passport", "Emoji", "Tire", "Ring",
        "Watermelon", "Honey", "Winnie the Pooh", "Concert", "Corset", "Bowtie", "Pigeon", "Moonwalk", "Astronaut",
        "Triangle", "Lizard", "Dough", "Blister", "Pinecone", "Helicopter", "Paraglider", "Tongue", "Superman", "Spiderman",
        "Batman", "Panda", "Ear canal", "Nostril", "Bad smell", "Radiator", "Fax", "Typewriter", "Vacuum cleaner", "Collar",
        "Electric chair", "Heel", "Moisturizer", "Lip gloss", "Cherry", "Erection", "Euro", "Cash", "Wave", "Surfboard", "Cliff",
        "Doll", "Mirror", "Underpants", "Camel", "Nicotine", "Ecstasy", "Fan", "Amsterdam", "Quasimodo", "Trophy", "Testicle",
        "Phone book", "Landline", "Somersault", "Pelican", "Manga", "Shadow", "Boot", "Porcini", "Rainforest", "Jungle",
        "Concrete", "Moped", "Mirage", "Barn", "Tractor", "Milk", "Captain Hook", "Peter Pan", "Spaghetti", "Dozen", "Whisper",
        "Moan", "Kick", "Beanie", "Sweaty", "Stinky", "Jump rope", "Barbell", "Scale", "Castle", "Soup", "Mother Nature",
        "Flip phone", "Chimney", "Fireplace", "Deck of cards", "Joker", "Circus", "Striped shirt", "Robber", "Semolina porridge",
        "Monster", "Hammock", "Eyeshadow", "Ghost", "Vendace", "Deja Vu", "Water", "Earth", "Fire", "Air", "Crab", "Soap seller",
        "Pogo stick", "Power outage", "Male", "Female", "Clap", "Cape", "Tissue", "Mask", "Brain", "Graduate", "Wizard", "Tree",
        "Dream", "Bun", "Toddler", "Scooter", "Asphalt", "Calf (leg)", "Mashed potatoes", "Llama", "Meatball", "Railroad",
        "Roller coaster", "Pear", "Corner", "Rug", "Fabric bag", "Stubble", "Kidney", "Yolk", "Doorbell", "Spare key", "Trash shelter",
        "Cocoa", "Wish", "Defeat", "Village", "Jog", "Crucifix", "Statue", "Treasure", "Suitcase", "Bull", "Goldfish", "Campfire",
        "Snoop Dogg", "Pin", "Paperclip", "Billiards", "Soul", "Safe", "Loan", "Cup protector", "Electric kettle", "Stove",
        "Earring", "Fishing line", "Mead", "Tail", "Zipper", "Blood vessel", "Lighthouse", "Satire", "Sapphire", "Beer", "Stool",
        "Grandpa", "Monocle", "Scepter", "Dartboard", "Middle Ages", "Evolution", "Rake", "Climbing frame", "Swing", "Pepper",
        "Airship", "School", "Highway", "Bathtub", "Dishwasher", "Admiral", "Timetable", "ABC book", "Polar night", "Duck",
        "Bat", "Koala", "Warthog", "Beetle", "Lobster", "Orangutan", "Deer", "Wing", "Beaver", "Sloth", "Skunk", "Cactus",
        "Rose", "Rainbow", "Soap", "Drop", "Tornado", "Snowflake", "Fingerprint", "Raisin", "Avocado", "Cheese", "Corn", "Ginger",
        "Carrot", "Nut", "Baby bottle", "Wine glass", "Volleyball", "Yo-yo", "Boomerang", "Slide", "Kite", "Swimming hall",
        "Boat", "Yoga", "Theater", "Scooter", "Moped", "Police car", "Satellite", "Milky Way", "Galaxy", "Anchor", "Statue of Liberty",
        "Map", "Carousel", "Volcano", "Fountain", "Wishing well", "Neighborhood", "Film", "Cuckoo clock", "Alarm clock", "Diamond",
        "Gem", "Wrench", "Baby tooth", "Dynamite", "Vaccine", "Piñata", "Disco ball", "Letter", "Marker", "Megaphone", "Spotify",
        "Comic book", "Sensei", "Wilderness", "Forest", "Reflector", "Oatmeal", "Donut", "Cinnamon roll", "Muesli", "Soft",
        "Hairy", "Discount", "Narrow", "Guess", "Non-fiction book", "Brush", "Paintbrush", "Artist", "Bruise", "Noodle", "Speech",
        "Rush", "Grin", "Pancake", "Dragonfly", "Werewolf", "Troll", "Weak", "Relief", "Browsing history", "Album", "Single",
        "Toothpick", "Algae", "Shark", "Moss", "Pool", "Toy", "Lego", "Wide", "Penny", "Abandoned house", "Hermit", "Cave",
        "Pickaxe", "Axe", "Hoe", "Pumpkin", "Hollow", "Motto", "Proverb", "Saying", "Hiccup", "Beetroot", "Troubadour", "Armor",
        "Jellyfish", "Siren", "Chopstick", "Fasting", "Weekend", "Glue", "Duct tape", "Lock", "Sombrero", "Elite", "Snail",
        "Whipped cream", "Earthworm", "Moonstone", "Four-leaf clover", "Cardboard", "Cousin", "Son-in-law", "Early morning",
        "Guinea pig", "Toast", "Toaster", "Oven", "Sink", "Net", "Regret", "Earthquake"
    ]

}






