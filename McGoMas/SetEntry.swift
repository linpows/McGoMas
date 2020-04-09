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
    @EnvironmentObject var currentLoggedSets: SetArray
    
    //User-defined metrics: weight lifted, number of lifts, name of the weight
    let unitOptions = ["pounds", "kilograms"]
    @State private var unitPicked: Int = 0
    @State private var name: String = ""
    @State private var mass: String = ""
    @State private var reps: Int = 0
    
    //For field checking
    @State private var err: Bool = false
    @State private var errTxt: String = ""
        
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
            
            Stepper("\(self.reps)  Repetitions", value: $reps, in: 0...100).padding(.horizontal)
            Button(
                action: {
                    self.checkUserEntry()
                    
                    if (!self.err) {
                        let newSet = self.saveEntry()
                        self._currentLoggedSets.wrappedValue.addSet(set: newSet)
                        self.clearUserEntry()
                    }
                },
                label: {
                    Text("Save Set").bold().kerning(1.0).font(.system(size: 17.0))
                })
                .buttonStyle(GradientButtonStyle())
                .padding()
                .alert(isPresented: $err) {
                    Alert(title: Text("Invalid Entry"), message: Text(self.errTxt), dismissButton: .default(Text("Ok")))
                }
            Divider()
            SetList(mySets: self.currentLoggedSets).padding(.top, 0)
        }
    }
        
    private func saveEntry() -> WeightSet {
        //Create set from entered values
        let set: WeightSet = WeightSet(weightName: self.name, weight: Double(self.mass) ?? 0.0, weightUnit: self.unitOptions[self.unitPicked], repetitions: self.reps)
        
        return set
        
    }
    
    private func checkUserEntry() {
        if (self.name.count == 0) {
            self.errTxt = "Please enter a name for this type of set."
            self.err = true
        }
        if (self.mass.count == 0) {
            self.errTxt = "Please enter a weight for this set."
            self.err = true
        }
        if (self.reps == 0) {
            self.errTxt = "Please indicate at least one repetition for this set."
            self.err = true
        }
    }
    
    private func clearUserEntry() {
        //Revert to initialized state
        self.mass = ""
        self.reps = 0
        self.name = ""
        self.unitPicked = 0
    }
}
struct SetEntry_Previews: PreviewProvider {
    
    static var previews: some View {
        let setOne = WeightSet(weightName: "Dead Lift", weight: 20.0, weightUnit: "pounds", repetitions: 5)
        let setTwo = WeightSet(weightName: "Bicep Curl", weight: 50.0, weightUnit: "pounds", repetitions: 10)
        
        let displayed: SetArray = SetArray()
        displayed.addSet(set: setOne)
        displayed.addSet(set: setTwo)
        
        return SetEntry().environmentObject(displayed)
    }
}
