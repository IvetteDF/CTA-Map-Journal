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
    
    func getJournalEntries(selectedTrainStation: String) {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("station_name", isEqualTo: selectedTrainStation)
            .getDocuments { snapshot, error in
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
                                                 station_name: d["station_name"] as? String ?? "")
                         }
                    }
                }
            } else {
                print(error!)
            }
        }
    }
    
    func addJournalEntry(title: String, entry: String, station_name: String, analyzeEmotion: Bool = false, emotionScores: [String:Double] = [:]) {
        // emotion API call stuff - works! now do I put the addJournalEntry stuff inside its completion handler? if not, how to async??
//        let emotionDataViewModel = EmotionDataViewModel()
//        emotionDataViewModel.getEmotionScores(entry: entry)
        
        // add a timestamp
        let timestamp: Date = Date()
        
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .addDocument(data: ["title":title,
                                "timestamp":timestamp,
                                "entry":entry,
                                "station_name":station_name,
                                "analyzeEmotion":analyzeEmotion,
                                "emotionScores":emotionScores]) { error in
            if error == nil {
                // success message
                print("added Journal Entry")
                // add logic to clear text field and text editor if success
                // add logic to include notification of successful post
            } else {
                print(error!)
            }
        }
    }
}
