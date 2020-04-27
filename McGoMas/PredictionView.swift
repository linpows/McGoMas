//
//  PredictionView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/20/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Foundation

struct PredictionView: View {
    @State private var dateToDisplay = minPredictionDate
    
    func getPredictionBar(pred: Prediction, currentDate: Date) -> some View {
        return AnyView(HStack {
            if (Calendar.current.isDate(pred.dateTime, inSameDayAs:currentDate) == true) {
                Text("\(predictionTimeFormatter.string(from: pred.dateTime))")
                Rectangle().fill(Color.blue).frame(width: CGFloat(pred.prediction) / 3, height: 10)
                Text(" \(pred.prediction)")
            }
        })
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                DatePicker(selection: $dateToDisplay, in:minPredictionDate...maxPredictionDate, displayedComponents: .date) {
                    Text("")
                }
                
                Text("Predicted occupancy on \(dateToDisplay, formatter: predictionDateFormatter)")
                ForEach(predictions, id: \.self) { pred in
                    self.getPredictionBar(pred: pred, currentDate: self.dateToDisplay)
                }
            }.padding(.leading, 10)
        }
    }
}
struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
