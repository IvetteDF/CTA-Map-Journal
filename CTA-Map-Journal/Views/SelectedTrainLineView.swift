//
//  SelectedTrainLineView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct SelectedTrainLineView: View {
    
    @ObservedObject var trainStationViewModel = TrainStationViewModel()
    @State var selectedTrainLine: String
    
    var body: some View {
        
        // add logic to change color of heading based on selectedTrainLine
        Spacer()
            .navigationTitle(selectedTrainLine)
            .onAppear {
                trainStationViewModel.makeTrainStations(selectedTrainLine: selectedTrainLine)            }
        List(trainStationViewModel.trainStations) { trainStation in
            NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: trainStation.station_name)) {
                Text(trainStation.station_name)
            }
        }
    }
}

//struct SelectedTrainLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedTrainLineView()
//    }
//}

