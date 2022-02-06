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
}
