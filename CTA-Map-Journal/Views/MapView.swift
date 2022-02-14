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
        Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all, showsUserLocation: true, annotationItems: allTrainStations) { trainStation in
            MapAnnotation(coordinate: trainStation.location!.clLocation) {
                NavigationLink {
                    SelectedTrainStationView(selectedTrainStation: trainStation, selectedJournalEntry: JournalEntry(id: "", title: "", timestamp: Timestamp(seconds: 0, nanoseconds: 0), date: "", entry: "", station_name: "", end_station_name: ""))
                } label: {
                    TrainStationMarkerView()
                }
                .foregroundColor(.black)
            }
        }
            .ignoresSafeArea()
    }
}

struct TrainStationMarkerView: View {
    var body: some View {
        Image(systemName: "circle.circle.fill")
//            .hoverEffect(.lift)
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
