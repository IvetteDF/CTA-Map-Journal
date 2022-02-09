//
//  JournalEntry.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import Foundation
import Firebase

struct JournalEntry: Identifiable {
    var id: String
    var title: String
    var timestamp: Timestamp
    var date: String
    var entry: String
    var station_name: String
    var end_station_name: String
}
