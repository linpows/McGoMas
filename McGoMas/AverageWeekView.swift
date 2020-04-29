//
//  AverageWeekView.swift
//  McGoMas
//
//  Created by Swopnil Joshi on 4/27/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

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

struct AverageWeekView: View {
    var body: some View {
        NavigationView { // check if date is in range
            List {
                HStack {
                    Text("Monday")
                        .frame(width: 100) // frame ensures bars start evenly
                    
                    Rectangle().fill(getColor(pred: weekAverage[0])).frame(width: CGFloat(weekAverage[0]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                    //Text(" \(weekAverage[0])") //don't need to know exact prediction
                }
                HStack {
                    Text("Tuesday")
                        .frame(width: 100) // frame ensures bars start evenly
                    
                    Rectangle().fill(getColor(pred: weekAverage[1])).frame(width: CGFloat(weekAverage[1]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                    //Text(" \(weekAverage[1])") //don't need to know exact prediction
                }
                HStack {
                    Text("Wednesday")
                        .frame(width: 100) // frame ensures bars start evenly
                    
                    Rectangle().fill(getColor(pred: weekAverage[2])).frame(width: CGFloat(weekAverage[2]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                    //Text(" \(weekAverage[2])") //don't need to know exact prediction
                }
                HStack {
                    Text("Thursday")
                        .frame(width: 100) // frame ensures bars start evenly
                    
                    Rectangle().fill(getColor(pred: weekAverage[3])).frame(width: CGFloat(weekAverage[3]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                    //Text(" \(weekAverage[3])") //don't need to know exact prediction
                }
                HStack {
                    Text("Friday")
                        .frame(width: 100) // frame ensures bars start evenly
                    
                    Rectangle().fill(getColor(pred: weekAverage[4])).frame(width: CGFloat(weekAverage[4]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
                    //Text(" \(weekAverage[4])") //don't need to know exact prediction
                }
                WeekendView()
            }
            .navigationBarTitle(Text("Average Week"))
        }
    }
}

// weird bug with too many HStacks? this is a workaround
struct WeekendView: View {
    @ViewBuilder
    var body: some View {
        HStack {
            Text("Saturday")
                .frame(width: 100) // frame ensures bars start evenly
            
            Rectangle().fill(getColor(pred: weekAverage[5])).frame(width: CGFloat(weekAverage[5]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
            //Text(" \(weekAverage[5])") //don't need to know exact prediction
        }
        HStack {
            Text("Sunday")
                .frame(width: 100) // frame ensures bars start evenly
            
            Rectangle().fill(getColor(pred: weekAverage[6])).frame(width: CGFloat(weekAverage[6]) / 1.5 + 2, height: 10) // +2 so <=0 predictions aren't empty
            //Text(" \(weekAverage[6])") //don't need to know exact prediction
        }
    }
}

struct AverageWeekView_Previews: PreviewProvider {
    static var previews: some View {
        AverageWeekView()
    }
}
