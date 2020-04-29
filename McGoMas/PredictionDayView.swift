//
<<<<<<< HEAD
//  CalendarDayView.swift
=======
//  PredictionDayView.swift
>>>>>>> 62ef60f6c54ecb7d1cf07004362c7cd0e470cece
//  McGoMas
//
//  Created by Swopnil Joshi on 4/25/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct PredictionDayView: View {
    private var date: Date // date to predict
    
    init(date: Date) {
        self.date = date
    }
    
    func getPredictionBar(pred: Prediction, currentDate: Date) -> some View {
        var color = Color.green
        switch pred.prediction { // color based on prediction
        case 0...75:
            color = Color.green
        case 76...150:
            color = Color.yellow
        case 151...225:
            color = Color.orange
        default:
            color = Color.red
        }
        return AnyView(HStack {
            if (Calendar.current.isDate(pred.dateTime, inSameDayAs:currentDate) == true) {
                Text("\(predictionTimeFormatter.string(from: pred.dateTime))")
                    .frame(width: 50) // frame ensures bars start evenly
                
                Rectangle().fill(color).frame(width: CGFloat(pred.prediction) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                //Text(" \(pred.prediction)") //don't need to know exact prediction
            }
        })
    }
    
    var body: some View {
        NavigationView {
            if (self.date <= maxPredictionDate && self.date >= minPredictionDate) { // check if date is in range
                List {
                    ForEach(predictions.drop {$0.dateTime < self.date}.prefix(19), id: \.id) { pred in //render predictions
                        self.getPredictionBar(pred: pred, currentDate: self.date)
                    }
                }
                .navigationBarTitle(getTextFromDate(date: self.date))
            }
            else { // not in range, predictions unavailable
                VStack (alignment: .center){
                Text("Sorry, predictions for this date are currently unavailable")
                }.font(.title)
                .navigationBarTitle(getTextFromDate(date: self.date))
            }
        }
    }
    
    // from CalendarDayView
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d"
        return date == nil ? "" : formatter.string(from: date)
    }
}

struct PredictionDayView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionDayView(date: minPredictionDate)
    }
}
