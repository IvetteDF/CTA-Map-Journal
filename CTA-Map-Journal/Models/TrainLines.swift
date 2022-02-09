//
//  TrainLines.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/1/22.
//

import Foundation
import SwiftUI

struct TrainLines {
    static let trainLinesDict: [String:String] = [
        "Red Line": "red",
        "Blue Line": "blue",
        "Green Line": "g",
        "Brown Line": "brn",
        "Purple Line": "p",
        "Yellow Line": "y",
        "Pink Line": "pnk",
        "Orange Line": "o"]
    static let trainLineColors: [String:Color] = [
        "red": Color("CTARed"),
        "blue": Color("CTABlue"),
        "g": Color("CTAGreen"),
        "brn": Color("CTABrown"),
        "p": Color("CTAPurple"),
        "y": Color("CTAYellow"),
        "pnk": Color("CTAPink"),
        "o": Color("CTAOrange")]
    static let allTrainStationsNames: [String] = ["18th (Pink Line)", "35th-Bronzeville-IIT (Green Line)", "35th/Archer (Orange Line)", "43rd (Green Line)", "47th (Green Line)", "47th (Red Line)", "51st (Green Line)", "54th/Cermak (Pink Line)", "63rd (Red Line)", "69th (Red Line)", "79th (Red Line)", "87th (Red Line)", "95th/Dan Ryan (Red Line)", "Adams/Wabash (Brown, Green, Orange, Pink & Purple Lines)", "Addison (Blue Line)", "Addison (Brown Line)", "Addison (Red Line)", "Argyle (Red Line)", "Armitage (Brown & Purple Lines)", "Ashland (Green & Pink Lines)", "Ashland (Orange Line)", "Ashland/63rd (Green Line)", "Austin (Blue Line)", "Austin (Green Line)", "Belmont (Blue Line)", "Belmont (Red, Brown & Purple Lines)", "Berwyn (Red Line)", "Bryn Mawr (Red Line)", "California  (Blue Line)", "California (Blue Line)", "California (Green Line)", "California (Pink Line)", "Central (Green Line)", "Central (Purple Line)", "Central Park (Pink Line)", "Cermak-Chinatown (Red Line)", "Cermak-McCormick Place (Green Line)", "Chicago (Blue Line)", "Chicago (Brown & Purple Lines)", "Chicago (Red Line)", "Cicero (Blue Line)", "Cicero (Green Line)", "Cicero (Pink Line)", "Clark/Division (Red Line)", "Clark/Lake (Blue, Brown, Green, Orange, Purple & Pink Lines)", "Clinton (Blue Line)", "Clinton (Green & Pink Lines)", "Conservatory (Green Line)", "Cottage Grove (Green Line)", "Cumberland (Blue Line)", "Damen (Blue Line)", "Damen (Brown Line)", "Damen (Pink Line)", "Davis (Purple Line)", "Dempster (Purple Line)", "Dempster-Skokie  (Yellow Line)", "Diversey (Brown & Purple Lines)", "Division (Blue Line)", "Forest Park (Blue Line)", "Foster (Purple Line)", "Francisco (Brown Line)", "Fullerton (Red, Brown & Purple Lines)", "Garfield (Green Line)", "Garfield (Red Line)", "Grand (Blue Line)", "Grand (Red Line)", "Granville (Red Line)", "Halsted (Green Line)", "Halsted (Orange Line)", "Harlem (Blue Line - Forest Park Branch)", "Harlem (Blue Line - O\'Hare Branch)", "Harlem/Lake (Green Line)", "Harold Washington Library-State/Van Buren (Brown, Orange, Purple & Pink Lines)", "Harrison (Red Line)", "Howard (Red, Purple & Yellow Lines)", "Illinois Medical District (Blue Line)", "Indiana (Green Line)", "Irving Park (Blue Line)", "Irving Park (Brown Line)", "Jackson (Blue Line)", "Jackson (Red Line)", "Jarvis (Red Line)", "Jefferson Park (Blue Line)", "Kedzie (Brown Line)", "Kedzie (Green Line)", "Kedzie (Orange Line)", "Kedzie (Pink Line)", "Kedzie-Homan (Blue Line)", "Kimball (Brown Line)", "King Drive (Green Line)", "Kostner (Pink Line)", "LaSalle (Blue Line)", "LaSalle/Van Buren (Brown, Orange, Purple & Pink Lines)", "Lake (Red Line)", "Laramie (Green Line)", "Lawrence (Red Line)", "Linden (Purple Line)", "Logan Square (Blue Line)", "Loyola (Red Line)", "Main (Purple Line)", "Merchandise Mart (Brown & Purple Lines)", "Midway (Orange Line)", "Monroe (Blue Line)", "Monroe (Red Line)", "Montrose (Blue Line)", "Montrose (Brown Line)", "Morgan (Green & Pink Lines)", "Morse (Red Line)", "North/Clybourn (Red Line)", "Noyes (Purple Line)", "O\'Hare (Blue Line)", "Oak Park (Blue Line)", "Oak Park (Green Line)", "Oakton-Skokie (Yellow Line)", "Paulina (Brown Line)", "Polk (Pink Line)", "Pulaski (Blue Line)", "Pulaski (Green Line)", "Pulaski (Orange Line)", "Pulaski (Pink Line)", "Quincy/Wells (Brown, Orange, Purple & Pink Lines)", "Racine (Blue Line)", "Ridgeland (Green Line)", "Rockwell (Brown Line)", "Roosevelt (Red, Orange & Green Lines)", "Rosemont (Blue Line)", "Sedgwick (Brown & Purple Lines)", "Sheridan (Red Line)", "South Boulevard (Purple Line)", "Southport (Brown Line)", "Sox-35th (Red Line)", "State/Lake (Brown, Green, Orange, Pink & Purple Lines)", "Thorndale (Red Line)", "UIC-Halsted (Blue Line)", "Washington (Blue Line)", "Washington/Wabash (Brown, Green, Orange, Purple & Pink Lines)", "Washington/Wells (Brown, Orange, Purple & Pink Lines)", "Wellington (Brown & Purple Lines)", "Western (Blue Line - Forest Park Branch)", "Western (Blue Line - O\'Hare Branch)", "Western (Brown Line)", "Western (Orange Line)", "Western (Pink Line)", "Wilson (Red & Purple Lines)"]
}
