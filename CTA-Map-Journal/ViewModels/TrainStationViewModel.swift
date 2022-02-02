//
//  TrainStationViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/31/22.
//

import Foundation

class TrainStationViewModel: ObservableObject {

    @Published var trainStations: [TrainStation] = []
    
    func makeTrainStations(selectedTrainLine: String) {
        if let url = Bundle.main.url(forResource: "CTALStops", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                let trainStationsDuplicates: [TrainStation] = jsonData.trainStops
                // logic to remove duplicates and select by selectedTrainLine
                var prevTrainStationName: String = ""
                let trainStationColor = TrainLines.trainLinesDict[selectedTrainLine]!
                for trainStation in trainStationsDuplicates {
                    if (trainStation.station_name != prevTrainStationName) && (trainStation.trainLines[trainStationColor]! == true) {
                        self.trainStations.append(trainStation)
                        prevTrainStationName = trainStation.station_name
                    }
                }
            }
        }
    }
}
