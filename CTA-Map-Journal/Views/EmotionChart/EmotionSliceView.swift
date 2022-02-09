//
//  EmotionSliceView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/4/22.
//

import SwiftUI

struct EmotionSliceView: View {
    var emotionSliceData: EmotionSliceData
    
    var midRadians: Double {
            return Double.pi / 2.0 - (emotionSliceData.startAngle + emotionSliceData.endAngle).radians / 2.0
        }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    
                    let center = CGPoint(x: width * 0.5, y: height * 0.5)
                    
                    path.move(to: center)
                    
                    path.addArc(
                        center: center,
                        radius: width * 0.4,
                        startAngle: Angle(degrees: -90.0) + emotionSliceData.startAngle,
                        endAngle: Angle(degrees: -90.0) + emotionSliceData.endAngle,
                        clockwise: false)
                }
                .fill(emotionSliceData.color)
                
//                Text(emotionSliceData.text)
//                    .position(
//                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
//                        y: geometry.size.height * 0.2 * CGFloat(1.0 - 0.78 * sin(self.midRadians))// - geometry.size.height * 0.2
//                    )
//                    .foregroundColor(Color.black)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct EmotionSliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct EmotionSliceView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionSliceView(emotionSliceData: EmotionSliceData(
            startAngle: Angle(degrees: 0.0),
            endAngle: Angle(degrees: 220.0),
            text: "65%",
            color: Color.black))
    }
}
