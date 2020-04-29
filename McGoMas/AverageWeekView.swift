//
//  AverageWeekView.swift
//  McGoMas
//
//  Created by Swopnil Joshi on 4/27/20.
//  Copyright © 2020 Capstone. All rights reserved.
//
import SwiftUI

private let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

private func getColor(pred: Double) -> Color {
    switch pred { // color based on prediction
    case 0...75:
        return Color.green
    case 76...150:
        return Color.yellow
    case 151...225:
        return Color.orange
    default:
        return Color.red
    }
}

private func getPredictionBar(pred: Double, day: Int) -> some View {
    return AnyView(VStack(alignment: .center) {
        ZStack {
            Rectangle().fill(getColor(pred: weekAverage[day])).frame(width: 30, height: CGFloat(weekAverage[day]))
            if weekAverage[day] > 30 {
                Text("\(Int(weekAverage[day]))").font(.system(size: 15)).rotationEffect(.degrees(90)).foregroundColor(.black).fixedSize(horizontal: true, vertical: false)
            }
        }
        Text("\(days[day])").font(.system(size: 10)).frame(width:48, height: 15)
    })
}

struct AverageWeekView: View {
    var body: some View {
        NavigationView { // check if date is in range
            VStack {
                HStack (alignment: .bottom) {
                    ForEach(0..<days.count) { i in
                        getPredictionBar(pred: weekAverage[i], day: i)
                    }
                }
                Divider()
                    
                Text("Day of the Week").padding(.bottom, 30)
            }
            .navigationBarTitle(Text("Average Week"))
        }
    }
}

struct AverageWeekView_Previews: PreviewProvider {
    static var previews: some View {
        AverageWeekView()
    }
}
