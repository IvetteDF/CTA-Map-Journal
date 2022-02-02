//
//  TrainStation.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/31/22.
//

import Foundation
import SwiftUI
import CoreLocation

struct JSONData: Decodable {
    let trainStops: [TrainStation]
}

struct TrainStation: Decodable, Identifiable, Equatable {
    let stop_id: String
    var id: String { stop_id }
    let station_name: String
    let red: Bool
    let blue: Bool
    let g: Bool
    let brn: Bool
    let p: Bool
    let y: Bool
    let pnk: Bool
    let o: Bool
    var trainLines: [String:Bool] {
        get {
            return [
                "red": red,
                "blue": blue,
                "g": g,
                "brn": brn,
                "p": p,
                "y": y,
                "pnk": pnk,
                "o": o]
        }
    }
}

