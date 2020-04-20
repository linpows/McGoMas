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
    @State private var ratios: [Double] = [0.0, 0.0, 0.0]
    @State private var totals: [Double] = [0.0, 0.0, 0.0]
    
    @State private var idxTapped = -1
    @State private var isTapped = false
    
    @State private var pickerSelection = 0
    
    var body: some View {
        VStack() {
            //Bring this to the front only when a bar/rectangle is hovered over
            if (self.isTapped) {
                Text(String(format: "%.2f", self.totals[self.idxTapped]) + (self.pickerSelection == 0 ? " miles " : " minutes ") + "completed.").font(.title).padding().multilineTextAlignment(.center)
            }
            else {
                Text("Click a bar to learn more.").font(.title).padding().multilineTextAlignment(.center)
            }
            
            MinuteMilePicker(selection: $pickerSelection.onChange({ index in
                return withAnimation(Animation.spring()) {
                    self.ratio(unitSelection: index)
                }
            }))
            
            HStack(alignment: .bottom, spacing: 0) {
                ForEach(0 ..< self.cardioTypes.count) { idx in
                    GeometryReader { geometry in
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                            Rectangle().fill(chicagoMaroon)
                                .frame(width: geometry.size.width * 0.90, height: geometry.size.height * CGFloat(self.ratios[idx]), alignment: .bottom)
                                .overlay(
                                    Rectangle()
                                        .stroke(burntOrange, lineWidth: self.idxTapped == idx ? 5 : 0)
                                        .blur(radius: self.idxTapped == idx ? 2 : 0)
                                )
                                .onTapGesture {
                                    if (!self.isTapped || idx != self.idxTapped) {
                                        //Bring to focus detail on this bar
                                        self.idxTapped = idx
                                        self.isTapped = true
                                    }
                                    else {
                                        //Else the user has re-tapped the same rectangle to dismiss
                                        self.isTapped = false
                                        self.idxTapped = -1
                                    }
                                    
                                }
                            Text(self.cardioTypes[idx].stringRep)
                        }
                        .frame(width: geometry.size.width, height: nil, alignment: .top)
                    }
                    Divider()
                }
            }
            .onAppear {
                self.ratio(unitSelection: 0)
            }
        }
    }
    
    private func ratio(unitSelection: Int) {
        var sum = 0.0 //Sum of all miles completed in cardio
        for i in 0 ..< self.cardioTypes.count {
            if (unitSelection == 0) {
                //track total miles for specific types
                totals[i] = self.sumCardioMiles(forType: self.cardioTypes[i])
            }
            else {
                totals[i] = self.sumCardioMins(forType: self.cardioTypes[i])
            }
            
            //Keep running sum for ALL types
            sum += totals[i]
        }
        //Calculate percentage attributes to each type of workout
        if (sum > 0.0) { //Guard against divide by zero error
            ratios = totals.map { $0 / sum }
        }
    }
    
    private func sumCardioMins(forType: WorkoutType) -> Double {
        let specificType = user.logs.cardioLogs.filter { cardio in
            //Find only entries attributed to the specific type
            cardio.cardio != nil && cardio.cardio!.workoutType == forType
        }
        
        //Convert model distances to an array of MILE distances
        let mins = specificType.reduce(0.0, {$0 + ($1.cardio!.time ?? 0.0)})
        
        return mins
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
