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
        return AnyView(VStack(alignment: .center) {
            if (Calendar.current.isDate(pred.dateTime, inSameDayAs:currentDate) == true) {
                ZStack {
                    Rectangle().fill(Color.orange).frame(width: 13, height: CGFloat(pred.prediction) / 2)
                    if pred.prediction > 30 {
                        Text("\(pred.prediction)").font(.system(size: 7)).rotationEffect(.degrees(90)).foregroundColor(.white).fixedSize(horizontal: true, vertical: false)
                    }
                }
                Text("\(predictionTimeFormatter.string(from: pred.dateTime))").font(.system(size: 7)).rotationEffect(.degrees(90)).fixedSize(horizontal: true, vertical: false)
            }
        })
    }
    
    var body: some View {
        VStack (alignment: .center){
            HStack(){
                // Page title
                Text("Traffic")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 15.0)
                    .padding(.bottom, 20.0)
            }
            
            Divider()
            
            DatePicker("", selection: $dateToDisplay, in:minPredictionDate...maxPredictionDate, displayedComponents: .date)
            
            Divider()
            
            Spacer()
            
            HStack(alignment: .bottom) {
                ForEach(predictions, id: \.self) { pred in
                    self.getPredictionBar(pred: pred, currentDate: self.dateToDisplay)
                }
            }
            
            Divider()
            
            Text("Time of day").padding(.bottom, 30)
            
        }
    }
    
}
struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
