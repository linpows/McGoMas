//
//  Weekly.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/19/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct Weekly: View {
    @EnvironmentObject var user: UserSession
    @State private var weeklyDistance: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @State private var weeklyRatio: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @State private var dayName: [String] = ["", "", "", "", "", "", ""]
    
    @State private var idxTapped = -1
    @State private var isTapped = false
    
    var body: some View {
        VStack() {
            //Bring this to the front only when a bar/rectangle is tapped
            if (self.isTapped) {
                Text(String(format: "%.2f", self.weeklyDistance[self.idxTapped]) + " miles").font(.title).padding().multilineTextAlignment(.center)
            }
            else {
                Text("Click a bar to learn more.").font(.title).padding().multilineTextAlignment(.center)
            }
            
            HStack(alignment: .bottom, spacing: 0.0) {
                ForEach(0 ..< self.weeklyDistance.count) { idx in
                    GeometryReader { geometry in
                        VStack (spacing: 0.0) {
                            Spacer()
                                .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                            Rectangle()
                                .fill(burntOrange)
                                .overlay(
                                    Rectangle()
                                        .stroke(chicagoMaroon, lineWidth: self.idxTapped == idx ? 5 : 0)
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
                                .frame(width: geometry.size.width / 2.0, height: geometry.size.height * CGFloat(self.weeklyRatio[idx]), alignment: .bottom)
                            Text(self.dayName[idx])
                        }
                    }
                }
                .onAppear {
                    self.compute()
                }
            }
        }
    }
    
    private func compute() {
        let currDay = Date()
        let nameFinder = DateFormatter()
        
        for day in 0...6 {
            //Find a reference date for 0, 1, 2, ..., 6 days previous
            var component = DateComponents()
            component.day = day * -1
            let prevDate = Calendar.current.date(byAdding: component, to: currDay)!
            
            //Fill in most recent day in the last slot and work backwards
            self.weeklyDistance[6 - day] = allMiles(onDate: prevDate)
            
            //Fill in which data corresponds to which day of the week
            self.dayName[6 - day] = nameFinder.weekdaySymbols[Calendar.current.component(.weekday, from: prevDate) % 7]
        }
        
        //Compute ratio
        let totalWeek = self.weeklyDistance.reduce(0.0, {$0 + $1})
        if (totalWeek > 0.0) { //Guard against divide by zero
            for idx in 0...6 { //Find ratio of single day's distance : week distance
                self.weeklyRatio[idx] = self.weeklyDistance[idx] / totalWeek
            }
        }
    }
    
    //Calculate all the miles occuring on the day
    private func allMiles(onDate: Date) -> Double {
        //Find all non-nil, same day cardio (compared to "onDate")
        let sameDayCardio = self.user.logs.cardioLogs.filter { cardio in
            cardio.cardio != nil &&
                Calendar.current.isDate(onDate, equalTo: cardio.cardio!.date, toGranularity: .day)
        }
        
        //Convert model distances to an array of MILE distances
        let miles = sameDayCardio.map { (entry) -> Double in
            if (entry.cardio!.distanceUnit == "m") {
                return (entry.cardio!.distance ?? 0.0) / 1600.9 //1600.9 meters to the mile
            }
            if (entry.cardio!.distanceUnit == "km") {
                return (entry.cardio!.distance ?? 0.0) / 16.009 //16.009 kilometers to the mile
            }
            //Else in miles
            return (entry.cardio!.distance ?? 0.0)
            
        }
        
        //Sum and return
        return miles.reduce(0.0, {$0 + $1})
    }
}

struct Weekly_Previews: PreviewProvider {
    static var previews: some View {
        Weekly()
    }
}
