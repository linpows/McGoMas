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
    // Editing instance houses the weight we are adding a set for
    @EnvironmentObject var models: UserLogList
    @Environment(\.presentationMode) var presentationMode
    @State var prepopulatedFields: WeightSet?
    @State var saveWillDismiss: Bool
    
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
                //Assure user have properly entered everything
                self.checkUserEntry()
                
                if (!self.err) { //Save as new set
                    let newSet = self.saveEntry()
                    self.models.editingWeightInstance!.weight!.sets.addSet(set: newSet)
                    self.clearUserEntry()
                }
                if (self.saveWillDismiss) {
                    self.presentationMode.wrappedValue.dismiss()
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
            
        }
        .onAppear() {
            if let filler = self.prepopulatedFields {
                //Fill in given info instead of defaults
                self.name = filler.weightName
                self.reps = filler.repetitions
                self.mass = String(filler.weight)
                switch (filler.weightUnit) {
                case "pounds":
                    self.unitPicked = 0
                case "kilograms":
                    self.unitPicked = 1
                default:
                    self.unitPicked = 0
                }
            }
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

        let weight = WeightModel()
        weight.createWeight()
        weight.addSet(name: "Dead Lift", mass: 20.0, massUnit: "pounds", reps: 5)
        
        
        let storage = UserLogList(cardioModels: [], weightModels: [weight])
        storage.editingWeightInstance = weight
        
        return SetEntry(prepopulatedFields: WeightSet(weightName: "Test", weight: 10.0, weightUnit: "pounds", repetitions: 2), saveWillDismiss: false).environmentObject(storage)
    }
}
