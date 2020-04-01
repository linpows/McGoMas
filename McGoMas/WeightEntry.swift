//
//  WeightEntry.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/1/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

class SetOfSets: ObservableObject {
    @Published var sets: [WeightSet] = []
}

struct WeightEntry: View {
    //Weight Entries have completion dates and 1 or more sets
    @State private var date: Date = Date()
    //Set currently displayed for editing
    @State private var editingInstance = SetEntry()
    //Given model we will be storing changes in
    @ObservedObject var model: WeightModel
    //Sets within this workout model
    @ObservedObject var setEntries = SetOfSets()
    
    var body: some View {
        VStack() {
            Form {
                Section(header: Text("Workout Date")) {
                    DatePicker("Workout Date", selection: $date)
                    .labelsHidden()
                }
                
                Section(
                    header:
                    HStack () {
                        Text("New Set")
                        Spacer()
                        Button(
                            action: {
                                let creation = self.editingInstance.saveEntry()
                                self.setEntries.sets.append(creation)
                                self.editingInstance = SetEntry()
                            },
                            label: {
                                Text("Save Set")
                            }
                        )
                    }
                ) {
                    self.editingInstance
                }
            }

            NavigationView {
                SetList(mySets: self.setEntries)
                .navigationBarTitle("Recorded Sets")
            }
        }
    }
}

struct SetList: View {
    @ObservedObject var mySets: SetOfSets
    
    var body: some View {
        List {
            SetRow(set: WeightSet(weightName: "Deadlifts", weight: 20.0, weightUnit: "pounds", repetitions: 2))
        }
    }
    
    struct SetRow: View {
        var set: WeightSet
        
        var body: some View {
            HStack() {
                Text(set.weightName)
            }
        }
    }
}

struct SetEntry: View {
    //Set entries have 3 metrics: weight lifted, number of lifts, name of the weight
    let unitOptions = ["pounds", "kilograms"]
    @State private var unitPicked: Int = 0
    @State private var name: String = ""
    @State private var mass: String = ""
    @State private var reps: Int = 0
    
    var body: some View {
        VStack () {
            CustomTextEntry(label: "", entryPrompt: "Weight Name", isSecure: false, enteredText: $name)
            HStack () {
                NumericTextField(label: "Weight Lifted", enteredText: $mass)
                    .padding()
                Picker("Unit", selection: $unitPicked) {
                    ForEach( 0 ..< unitOptions.count) { index in
                        Text(self.unitOptions[index]).tag(index)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            }
            Stepper("\(self.reps)  Repetitions", value: $reps).padding()
            NumericTextField(label: "Mass Lifted", enteredText: $mass).padding()
        }
    }
    
    func saveEntry() -> WeightSet {
        //Create set from entered values
        let set: WeightSet = WeightSet(weightName: self.name, weight: Double(self.mass) ?? 0.0, weightUnit: self.unitOptions[self.unitPicked], repetitions: self.reps)
        
        return set
        
    }
}

struct WeightEntry_Previews: PreviewProvider {
    static var previews: some View {
        let model = WeightModel()
        let inNavView = NavigationView {
            WeightEntry(model: model)
        }
        return inNavView
    }
}
