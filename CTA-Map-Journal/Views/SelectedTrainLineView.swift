//
//  SelectedTrainLineView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct SelectedTrainLineView: View {
    
    @ObservedObject var trainStationViewModel = TrainStationViewModel()
    @State var selectedTrainLine: String = ""
    
    var body: some View {
        Text("Train Line")
            .onAppear {
                trainStationViewModel.readFile()
            }
        List(trainStationViewModel.trainStations) { trainStation in
            Text(trainStation.station_name)
        }
    }
}

struct SelectedTrainLineView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTrainLineView()
    }
}

