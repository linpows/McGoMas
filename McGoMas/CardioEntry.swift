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
    //Cardio entries have 2 main metrics: distance covered, time elapsed
    let unitSelection = ["mi", "m", "km"]
    @State private var distance: String = ""
    @State private var unitPicked: Int = 0
    @State private var time: Double = 0.0
    
    //MUST have instantiated model.cardio
    @ObservedObject var model: CardioModel

    
    var body: some View {
        VStack () {
            Form {
                Section(header: Text("Workout Details")) {
                    HStack () {
                        NumericTextField(label: "Distance", enteredText: $distance)
                        Picker("Unit", selection: $unitPicked) {
                            ForEach( 0 ..< unitSelection.count) { index in
                                Text(self.unitSelection[index]).tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    TimeTextField()
                }
            }
            .onAppear() {
                let truthSource = self.model.cardio!
                self.time = truthSource.time ?? 0.0
                self.distance = truthSource.distance?.description ?? ""
                self.unitPicked = self.unitSelection.firstIndex(of: truthSource.distanceUnit ?? "") ?? 0
            }
            .onDisappear() {
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
