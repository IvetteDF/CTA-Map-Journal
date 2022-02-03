//
//  EmotionDataViewModel.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/2/22.
//

import Foundation

class EmotionDataViewModel: ObservableObject {
    
    @Published var emotionScores: EmotionScores = EmotionScores(anger: 0, disgust: 0, sadness: 0, joy: 0, surprise: 0, fear: 0)
    
    func getEmotionScores(entry: String) {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "x-rapidapi-host": "twinword-emotion-analysis-v1.p.rapidapi.com",
            "x-rapidapi-key": APIKey
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
//                let checker = String(data: emotionData!, encoding: .utf8)
//                print(checker!)
            }
        }
        dataTask.resume()
    }
    
    func decodeEmotionData(httpData: Data) {
        let decoder = JSONDecoder()
        if let emotionData = try? decoder.decode(EmotionData.self, from: httpData) {
            print(emotionData)
            // output this
//            EmotionData(emotion_scores: CTA_Map_Journal.EmotionScores(anger: 0.0, disgust: 0.0, sadness: 0.0, joy: 0.1128855543936164, surprise: 0.03413678713931377, fear: 0.0))
        }
    }
}
