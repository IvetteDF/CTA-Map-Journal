//
//  SelectedTrainStopView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct SelectedTrainStationView: View {
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @ObservedObject var emotionDataViewModel = EmotionDataViewModel()
    @StateObject var selectedTrainStation: TrainStation
    @State private var newJournalEntry: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(.systemGray))
                .frame(maxWidth: .infinity, maxHeight: 50)
                .onAppear() {
                    print(selectedTrainStation.trainLines)
                }
            HStack {
                // make trainline circles
                let trainLines = selectedTrainStation.trainLines.map{$0.key}
                let values = selectedTrainStation.trainLines.map{$0.value}
                ForEach(trainLines.indices) { index in
                    if values[index] {
                        Circle()
                            .fill(TrainLines.trainLineColors[trainLines[index]]!)
                            .frame(width: 40)
                    }
                }
            }
        }
        Spacer()
            .navigationTitle(selectedTrainStation.station_name!)
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
                    journalEntryViewModel.getJournalEntries(selectedTrainStationName: selectedTrainStation.station_name!)
                    emotionDataViewModel.getEmotionDataForTrainStation(selectedTrainStationName: selectedTrainStation.station_name!)
                }
        }
        List(journalEntryViewModel.journalEntries.sorted(by: { lhs, rhs in
            return lhs.timestamp.seconds > rhs.timestamp.seconds
        })) { journalEntry in
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
