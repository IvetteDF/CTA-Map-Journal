//
//  MapView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/11/22.
//

import SwiftUI
import MapKit
import Firebase

struct MapView: View {
//    @StateObject var mapViewModel = NearestTrainStationViewModel()
    @State var region: MKCoordinateRegion
    @State var allTrainStations: [TrainStation]
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: allTrainStations) {
            MapAnnotation(coordinate: $0.location!.clLocation) {
//                NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: $0, selectedJournalEntry: JournalEntry(id: "", title: "", timestamp: Timestamp(seconds: 0, nanoseconds: 0), date: "", entry: "", station_name: "", end_station_name: ""))) {
                    TrainStationMarkerView()
//                }
            }
        }
            .ignoresSafeArea()
    }
}

struct TrainStationMarkerView: View {
    var body: some View {
        Image(systemName: "circle.circle.fill")
    }
}

struct JournalEntryMarkerView: View {
    var body: some View {
        Image(systemName: "book.fill")
            .tint(.pink)
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
