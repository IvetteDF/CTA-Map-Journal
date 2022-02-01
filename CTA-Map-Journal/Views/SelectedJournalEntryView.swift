//
//  SelectedJournalEntryView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/1/22.
//

import SwiftUI

struct SelectedJournalEntryView: View {
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @State var selectedJournalEntry: JournalEntry
    
    var body: some View {
        Text(selectedJournalEntry.title)
            .onAppear {
                print(selectedJournalEntry.timestamp)
            }
        Text(selectedJournalEntry.date)
        Text(selectedJournalEntry.entry)
    }
}

//struct SelectedJournalEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedJournalEntryView()
//    }
//}
