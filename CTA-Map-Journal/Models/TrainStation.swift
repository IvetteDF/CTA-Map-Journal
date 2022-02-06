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

class TrainStation: Decodable, Identifiable, ObservableObject {
    let stop_id: String?
    var id: String? { stop_id }
    let station_descriptive_name: String?
    var station_name: String? { station_descriptive_name }
    let location: Location?
    let red: Bool?
    let blue: Bool?
    let g: Bool?
    let brn: Bool?
    let p: Bool?
    let y: Bool?
    let pnk: Bool?
    let o: Bool?
    var trainLines: [String:Bool] {
        get {
            return [
                "red": red ?? false,
                "blue": blue ?? false,
                "g": g ?? false,
                "brn": brn ?? false,
                "p": p ?? false,
                "y": y ?? false,
                "pnk": pnk ?? false,
                "o": o ?? false]
        }
    }
    init(stop_id: String? = nil, id: String? = nil, station_descriptive_name: String? = nil, station_name: String? = nil, location: Location? = nil, red: Bool? = nil, blue: Bool? = nil, g: Bool? = nil, brn: Bool? = nil, p: Bool? = nil, y: Bool? = nil, pnk: Bool? = nil, o: Bool? = nil, trainLines: [String?:Bool?] = [nil:nil]) {
        self.stop_id = stop_id
        self.station_descriptive_name = station_descriptive_name
        self.location = location
        self.red = red
        self.blue = blue
        self.g = g
        self.brn = brn
        self.p = p
        self.y = y
        self.pnk = pnk
        self.o = o
    }
}

struct Location: Decodable {
    let latitude: String
    var latitudeDouble: Double { Double(latitude)! }
    let longitude: String
    var longitudeDouble: Double { Double(longitude)! }
    var clLocation: CLLocation { CLLocation(latitude: latitudeDouble, longitude: longitudeDouble) }
}

