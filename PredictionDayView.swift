//
//  PredictionDayView.swift
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
        return AnyView(VStack(alignment: .center) {
            if (Calendar.current.isDate(pred.dateTime, inSameDayAs:currentDate) == true) {
                ZStack {
                    Rectangle().fill(color).frame(width: 13, height: CGFloat(pred.prediction) + 2)
                    if pred.prediction > 30 {
                        Text("\(pred.prediction)").font(.system(size: 7)).rotationEffect(.degrees(90)).foregroundColor(.black).fixedSize(horizontal: true, vertical: false)
                    }
                }
                Text("\(predictionTimeFormatter.string(from: pred.dateTime))").font(.system(size: 7)).rotationEffect(.degrees(90)).fixedSize(horizontal: true, vertical: false)
            }
        })
    }
    
    var body: some View {
        NavigationView {
            if (self.date <= maxPredictionDate && self.date >= minPredictionDate) { // check if date is in range
                VStack {
                    HStack (alignment: .bottom) {
                        ForEach(predictions.drop {$0.dateTime < self.date}.prefix(19), id: \.id) { pred in //render predictions
                            self.getPredictionBar(pred: pred, currentDate: self.date)
                        }
                    }
                    
                    Divider()
                    
                    Text("Time of Day").padding(.bottom, 30)
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
