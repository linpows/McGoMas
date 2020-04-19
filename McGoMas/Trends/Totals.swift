//
//  Totals.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/19/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

//Totals: view how many miles run/swum/biked throughout log time
struct Totals: View {
    @EnvironmentObject var user: UserSession
    private var cardioTypes: [WorkoutType] = [WorkoutType.bike, WorkoutType.swim, WorkoutType.run]
    //Follow [bike, swim, run] pattern
    @State private var mileRatio: [Double] = [0.0, 0.0, 0.0]
    @State private var mileTotals: [Double] = [0.0, 0.0, 0.0]
    @State private var barFillColor = burntOrange
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(0 ..< self.cardioTypes.count) { idx in
                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        Spacer()
                            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                        Rectangle().fill(self.barFillColor)
                            .frame(width: geometry.size.width * 0.90, height: geometry.size.height * CGFloat(self.mileRatio[idx]), alignment: .bottom)
                            .onAppear() {
                                let spring = Animation.spring(response: 5, dampingFraction: 0.8, blendDuration: 0.7)
                                
                                return withAnimation(spring) {
                                    self.calcRatio()
                                    self.barFillColor = chicagoMaroon
                                }
                            }
                    
                        Text("\(self.cardioTypes[idx].stringRep)\n" + String(self.mileTotals[idx]) + " miles").padding().multilineTextAlignment(.center)
                    }
                    .frame(width: geometry.size.width, height: nil, alignment: .top)
                }
                Divider()
            }
        }
    }
    
    private func calcRatio() {
        var sum = 0.0 //Sum of all miles completed in cardio
        for i in 0 ..< self.cardioTypes.count {
            //Keep running sum of ALL miles for ALL types
            sum += self.sumCardioMiles(forType: self.cardioTypes[i])
            //Also track total miles for specific types
            mileTotals[i] = self.sumCardioMiles(forType: self.cardioTypes[i])
        }
        //Calculate percentage attributes to each type of workout
        if (sum > 0.0) { //Guard against divide by zero error
            mileRatio = mileTotals.map { $0 / sum }
        }
    }
    
    private func sumCardioMiles(forType: WorkoutType) -> Double {
        let specificType = user.logs.cardioLogs.filter { cardio in
            //Find only entries attributed to the specific type
            cardio.cardio != nil && cardio.cardio!.workoutType == forType
        }
        
        //Convert model distances to an array of MILE distances
        let miles = specificType.map { (entry) -> Double in
            if (entry.cardio!.distanceUnit == "m") {
                return (entry.cardio!.distance ?? 0.0) / 1600.9 //1600.9 meters to the mile
            }
            if (entry.cardio!.distanceUnit == "km") {
                return (entry.cardio!.distance ?? 0.0) / 16.009 //16.009 kilometers to the mile
            }
            //Else in miles
            return (entry.cardio!.distance ?? 0.0)
            
        }
        
        //Sum the miles for this type
        let mileSum = miles.reduce(0.0, {$0 + $1})
        
        return mileSum
    }
}

struct Totals_Previews: PreviewProvider {
    static var previews: some View {
        let user = UserSession()
        let run = CardioModel()
        run.createCardio(withType: WorkoutType.run)
        run.cardio!.distance = 10.0
        user.uploadCardio(workout: run)
        let view = Totals().environmentObject(user)
        return view
    }
}
