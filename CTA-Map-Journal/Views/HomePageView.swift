//
//  HomePageView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct HomePageView: View {
    @ObservedObject var nearestTrainStationViewModel = NearestTrainStationViewModel()
    @ObservedObject var emotionDataViewModel = EmotionDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                ScrollView {
                    switch emotionDataViewModel.loadState {
                    case .loading:
                        ProgressView()
                            .onAppear(perform: emotionDataViewModel.getAllEmotionData)
                    case .loaded:
                        VStack {
                        EmotionChartView(values: emotionDataViewModel.aggregateEmotionScoresArray, colors: [Color.purple, Color("CTAGreen"), Color("CTAYellow"), Color("CTARed"), Color("CTABlue"), Color("CTAOrange")], names: emotionDataViewModel.emotionsArray, backgroundColor: Color.white, innerRadiusFraction: 0.1)
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
                        NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: nearestTrainStationViewModel.nearestTrainStation)) {
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
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
