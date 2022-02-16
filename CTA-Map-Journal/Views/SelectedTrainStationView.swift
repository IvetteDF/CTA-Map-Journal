//
//  SelectedTrainStopView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI
import Firebase

struct SelectedTrainStationView: View {
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @StateObject var emotionDataViewModel = EmotionDataViewModel()
    @StateObject var selectedTrainStation: TrainStation
    @EnvironmentObject var settings: SettingsViewModel
    
    @State private var selectedJournalEntry: JournalEntry = JournalEntry(id: "",
                                                                         title: "",
                                                                         timestamp: Timestamp(seconds: 0, nanoseconds: 0),
                                                                         date: "",
                                                                         entry: "",
                                                                         links: [""],
                                                                         station_name: "",
                                                                         end_station_name: "")
    @State private var newJournalEntry: Bool = false
    @State private var showingJournalEntry = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .onAppear {
                        emotionDataViewModel.getEmotionDataForTrainStation(selectedTrainStationName: selectedTrainStation.station_name!, startDate: settings.startDate)
                    }
                HStack {
                    // make trainline circles
                    let trainLines = selectedTrainStation.trainLines.map{$0.key}
                    ForEach(trainLines, id: \.self) { trainLine in
                        if selectedTrainStation.trainLines[trainLine]! {
                            Circle()
                                .fill(TrainLines.trainLineColors[trainLine]!)
                                .frame(width: 40)
                        }
                    }
                }
            }
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .top)
            Spacer()
                .navigationTitle(selectedTrainStation.station_name!)
            ScrollView {
                switch emotionDataViewModel.loadStateTrainStation {
                case .loading:
                    ProgressView()
                case .loaded:
                    VStack {
                    EmotionChartView(values: emotionDataViewModel.aggregateEmotionScoresForTrainStationArray,
                                     colors: [TrainLines.themeColors[settings.angerColor]!, TrainLines.themeColors[settings.disgustColor]!, TrainLines.themeColors[settings.fearColor]!, TrainLines.themeColors[settings.joyColor]!, TrainLines.themeColors[settings.sadnessColor]!, TrainLines.themeColors[settings.surpriseColor]!],
                                     names: emotionDataViewModel.emotionsArray,
                                     backgroundColor: Color.white,
                                     innerRadiusFraction: 0.1)
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
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(20)
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
                    }
            }
            List(journalEntryViewModel.journalEntries.sorted(by: { lhs, rhs in
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
            }
                .sheet(isPresented: $showingJournalEntry) {
                    SelectedJournalEntryView(selectedJournalEntry: $selectedJournalEntry)
                }
        }
    }
}

//struct SelectedTrainStationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedTrainStationView(selectedTrainStation: TrainStation(stop_id: "30162", id: "30162", station_descriptive_name: "18th (Pink Line)", red: false, blue: false, g: false, brn: false, p: false, y: false, pnk: true, o: false))
//    }
//}
