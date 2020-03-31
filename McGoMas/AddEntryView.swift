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
    
    @State var model: CardioModel
    
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
                            self.model.createCardio(withType: self.type!)
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
                return EntryForm(formType: self.$type, model: self.model)
            }
    }
}

struct EntryForm: View {
    @Binding var formType: WorkoutType?
    @Environment(\.presentationMode) var presentationMode
    @State var model: CardioModel
    
    var body: some View {
        NavigationView () {
            VStack () {
                CardioEntry(model: model)
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

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let model: CardioModel = CardioModel()
        return AddEntryView(model: model)
    }
}
