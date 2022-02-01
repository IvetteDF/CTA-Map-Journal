//
//  TrainStationViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/31/22.
//

import Foundation

class TrainStationViewModel: ObservableObject {

    @Published var trainStations: [TrainStation] = []
    
    // add logic to remove duplicates
    // add logic to select stations based on selectedTrainLine
    func makeTrainStations() {
        if let url = Bundle.main.url(forResource: "CTALStops", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                self.trainStations = jsonData.trainStops
            }
        }
    }
}
