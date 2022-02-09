//
//  EmotionChartView.swift
//  CTA-Map-Journal
//
//  Created by Ivette Fernandez on 2/4/22.
//

import SwiftUI

struct EmotionChartView: View {
    @ObservedObject var emotionDataModelView = EmotionDataViewModel()
    public let values: [Double]
    public var colors: [Color]
    public let names: [String]
    
    public var backgroundColor: Color
    public var innerRadiusFraction: CGFloat
    
    var slices: [EmotionSliceData] {
        var endDeg: Double = 0
        var tempSlices: [EmotionSliceData] = []
        
        for (i, value) in values.enumerated() {
            // my span will just be 360 * the ratio
            let degrees: Double = value * 360
            tempSlices.append(EmotionSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100), color: self.colors[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                ZStack {
                    ForEach(0..<self.values.count) { i in
                        EmotionSliceView(emotionSliceData: self.slices[i])
                    }
                    .frame(width: geometry.size.width, height: 0.32 * geometry.size.width)
                    
//                    Circle()
//                        .fill(self.backgroundColor)
//                        .frame(width: geometry.size.width * innerRadiusFraction, height: geometry.size.width * innerRadiusFraction)
                }
                Text("Mood")
                EmotionChartRows(colors: self.colors, names: self.names, values: self.values.map { String($0) }, percents: self.values.map {String(format: "%.0f%%", $0 * 100)})
                    .foregroundColor(Color.black)
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.black)
        }
    }
}

struct EmotionChartView_Previews: PreviewProvider {
    static var previews: some View {
        // my values passed in will be the emotion ratios
        EmotionChartView(values: [0.26475899291069993, 0.029184726665766533, 0.029140916889612543, 0.8637116558308374, 0.09292698462437327, 0.05361005641204363], colors: [Color.purple, Color("CTAGreen"), Color("CTAYellow"), Color("CTARed"), Color("CTABlue"), Color("CTAOrange")], names: ["anger", "disgust", "fear", "joy", "sadness", "surprise"], backgroundColor: Color.white, innerRadiusFraction: 0.2)
    }
}


struct EmotionChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count){ i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                        
                    Text(self.names[i])
                        .foregroundColor(Color.black)
                        
                    Spacer()
                    Text(self.percents[i])
                            .foregroundColor(Color.gray)
                }
                .padding(.horizontal, 10.0)
                
                
            }
        }
    }
}
