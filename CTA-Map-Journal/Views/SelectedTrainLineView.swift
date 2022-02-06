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
    @State var selectedTrainLineValue: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(TrainLines.trainLineColors[selectedTrainLineValue] ?? Color.gray)
                .ignoresSafeArea()
            VStack {
                Text(selectedTrainLine)
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .bold()
                    .frame(alignment: .topLeading)
                Spacer()
//                    .navigationTitle(selectedTrainLine)
                    .onAppear {
                        trainStationViewModel.makeTrainStations(selectedTrainLine: selectedTrainLine)            }
                List(trainStationViewModel.trainStations) { trainStation in
                    NavigationLink(destination: SelectedTrainStationView(selectedTrainStation: trainStation)) {
                        Text(trainStation.station_name!)
                    }
                }
            }
        }
    }
}

//struct SelectedTrainLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedTrainLineView()
//    }
//}

