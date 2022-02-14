//
//  HomePageView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI
import CoreLocationUI
import MapKit
import Firebase

struct HomePageView: View {
    @ObservedObject var nearestTrainStationViewModel = NearestTrainStationViewModel()
    @ObservedObject var emotionDataViewModel = EmotionDataViewModel()
    @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
    @StateObject var settings = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                ZStack{
                    Rectangle()
                        .fill(Color.black)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    HStack {
                        NavigationLink(destination: MapView(region: nearestTrainStationViewModel.region, allTrainStations: nearestTrainStationViewModel.allTrainStations)) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                                .padding(.leading, 15)
                        }
                        NavigationLink(destination: AllJournalEntriesView(allJournalEntries: journalEntryViewModel.allJournalEntries, selectedJournalEntry: JournalEntry(id: "", title: "", timestamp: Timestamp(seconds: 0, nanoseconds: 0), date: "", entry: "", station_name: "", end_station_name: ""))) {
                            Image(systemName: "book.fill")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .center)
                                .padding(.horizontal, 15)
                                .onAppear {
                                    journalEntryViewModel.getAllJournalEntries()
                                }
                        }
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .trailing)
                                .padding(.trailing, 15)
                                .onAppear {
                                    nearestTrainStationViewModel.makeAllTrainStations()
                                }
                        }
                    }
                }
                ScrollView {
                    switch emotionDataViewModel.loadState {
                    case .loading:
                        ProgressView()
                            .onAppear(perform: emotionDataViewModel.getAllEmotionData)
                    case .loaded:
                        VStack {
                            EmotionChartView(values: emotionDataViewModel.aggregateEmotionScoresArray,
                                             colors: [TrainLines.themeColors[settings.angerColor]!, TrainLines.themeColors[settings.disgustColor]!, TrainLines.themeColors[settings.fearColor]!, TrainLines.themeColors[settings.joyColor]!, TrainLines.themeColors[settings.sadnessColor]!, TrainLines.themeColors[settings.surpriseColor]!],
                                             names: emotionDataViewModel.emotionsArray,
                                             backgroundColor: Color.white,
                                             innerRadiusFraction: 0.1)
                        }                        
                    case .oopsy:
                        ErrorView()
                    }
                }
                Divider()
                Spacer()
                    .navigationTitle("CTA Map Journal")
                VStack (spacing: 0) {
                    ZStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        HStack {
                            Text("Find Nearest Station: ")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                
                            LocationButton (.currentLocation) {
                                nearestTrainStationViewModel.requestLocationAndFindNearestTrainStation()
                            } .foregroundColor(.white)
                            
                        }
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray))
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        // add NavigationLink to SelectedTrainStationView of nearestTrainStation
                        NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: nearestTrainStationViewModel.nearestTrainStation, selectedJournalEntry: JournalEntry(id: "", title: "", timestamp: Timestamp(seconds: 0, nanoseconds: 0), date: "", entry: "", station_name: "", end_station_name: ""))) {
                            Text(nearestTrainStationViewModel.nearestTrainStation.station_name ?? "")
                                .foregroundColor(Color.white)
                        }
                    }
                    ZStack (alignment: .leading) {
                        Rectangle()
                            .fill(Color.black)
                            .frame(maxWidth: .infinity, maxHeight: 50)
                        Text("Select a Train Line:")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                    }
                    List {
                        ForEach(TrainLines.trainLinesDict.sorted(by: <), id: \.key) {key, value in
                            NavigationLink(destination: SelectedTrainLineView(selectedTrainLine: key, selectedTrainLineValue: value)) {
                                Text(key)
                                    .listRowBackground(Color(.systemGray5))
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(settings)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
