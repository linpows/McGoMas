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
    
    
    @State private var hour: String = ""
    @State private var min: String = ""
    @State private var sec: String = ""
    let validChars = "1234567890"
    
    func totalTimeInMinutes() -> Double {
        let hourSum: Double = (Double(self.hour) ?? 0.0) * 60.0
        let minSum: Double = Double(self.min) ?? 0.0
        let secSum: Double = (Double(self.sec) ?? 0.0) / 60.0
        return hourSum + minSum + secSum
    }
    
    //MUST have instantiated the editing instance in the list
    @EnvironmentObject var models: UserLogList

    
    var body: some View {
        VStack () {
            Form {
                Section() {
                    HStack () { //DISTANCE INPUT
                        NumericTextField(label: "Distance", enteredText: $distance)
                        Picker("Unit", selection: $unitPicked) {
                            ForEach( 0 ..< unitSelection.count) { index in
                                Text(self.unitSelection[index]).tag(index)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack () { //TIME INPUT
                        TextField("Hours", text: $hour)
                            .textFieldStyle(TextEntryStyle())
                            .keyboardType(.numberPad)
                            .onReceive(Just(hour)) { typedValue in
                                //Filter out any non-valid characters
                                let sanitized = typedValue.filter { self.validChars.contains($0) }
                                self.hour = sanitized
                            }
                        Text(":")
                        TextField("Minutes", text: $min)
                            .textFieldStyle(TextEntryStyle())
                            .keyboardType(.numberPad)
                            .onReceive(Just(min)) { typedValue in
                                //Filter out any non-valid characters
                                let sanitized = typedValue.filter { self.validChars.contains($0) }
                                self.min = sanitized
                            }
                        Text(":")
                        TextField("Seconds", text: $sec)
                            .textFieldStyle(TextEntryStyle())
                            .keyboardType(.numberPad)
                            .onReceive(Just(sec)) { typedValue in
                                //Filter out any non-valid characters
                                let sanitized = typedValue.filter { self.validChars.contains($0) }
                                self.sec = sanitized
                            }
                    }
                }
            }
            .onAppear() { //If editing, will fill fields in
                if let instance = self.models.editingCardioInstance {
                    
                    let minutes = instance.cardio?.time ?? 0.0
                    let hours: Int = Int(minutes / 60)
                    let remainingMinutes: Int = Int(minutes) % 60
                    let remainder = minutes.truncatingRemainder(dividingBy: 1.0)
                    var secs = remainder * 60.0
                    secs.round()
                    let seconds = Int(secs)
                    
                    self.hour = hours == 0 ? "" : String(hours)
                    self.min = remainingMinutes == 0 ? "" : String(remainingMinutes)
                    self.sec = seconds == 0 ? "" : String(seconds)
                    
                    switch (instance.cardio?.distanceUnit ?? "") {
                        case "mi":
                            self.unitPicked = 0
                        case "m":
                            self.unitPicked = 1
                        case "km":
                            self.unitPicked = 2
                        default:
                            self.unitPicked = 0
                    }
                    
                    if let distance = instance.cardio?.distance {
                        self.distance = distance.description
                    }
                }
            }
            .onDisappear() {
                if (self.models.editingCardioInstance != nil) { //if did not abandon entry, save it.
                    self.models.editingCardioInstance!.setTime(newTime: self.totalTimeInMinutes())
                    self.models.editingCardioInstance!.setUnit(newUnit: self.unitSelection[self.unitPicked])
                    self.models.editingCardioInstance!.setDistance(newDistance: Double(self.distance) ?? 0.0)
                }
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
        return CardioEntry().environmentObject(practiceModel)
    }
}
