//
//  AllJournalEntriesView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/13/22.
//

import SwiftUI

struct AllJournalEntriesView: View {
    @State var allJournalEntries: [JournalEntry]
    @State var selectedJournalEntry: JournalEntry
    @State private var showingJournalEntry = false
    
    var body: some View {
        List(allJournalEntries.sorted(by: { lhs, rhs in
            return lhs.timestamp.seconds > rhs.timestamp.seconds
        })) { journalEntry in
            Button(action: {
                selectedJournalEntry = journalEntry
                showingJournalEntry.toggle()
            }, label: {
                HStack {
                    Text(journalEntry.date)
                    Text(journalEntry.title)
                }
                .foregroundColor(.black)
            })
        }
        .sheet(isPresented: $showingJournalEntry) {
            SelectedJournalEntryView(selectedJournalEntry: selectedJournalEntry)
        }
    }
}

//struct AllJournalEntriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllJournalEntriesView()
//    }
//}
