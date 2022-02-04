//
//  EmotionDataViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/2/22.
//

import Foundation
import SwiftUI
import Firebase

@MainActor class EmotionDataViewModel: ObservableObject {
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

    func getEmotionScores(title: String, entry: String, station_name: String, analyzeEmotion: Bool) {
        // should I make EmotionDataViewModel a subclass of JournalEntryViewModel ???
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
                print("I'm inside the getEmotionScores method")
                let httpData = data!
                self.decodeEmotionData(httpData: httpData)
                journalEntryViewModel.addJournalEntry(title: title, entry: entry, station_name: station_name, analyzeEmotion: true, emotionScores: self.emotionScores)
                // Ask Ansel what to do about this:
//                2022-02-03 15:10:42.418619-0600 CTA-Map-Journal[33634:4431016] [SwiftUI] Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
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
            // output this
//            EmotionData(emotion_scores: CTA_Map_Journal.EmotionScores(anger: 0.0, disgust: 0.0, sadness: 0.0, joy: 0.1128855543936164, surprise: 0.03413678713931377, fear: 0.0))
        }
    }
    
    func getEmotionDataForTrainStation (selectedTrainStation: String) {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("station_name", isEqualTo: selectedTrainStation)
            .whereField("analyzeEmotion", isEqualTo: true)
            .getDocuments { snapshot, error in
                if error != nil {
                    // error handling
                    print(error!)
                } else {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
//                            let emotionScores = snapshot.documents[0]["emotionScores"] as! Dictionary<String, Double>
//                            print(emotionScores["anger"]!)
                            let length = Double(snapshot.documents.count)
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
//                            print(self.aggregateEmotionScoresForTrainStation)
                        }
                    }
                }
            }
    }
    
    func getAllEmotionData() {
        let db = Firestore.firestore()
        db.collection("JournalEntries")
            .whereField("analyzeEmotion", isEqualTo: true)
            .getDocuments { snapshot, error in
                if error != nil {
                    // error handling
                    print(error!)
                } else {
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
//                            let emotionScores = snapshot.documents[0]["emotionScores"] as! Dictionary<String, Double>
//                            print(emotionScores["anger"]!)
                            let length = Double(snapshot.documents.count)
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
                            print(self.aggregateEmotionScores)
                        }
                    }
                }
            }
    }
}
