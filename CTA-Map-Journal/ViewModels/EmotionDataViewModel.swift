//
//  EmotionDataViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/2/22.
//

import Foundation
import SwiftUI
import Firebase

// I suspect that I should have made EmotionDataViewModel a sub class of JournalEntryViewModel or vice versa
class EmotionDataViewModel: ObservableObject {
    
    enum LoadState {
        case loading
        case loaded
        case oopsy
    }
    
    @Published var loadState: LoadState = .loading
    @Published var loadStateTrainStation: LoadState = .loading
    @Published var successfulEntryEmotion: Bool = false
    @Published var emotionScores: [String:Double] = [:]
    @Published var aggregateEmotionScoresForTrainStation:[String:Double] = ["anger": 0,
                                                                            "disgust": 0,
                                                                            "sadness": 0,
                                                                            "joy": 0,
                                                                            "surprise": 0,
                                                                            "fear": 0]
    @Published var aggregateEmotionScores:[String:Double] = ["anger": 0,
                                                             "disgust": 0,
                                                             "sadness": 0,
                                                             "joy": 0,
                                                             "surprise": 0,
                                                             "fear": 0]
    @Published var aggregateEmotionScoresForTrainStationArray: [Double] = []
    @Published var aggregateEmotionScoresArray: [Double] = []
    
    let emotionsArray: [String] = ["Anger", "Disgust", "Fear", "Joy", "Sadness", "Surprise"]

    func getEmotionScores(title: String,
                          entry: String,
                          links: [String],
                          station_name: String,
                          end_station_name: String,
                          analyzeEmotion: Bool) {

        @ObservedObject var journalEntryViewModel = JournalEntryViewModel()
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "x-rapidapi-host": "twinword-emotion-analysis-v1.p.rapidapi.com",
            "x-rapidapi-key": Secrets.APIKey
        ]
        let postData = Data("text=\(entry)".data(using: String.Encoding.utf8)!)
        var request = URLRequest(url: URL(string: "https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/")! as URL,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpData = data!
                self.decodeEmotionData(httpData: httpData)
                journalEntryViewModel.addJournalEntry(title: title, entry: entry, links: links, station_name: station_name, end_station_name: end_station_name, analyzeEmotion: true, emotionScores: self.emotionScores)
                DispatchQueue.main.async {
                    self.successfulEntryEmotion = true
                }
            }
        }
        dataTask.resume()
    }
    
    func decodeEmotionData(httpData: Data) {
        let decoder = JSONDecoder()
        if let emotionData = try? decoder.decode(EmotionData.self, from: httpData) {
            let emotionScoresDict = [
                "anger": emotionData.emotion_scores.anger,
                "disgust": emotionData.emotion_scores.disgust,
                "sadness": emotionData.emotion_scores.sadness,
                "joy": emotionData.emotion_scores.joy,
                "surprise": emotionData.emotion_scores.surprise,
                "fear": emotionData.emotion_scores.fear]
            self.emotionScores = emotionScoresDict
        }
    }
    
    func getEmotionDataForTrainStation (selectedTrainStationName: String, startDate: Date) {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("station_name", isEqualTo: selectedTrainStationName)
            .whereField("analyzeEmotion", isEqualTo: true)
            .getDocuments { snapshot, error in
                if error != nil {
                    // error handling
                    print(error!)
                } else {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            let length = Double(snapshot.documents.count)
                            if length == 0.0 {
                                self.aggregateEmotionScoresForTrainStationArray = [0, 0, 0, 0, 0, 0]
                                self.loadStateTrainStation = .loaded
                                return
                            }
                            for d in snapshot.documents {
                                var emotionScores = d["emotionScores"] as! Dictionary<String, Double>
                                // get sum of emotion scores for d
                                var sumEmotionScores: Double = 0
                                for (_, score) in emotionScores {
                                    sumEmotionScores += score
                                }
                                // find ratio of emotion score for each emotion in d
                                for (emotion, score) in emotionScores {
                                    emotionScores[emotion] = (score / sumEmotionScores)
                                }
                                // find sum of ratios of emotion scores from d
                                for (emotion, ratio) in emotionScores {
                                    self.aggregateEmotionScoresForTrainStation[emotion]! += ratio
                                }
                            }
                            for (emotion, sumOfRatios) in self.aggregateEmotionScoresForTrainStation {
                                self.aggregateEmotionScoresForTrainStation[emotion] = sumOfRatios/length
                            }
                            let sorted = self.aggregateEmotionScoresForTrainStation.sorted(by: <)
                            self.aggregateEmotionScoresForTrainStationArray = sorted.map { $0.value }
                            self.loadStateTrainStation = .loaded
                        }
                    }
                }
            }
    }
    
        // could have made helper functions here
    
    func getAllEmotionData(startDate: Date) {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("analyzeEmotion", isEqualTo: true)
            .whereField("timestamp", isGreaterThanOrEqualTo: Timestamp(date: startDate))
            .getDocuments { snapshot, error in
                if error != nil {
                    // error handling
                    print(error!)
                    self.loadState = .oopsy
                } else {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            self.aggregateEmotionScores = ["anger": 0,
                                                           "disgust": 0,
                                                           "sadness": 0,
                                                           "joy": 0,
                                                           "surprise": 0,
                                                           "fear": 0]
                            self.aggregateEmotionScoresArray = []
                            
                            let length = Double(snapshot.documents.count)
                            if length == 0.0 {
                                self.aggregateEmotionScoresArray = [0, 0, 0, 0, 0, 0]
                                self.loadState = .loaded
                                return
                            }
                            for d in snapshot.documents {
                                var emotionScores = d["emotionScores"] as! Dictionary<String, Double>
                                // get sum of emotion scores for d
                                var sumEmotionScores: Double = 0
                                for (_, score) in emotionScores {
                                    sumEmotionScores += score
                                }
                                // find ratio of emotion score for each emotion in d
                                for (emotion, score) in emotionScores {
                                    emotionScores[emotion] = (score / sumEmotionScores)
                                }
                                // find sum of ratios of emotion scores from d
                                for (emotion, ratio) in emotionScores {
                                    self.aggregateEmotionScores[emotion]! += ratio
                                }
                            }
                            for (emotion, sumOfRatios) in self.aggregateEmotionScores {
                                self.aggregateEmotionScores[emotion] = sumOfRatios/length
                            }
                            let sorted = self.aggregateEmotionScores .sorted(by: <)
                            self.aggregateEmotionScoresArray = sorted.map { $0.value }
                            self.loadState = .loaded
                        }
                    }
                }
            }
    }
    
    func setFalse() {
        self.successfulEntryEmotion = false
    }
}
