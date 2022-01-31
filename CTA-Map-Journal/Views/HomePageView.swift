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
    @State var nearestTrainStation = ""
    var trainLines: [String:String] = [
        "red": "Red Line",
        "blue": "Blue Line",
        "g": "Green Line",
        "brn": "Brown Line",
        "p": "Purple Line",
        "y": "Yellow Line",
        "pnk": "Pink Line",
        "o": "Orange Line"]
    
    var body: some View {
        VStack (spacing: 0) {
            Text("CTA Map Journal")
                .font(.title)
            .fontWeight(.bold)
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                HStack {
                    Text("Find Nearest Station: ")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        
                    LocationButton (.currentLocation) {
                        // use function from NearestTrainStation
                    } .foregroundColor(.white)
                    
                }
            }
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("Placeholder \(nearestTrainStation)")
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
            NavigationView {
                List {
                    ForEach(trainLines.sorted(by: <), id: \.key) {key, value in
                        NavigationLink(destination: SelectedTrainLineView()) {
                            Text(value)
                                .listRowBackground(Color(.systemGray5))
                        }
                    }
                }
            }
            
            Spacer()

        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
