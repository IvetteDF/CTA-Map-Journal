//
//  JournalEntryFunctions.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import Foundation
import Firebase

class JournalEntryViewModel: ObservableObject {
    // do I want a @Published variable that's just journal entries or do I need one for the journal entries associated with a station?
    // if the first, I could do a get method that filters based on a field that marks the start station
    
    // @Published var journalEntries = [JournalEntry]()
    
//    func getJournalEntries() {
//        let db = Firestore.firestore()
//        db.collection("JournalEntries").getDocuments { snapshot, error in
//            if error == nil {
//                if let snapshot = snapshot {
//                    DispatchQueue.main.async {
//                        // this is where we update journalEntries
//                         self.journalEntries = snapshot.documents.map { d in
//                             return JournalEntry() //JournalEntry model needs to be made first
//                         }
//                    }
//                }
//            } else {
//                // error handling
//            }
//        }
//    }
    
//    func postJournalEntry() {}
}
