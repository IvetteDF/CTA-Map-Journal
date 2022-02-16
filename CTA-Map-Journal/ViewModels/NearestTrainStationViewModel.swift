//
//  NearestTrainStationViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit

final class NearestTrainStationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @ObservedObject var nearestTrainStation: TrainStation
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.878871700000005, longitude: -87.63590784114558),
                                               span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    @Published var userLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    @Published var allTrainStations: [TrainStation] = []
    @Published var allTrainStationsNames: [String] = []
    
    let locationManager = CLLocationManager()
    
    override init () {
        self.nearestTrainStation = TrainStation()
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
            self.region = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
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
            sqrt(pow((trainStation.location!.latitudeDouble - self.userLocation.coordinate.latitude), 2) + pow((trainStation.location!.longitudeDouble - self.userLocation.coordinate.longitude), 2))
            // check for min distance
            if distance < minDistance {
                minDistance = distance
                self.nearestTrainStation = trainStation
            }
        }
    }
    
    func makeAllTrainStations() {
        if let url = Bundle.main.url(forResource: "CTALStopsFixed", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(JSONData.self, from: data) {
                var trainStationsDuplicates: [TrainStation] = jsonData.trainStops
                // logic to remove duplicates
                trainStationsDuplicates.sort { $0.station_name! < $1.station_name! }
                var prevTrainStationName: String = ""
                for trainStation in trainStationsDuplicates {
                    if (trainStation.station_name != prevTrainStationName) {
                        self.allTrainStations.append(trainStation)
                        prevTrainStationName = trainStation.station_name!
                    }
                }
            }
        }
    }
    
    func makeAllTrainStationsNames() {
        makeAllTrainStations()
        var tempNames: [String] = []
        for trainStation in self.allTrainStations {
            tempNames.append(trainStation.station_name!)
        }
        tempNames.sort()
        var prevName = ""
        for name in tempNames {
            if (name != prevName) {
                self.allTrainStationsNames.append(name)
                prevName = name
            }
        }
        
    }
}
