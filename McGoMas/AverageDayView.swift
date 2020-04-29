//
//  AverageDayView.swift
//  McGoMas
//
//  Created by Swopnil Joshi on 4/27/20.
//  Copyright © 2020 Capstone. All rights reserved.
//
import SwiftUI

struct AverageDayView: View {
    func getPredictionBar(pred: Prediction) -> some View {
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
            ZStack {
                Rectangle().fill(color).frame(width: 13, height: CGFloat(pred.prediction))
                if pred.prediction > 30 {
                    Text("\(pred.prediction)").font(.system(size: 7)).rotationEffect(.degrees(90)).foregroundColor(.black).fixedSize(horizontal: true, vertical: false)
                }
            }
            Text("\(predictionTimeFormatter.string(from: pred.dateTime))").font(.system(size: 7)).rotationEffect(.degrees(90)).fixedSize(horizontal: true, vertical: false)
        })
    }
    
    var body: some View {
        NavigationView { // check if date is in range
            VStack {
                HStack (alignment: .bottom) {
                    ForEach(averagePredictions, id: \.id) { pred in //render predictions
                        self.getPredictionBar(pred: pred)
                    }
                }
                
                Divider()
                
                Text("Time of Day").padding(.bottom, 30)
            }
            .navigationBarTitle(Text("Average Day"))
        }
    }
}

struct AverageDayView_Previews: PreviewProvider {
    static var previews: some View {
        AverageDayView()
    }
}