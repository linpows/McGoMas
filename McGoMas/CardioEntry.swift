//
//  AddEntryView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Combine

struct CardioEntry: View {
    //Cardio entries have 3 main metrics: date completed, distance covered, time elapsed
    @State private var date: Date = Date()
    
    let unitSelection = ["miles", "meters", "kilometers"]
    @State private var distance: String = ""
    @State private var unitPicked: Int = 0
    @State private var time: Double = 0.0
    
    //MUST have instantiated model.cardio
    @ObservedObject var model: CardioModel

    
    var body: some View {
        VStack () {
            Form {
                Section(header: Text("Workout Date")) {
                    DatePicker("Workout Date", selection: $date)
                    .labelsHidden()
                }
                
                Section(header: Text("Distance")) {
                    NumericTextField(label: "Distance", enteredText: $distance)
                    Picker("Unit", selection: $unitPicked) {
                        ForEach( 0 ..< unitSelection.count) { index in
                            Text(self.unitSelection[index]).tag(index)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("Time Elapsed")) {
                    //Use "totalTimeInMinutes" to retrieve entered time
                    TimeTextField()
                }
            }
            .onAppear() {
                let truthSource = self.model.cardio!
                self.time = truthSource.time ?? 0.0
                self.distance = truthSource.distance?.description ?? ""
                self.unitPicked = self.unitSelection.firstIndex(of: truthSource.distanceUnit ?? "") ?? 0
                self.date = truthSource.date
            }
            .onDisappear() {
                self.model.setDate(newDate: self.date)
                self.model.setTime(newTime: self.time)
                self.model.setUnit(newUnit: self.unitSelection[self.unitPicked])
                self.model.setDistance(newDistance: Double(self.distance) ?? 0.0)
            }
        }
        
    }
    
    enum DistanceUnit: Int {
        case meters, miles, kilometers
    
        var stringRep: String {
            switch self {
                case DistanceUnit.meters:
                    return "meters"
                case DistanceUnit.miles:
                    return "miles"
                case DistanceUnit.kilometers:
                    return "kilometers"
            }
        }
        
    }
}

struct CardioEntry_Previews: PreviewProvider {
    static var previews: some View {
        let practiceModel = CardioModel()
        practiceModel.createCardio(withType: WorkoutType.bike)
        practiceModel.setDistance(newDistance: 10.0)
        return CardioEntry(model: practiceModel)
    }
}
