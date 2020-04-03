//
//  SetEntry.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/2/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

/**
 An entry form for a user to input set information
 */
struct SetEntry: View {
    // Array of logged sets to display in list
    @ObservedObject var currentLoggedSets: SetArray
    
    //User-defined metrics: weight lifted, number of lifts, name of the weight
    let unitOptions = ["pounds", "kilograms"]
    @State private var unitPicked: Int = 0
    @State private var name: String = ""
    @State private var mass: String = ""
    @State private var reps: Int = 0
        
    var body: some View {
        
            VStack() {
                CustomTextEntry(label: "", entryPrompt: "Weight Name", isSecure: false, enteredText: $name)
                
                HStack () {
                    NumericTextField(label: "Weight Lifted", enteredText: $mass)
                        .padding()
                    
                    Picker("Unit", selection: $unitPicked) {
                        ForEach( 0 ..< unitOptions.count) { index in
                            Text(self.unitOptions[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                
                Stepper("\(self.reps)  Repetitions", value: $reps).padding(.horizontal)
                Button(
                    action: {
                        let newSet = self.saveEntry()
                        self._currentLoggedSets.wrappedValue.addSet(set: newSet)
                        self.clearUserEntry()
                    },
                    label: {
                        Text("Save Set").bold().kerning(1.0).font(.system(size: 17.0))
                    }
                    ).buttonStyle(GradientButtonStyle())
                    .padding()
                Divider()
                SetList(mySets: self.currentLoggedSets).padding(.top, 0)
            
        }
    }
        
    func saveEntry() -> WeightSet {
        //Create set from entered values
        let set: WeightSet = WeightSet(weightName: self.name, weight: Double(self.mass) ?? 0.0, weightUnit: self.unitOptions[self.unitPicked], repetitions: self.reps)
        
        return set
        
    }
    
    func clearUserEntry() {
        //Revert to initialized state
        self.mass = ""
        self.reps = 0
        self.name = ""
        self.unitPicked = 0
    }
}

struct SetList: View {
    //Sets to display
    @ObservedObject var mySets: SetArray
    
    var body: some View {
        List(self.mySets.sets) { logSet in
            NavigationLink(destination: SetDetail(displayedSet: logSet)) {
                Text(logSet.weightName)
            }
        }
        .padding(0.0)
        
    }
    
    //Detail view of a logged set
    struct SetDetail: View {
        @State var displayedSet: WeightSet
        
        var body: some View {
            VStack () {
                Text(displayedSet.weightName).font(.largeTitle).bold()
                Divider()
                Spacer()
                HStack() {
                    Text("Weight Lifted: ").font(.title)
                    Text(String(displayedSet.weight)).font(.title).bold()
                    Text(displayedSet.weightUnit).font(.title)
                }.padding()
                HStack() {
                    Text("Number of Reps: ").font(.title)
                    Text(String(displayedSet.repetitions)).font(.title).bold()
                }
                Spacer()
            }
        }
    }
}

struct SetEntry_Previews: PreviewProvider {
    
    static var previews: some View {
        let setOne = WeightSet(weightName: "Dead Lift", weight: 20.0, weightUnit: "pounds", repetitions: 5)
        let setTwo = WeightSet(weightName: "Bicep Curl", weight: 50.0, weightUnit: "pounds", repetitions: 10)
        
        let displayed: SetArray = SetArray()
        displayed.addSet(set: setOne)
        displayed.addSet(set: setTwo)
        
        return SetEntry(currentLoggedSets: displayed)
    }
}
