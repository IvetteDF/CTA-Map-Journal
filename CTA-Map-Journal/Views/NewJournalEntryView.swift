//
//  NewJournalEntryView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 1/30/22.
//

import SwiftUI

struct NewJournalEntryView: View {
    @StateObject var journalEntryViewModel = JournalEntryViewModel()
    @ObservedObject var emotionDataViewModel = EmotionDataViewModel()
    @ObservedObject var nearestTrainStationViewModel = NearestTrainStationViewModel()
    
    @StateObject var selectedTrainStation: TrainStation
    @State var title = ""
    @State var entry = ""
    @State var link = ""
    @State var links: [String] = []
    @State private var analyzeEmotion = false
    @State var endTrainStationName = ""
        
    var body: some View {
        VStack(spacing: 0) {
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text("Start:")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
            }
            ZStack {
                Rectangle()
                    .fill(Color(.systemGray))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text(selectedTrainStation.station_name!)
                    .font(.headline)
                    .foregroundColor(Color.white)
            }
            ZStack (alignment: .leading) {
                Rectangle()
                    .fill(Color.black)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                HStack {
                    Text("(Optional) Select End:")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                    Picker("Select an end Train Station:", selection: $endTrainStationName) {
                        ForEach(TrainLines.allTrainStationsNames, id: \.self) { trainStationName in
                            Text(trainStationName)
                        }
                    }
                }
            }
        }
        VStack {
            TextField("Title", text: $title)
                .padding(.horizontal, 10.0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextEditor(text: $entry)
                .frame(width: 335.0)
                .padding(.all, 10.0)
                .border(Color(.systemGray5), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)
            
            Button {
                if links.count < 3 {
                    links.append("")
                }
            } label: {
                HStack {
                    Image(systemName: "plus.app.fill")
                        .foregroundColor(.black)
                    Text("Add a link")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10.0)
            }
            VStack {
                ForEach(links.indices, id: \.self) { index in
                    TextField("Add full link here", text: $links[index])
                        .padding(.horizontal, 10.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
            }
//            TextField("Optional Link", text: $link)
//                .padding(.horizontal, 10.0)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
                Toggle("Analyze Emotion?", isOn: $analyzeEmotion)
                    .padding(.leading, 10)
                Spacer()
                    .frame(width: 65)
                Button("Submit Entry") {
                    if analyzeEmotion {
                        emotionDataViewModel.getEmotionScores(title: title, entry: entry, links: links, station_name: selectedTrainStation.station_name!, end_station_name:endTrainStationName, analyzeEmotion: analyzeEmotion)
                    } else {
                        journalEntryViewModel.addJournalEntry(title: title, entry: entry, links: links, station_name: selectedTrainStation.station_name!, end_station_name: endTrainStationName)
                    }
                }
                .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(20)
                .alert("A journal entry needs a title and an entry :) Try again", isPresented: $journalEntryViewModel.emptyEntry) {
                    Button("<3", role: .cancel) {
                        journalEntryViewModel.setFalse()
                    }
                }
                .alert("Successfully entered, cutie ;)", isPresented: $journalEntryViewModel.successfulEntry) {
                    Button("<3", role: .cancel) {
                        journalEntryViewModel.setFalse()
                        title = ""
                        entry = ""
                        links = []
                    }
                }
                Spacer()
                    .frame(width: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
        }
    }
}

//struct NewJournalEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewJournalEntryView()
//    }
//}
