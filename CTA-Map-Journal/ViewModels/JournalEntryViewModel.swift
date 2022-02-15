//
//  JournalEntryFunctions.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import Foundation
import Firebase
import SwiftUI

class JournalEntryViewModel: ObservableObject {
    
    @Published var journalEntries = [JournalEntry]()
    @Published var allJournalEntries = [JournalEntry]()
    @Published var successfulEntry: Bool = false
    @Published var emptyEntry: Bool = false
    
    func deleteJournalEntry(entryToDelete: JournalEntry) {
        let db = Firestore.firestore()
        db.collection("JournalEntries").document(entryToDelete.id).delete { error in
            if error == nil {
                // no errors
                DispatchQueue.main.async {
                    // UI updates
//                    self.journalEntries.removeAll { journalEntry in
//                        return journalEntry.id == entryToDelete.id
//                    }
                    print("Deleted \(entryToDelete.title)")
//                    self.getJournalEntries(selectedTrainStationName: entryToDelete.station_name)
                }
            } else {
                // error handling
                print(error!)
            }
        }
    }
    
    func getAllJournalEntries() {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .getDocuments { snapshot, error in
                if error == nil {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            self.allJournalEntries = snapshot.documents.map { d in
                                let timestamp = d["timestamp"] as! Timestamp
                                let formatter = DateFormatter()
                                formatter.dateStyle = .short
                                let date = formatter.string(from: timestamp.dateValue())
                                
                                return JournalEntry(id: d.documentID,
                                                    title: d["title"] as? String ?? "",
                                                    timestamp: timestamp,
                                                    date: date,
                                                    entry: d["entry"] as? String ?? "",
                                                    link: d["link"] as? String ?? "",
                                                    station_name: d["station_name"] as? String ?? "",
                                                    end_station_name: d["end_station_name"] as? String ?? "")
                            }
                        }
                    }
                } else {
                    //error handling
                    print(error!)
                }
            }
    }
    
    func getJournalEntries(selectedTrainStationName: String) {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("station_name", isEqualTo: selectedTrainStationName)
            .addSnapshotListener { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        // this is where we update journalEntries
                         self.journalEntries = snapshot.documents.map { d in
                             // logic to convert timestamp to string
                             let timestamp = d["timestamp"] as! Timestamp
                             let formatter = DateFormatter()
                             formatter.dateStyle = .short
                             let date = formatter.string(from: timestamp.dateValue())
                             
                             return JournalEntry(id: d.documentID,
                                                 title: d["title"] as? String ?? "",
                                                 timestamp: timestamp,
                                                 date: date,
                                                 entry: d["entry"] as? String ?? "",
                                                 link: d["link"] as? String ?? "",
                                                 station_name: d["station_name"] as? String ?? "",
                                                 end_station_name: d["end_station_name"] as? String ?? "")
                         }
                    }
                }
            } else {
                print(error!)
            }
        }
    }
    
    func addJournalEntry(title: String, entry: String, link: String, station_name: String, end_station_name: String = "", analyzeEmotion: Bool = false, emotionScores: [String:Double] = [:]) {
        // check for empty entry or title
        if ((entry == "") || (title == "")) {
            self.emptyEntry = true
            return
        }
        
        // add a timestamp
        let timestamp: Date = Date()
        
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .addDocument(data: ["title":title,
                                "timestamp":timestamp,
                                "entry":entry,
                                "link":link,
                                "station_name":station_name,
                                "end_station_name": end_station_name,
                                "analyzeEmotion":analyzeEmotion,
                                "emotionScores":emotionScores]) { error in
            if error == nil {
                // success message
                print("added Journal Entry")
                self.successfulEntry = true
//                print(self.successfulEntry)
                
                // add logic to include notification of successful post
            } else {
                print(error!)
            }
        }
    }
    
    func setFalse() {
        self.successfulEntry = false
        self.emptyEntry = false
//        print("empty entry\(self.emptyEntry)")
    }
}
