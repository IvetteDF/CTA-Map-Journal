//
//  SelectedJournalEntryView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/1/22.
//

import SwiftUI
import Firebase

struct SelectedJournalEntryView: View {
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @State var selectedJournalEntry: JournalEntry
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedJournalEntry.date)
                Text(selectedJournalEntry.title)
            } .font(.headline)
            Text(selectedJournalEntry.entry)
        }
    }
}

struct SelectedJournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedJournalEntryView(selectedJournalEntry: JournalEntry(id: "rJvT9DL0CqL0Yqip8LqW", title: "Showing Off", timestamp: Timestamp(seconds: 1643996703, nanoseconds: 829902000), date: "2/2/22", entry: "Wow my classmates must be so impressed with me this is cool I love life", station_name: "18th (Pink Line)"))
    }
}
