//
//  NearestTrainStationViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import Foundation
import CoreLocation

final class NearestTrainStationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    @Published var nearestTrainStation: String = ""
    @Published var allTrainStations: [TrainStation] = []
    
    
    let locationManager = CLLocationManager()
    
    override init () {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAndFindNearestTrainStation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            print("Unable to get latest location")
            return
        }
        DispatchQueue.main.async {
            // set userLocation to latestLocation
            self.userLocation = latestLocation
            // call findNearestTrainStation
            self.findNearestTrainStation(userLocation: latestLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func findNearestTrainStation(userLocation: CLLocation) {
        self.makeAllTrainStations()
        var minDistance: Double = 180
        for trainStation in allTrainStations {
            // calculate distance between trainStation and userLocation
            let distance: Double =
            sqrt(pow((trainStation.location.latitudeDouble - userLocation.coordinate.latitude), 2) + pow((trainStation.location.longitudeDouble - userLocation.coordinate.longitude), 2))
            // check for min distance
            if distance < minDistance {
                minDistance = distance
                self.nearestTrainStation = trainStation.station_name
            }
        }
    }
    
    func makeAllTrainStations() {
        if let url = Bundle.main.url(forResource: "CTALStops", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                let trainStationsDuplicates: [TrainStation] = jsonData.trainStops
                // logic to remove duplicates
                var prevTrainStationName: String = ""
                for trainStation in trainStationsDuplicates {
                    if (trainStation.station_name != prevTrainStationName) {
                        self.allTrainStations.append(trainStation)
                        prevTrainStationName = trainStation.station_name
                    }
                }
            }
        }
    }
}
