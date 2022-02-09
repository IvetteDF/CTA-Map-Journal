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
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
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
            } .frame(maxWidth: .infinity, maxHeight: 50, alignment: .top)
            Spacer()
                .navigationTitle(selectedTrainStation.station_name!)
            ScrollView {
                switch emotionDataViewModel.loadStateTrainStation {
                case .loading:
                    ProgressView()
                        .onAppear {
                            emotionDataViewModel.getEmotionDataForTrainStation(selectedTrainStationName: selectedTrainStation.station_name!)
                        }
                case .loaded:
                    VStack {
                    EmotionChartView(values: emotionDataViewModel.aggregateEmotionScoresForTrainStationArray, colors: [Color.purple, Color("CTAGreen"), Color("CTAYellow"), Color("CTARed"), Color("CTABlue"), Color("CTAOrange")], names: emotionDataViewModel.emotionsArray, backgroundColor: Color.white, innerRadiusFraction: 0.1)
                    }
                case .oopsy:
                    ErrorView()
                }
            }
            NavigationLink(destination: NewJournalEntryView(selectedTrainStation: selectedTrainStation), isActive: $newJournalEntry) {EmptyView()}
            Button("New Journal Entry") {
                newJournalEntry = true
            }
            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
            .background(Color.black)
            .foregroundColor(Color.white)
            .font(.body)
                
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("Journal Entries")
                    .font(.title)
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
}

struct SelectedTrainStationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTrainStationView(selectedTrainStation: TrainStation(stop_id: "30162", id: "30162", station_descriptive_name: "18th (Pink Line)", red: false, blue: false, g: false, brn: false, p: false, y: false, pnk: true, o: false))
    }
}
