//
//  SelectedTrainStopView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct SelectedTrainStationView: View {
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @State var selectedTrainStation: String
    @State private var newJournalEntry: Bool = false
    
    var body: some View {
        Spacer()
            .navigationTitle(selectedTrainStation)
        NavigationLink(destination: NewJournalEntryView(selectedTrainStation: selectedTrainStation), isActive: $newJournalEntry) {EmptyView()}
        Button("New Journal Entry") {
            newJournalEntry = true
        }
        ZStack {
            Rectangle()
                .fill(Color(.systemGray))
                .frame(maxWidth: .infinity, maxHeight: 50)
            Text("Journal Entries")
                .font(.headline)
                .foregroundColor(Color.white)
                .onAppear {
                    journalEntryViewModel.getJournalEntries(selectedTrainStation: selectedTrainStation)
                }
        }
        List(journalEntryViewModel.journalEntries) { journalEntry in
//            let selectedJournalEntryId = journalEntry.id
            NavigationLink(destination: SelectedJournalEntryView(selectedJournalEntry: journalEntry)) {
                HStack {
                    Text(journalEntry.date)
                    Text(journalEntry.title)
                }
            }
        }
    }
}

//struct SelectedTrainStationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedTrainStationView()
//    }
//}
