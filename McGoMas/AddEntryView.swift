//
//  AddEntryView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct AddEntryView: View {
    var workoutTypes = WorkoutTypeArr.init().arrWithDefault
    //Initialize workout date to current date
    @State private var workoutDate = Date()
    @State private var selectedType = 0
    @State private var type: WorkoutType? = nil
    @State private var alert = false
    @State private var show = false
    
    var body: some View {
            VStack () {
                Spacer()
                
                Text("Select Workout Mode").font(.largeTitle)
                Picker("Type", selection: $selectedType) {
                    ForEach(0 ..< workoutTypes.count) {
                        Text(self.workoutTypes[$0])
                    }
                }
                .labelsHidden()
               
                Spacer()
                
                Button(
                    action: {
                        if (self.selectedType == 0) {
                            self.alert = true
                        }
                        else { //All other values indicate a selection
                            self.type = WorkoutType(rawValue: self.selectedType)
                            self.show = true
                        }
                    },
                    label: {
                        Text("Create").font(.title)
                    }
                )
            }
            .buttonStyle(GradientButtonStyle())
            .alert(isPresented: $alert) {
                //Unable to sign user in, alert to issue
                Alert(title: Text("Error!"), message: Text("Please select a workout type."), dismissButton: .default(Text("Ok")))
            }
            .navigationBarTitle("Add New Workout")
            .sheet(isPresented: $show) {
                EntryForm(formType: self.$type)
            }
    }
}

struct EntryForm: View {
    @Binding var formType: WorkoutType?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView () {
            VStack () {
                CardioEntry()
                Spacer()
                HStack () {
                    Button(
                        action: {
                            /*
                             TODO: Save in local list/database
                             */
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Save").font(.title)
                        }
                    ).buttonStyle(GradientButtonStyle())
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Cancel").font(.title)
                        }
                    ).buttonStyle(AltGradientButtonStyle())
                }
            }.navigationBarTitle("New \(self.formType?.stringRep ?? "") Entry")
        }
    }
}

struct CardioEntry: View {
    //Cardio entries have 3 main metrics: date completed, distance covered, time elapsed
    @State private var date: Date = Date()
    @State private var distance: String = ""
    @State private var unitPicked = 0
    @State private var time: TimeInterval? = nil
    private var unitSelection = [DistanceUnit.miles, DistanceUnit.meters, DistanceUnit.kilometers]
    
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
                            Text(self.unitSelection[index].stringRep).tag(index)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("Time Elapsed")) {
                    //Use "totalTimeInMinutes" to retrieve entered time
                    TimeTextField()
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

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
