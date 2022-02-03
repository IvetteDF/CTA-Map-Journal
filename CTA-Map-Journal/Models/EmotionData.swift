//
//  EmotionData.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/2/22.
//

import Foundation
import SwiftUI

struct EmotionData: Decodable {
    let emotion_scores: EmotionScores
}

struct EmotionScores: Decodable {
    let anger: Double
    let disgust: Double
    let sadness: Double
    let joy: Double
    let surprise: Double
    let fear: Double
}
