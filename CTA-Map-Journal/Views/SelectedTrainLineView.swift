//
//  SelectedTrainLineView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI
import Firebase

struct SelectedTrainLineView: View {
    
    @ObservedObject var trainStationViewModel = TrainStationViewModel()
    @State var selectedTrainLine: String
    @State var selectedTrainLineValue: String
    
    var body: some View {
        
       // ZStack {

            VStack {
                ZStack {
                    Rectangle()
                        .fill(TrainLines.trainLineColors[selectedTrainLineValue] ?? Color.gray)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: 10)
                    Text("\(selectedTrainLine)   ")
                        .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 100.0)
                        .frame(maxWidth: .infinity, maxHeight: 10, alignment: .topTrailing)
                        .ignoresSafeArea()
                        .onAppear {
                            trainStationViewModel.makeTrainStations(selectedTrainLine: selectedTrainLine)            }
                }
                List(trainStationViewModel.trainStations) { trainStation in
                    NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: trainStation)) {
                        Text(trainStation.station_name!)
                    }
                }
            }
       // }
    }
}

struct SelectedTrainLineView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedTrainLineView(selectedTrainLine: "Red Line", selectedTrainLineValue: "red")
    }
}

