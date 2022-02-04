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
//    @State var nearestTrainStation = ""
    @ObservedObject var nearestTrainStationViewModel = NearestTrainStationViewModel()
    @ObservedObject var emotionDataViewModel = EmotionDataViewModel()
    
    var body: some View {
        NavigationView {
            VStack (spacing: 0) {
                Spacer()
                    .navigationTitle("CTA Map Journal")
                    .onAppear {
                        emotionDataViewModel.getAllEmotionData()
                    }
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
                    Text(nearestTrainStationViewModel.nearestTrainStation)
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
                        NavigationLink(destination: SelectedTrainLineView(selectedTrainLine: key)) {
                            Text(key)
                                .listRowBackground(Color(.systemGray5))
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
