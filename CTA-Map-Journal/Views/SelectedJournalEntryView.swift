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
//    @StateObject var selectedTrainStation: TrainStation
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
            }
            .padding(.top, 15.0)
            Spacer()
                .onAppear {
                    print("title here")
                    print(selectedJournalEntry.title)
                }
            VStack {
                HStack {
                    Text(selectedJournalEntry.date)
                    Text(selectedJournalEntry.title)
                }
                Spacer()
                    .frame(height: 15)
                Text(selectedJournalEntry.station_name)
            }
            .font(.headline)
            Spacer()
                .frame(height: 15)
            Text(selectedJournalEntry.entry)
            Spacer()
            Button("Delete Entry") {
                dismiss()
                journalEntryViewModel.deleteJournalEntry(entryToDelete: selectedJournalEntry)
            }
                .padding(.all, 10.0)
                .background(Color.black)
                .foregroundColor(Color.white)
                .font(.body)
            Spacer()
                .frame(height: 15)
        }
    }
}

//struct SelectedJournalEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedJournalEntryView(selectedJournalEntry: JournalEntry(id: "rJvT9DL0CqL0Yqip8LqW", title: "Showing Off", timestamp: Timestamp(seconds: 1643996703, nanoseconds: 829902000), date: "2/2/22", entry: "Wow my classmates must be so impressed with me this is cool I love life", station_name: "18th (Pink Line)", end_station_name: ""))
//    }
//}
