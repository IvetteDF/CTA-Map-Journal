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

struct TrainStation: Decodable, Identifiable {
    let stop_id: String
    var id: String { stop_id }
    let station_name: String
}

