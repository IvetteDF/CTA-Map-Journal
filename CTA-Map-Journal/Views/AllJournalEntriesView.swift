//
//  AllJournalEntriesView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/13/22.
//

import SwiftUI
import Firebase

struct AllJournalEntriesView: View {
//    @State var allJournalEntries: [JournalEntry]
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @State private var showingJournalEntry = false
    @State var selectedJournalEntry: JournalEntry = JournalEntry(id: "", title: "", timestamp: Timestamp(seconds: 0, nanoseconds: 0), date: "", entry: "", links: [""], station_name: "", end_station_name: "")
    
    var body: some View {
        List(journalEntryViewModel.allJournalEntries.sorted(by: { lhs, rhs in
            return lhs.timestamp.seconds > rhs.timestamp.seconds
        })) { journalEntry in
            Button(action: {
                showingJournalEntry.toggle()
                selectedJournalEntry = journalEntry
            }, label: {
                HStack {
                    Text(journalEntry.date)
                    Text(journalEntry.title)
                }
                .foregroundColor(.black)
            })
            .sheet(isPresented: $showingJournalEntry) {
                    SelectedJournalEntryView(selectedJournalEntry: $selectedJournalEntry)
        }
        .navigationTitle("All Journal Entries")
        }
        .onAppear {
            journalEntryViewModel.getAllJournalEntries()
        }
    }
}

//struct AllJournalEntriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllJournalEntriesView()
//    }
//}
