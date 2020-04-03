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
    @State private var selectedType = 0
    @State private var type: WorkoutType? = nil
    @State private var date: Date = Date()
    
    @State private var alert = false
    @State private var show = false
    
    @State var modelStore: LocalLogList
    @State var freshCardioModel: CardioModel = CardioModel()
    @State var freshWeightModel: WeightModel = WeightModel()
    
    
    var body: some View {
            VStack () {
                Text("Workout Mode").font(.title)
                    .frame(height: 50.0)
                    .frame(minWidth:0, maxWidth: .infinity)
                    .background(hokieStone)
                    .cornerRadius(5.0)
                    .padding()
                    
                Picker("Type", selection: $selectedType) {
                    ForEach(0 ..< workoutTypes.count) {
                        Text(self.workoutTypes[$0]).tag([$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .labelsHidden()
                
                
                Text("Workout Date").font(.title)
                .frame(height: 50.0)
                .frame(minWidth:0, maxWidth: .infinity)
                .background(hokieStone)
                .cornerRadius(5.0)
                .padding()
                
                DatePicker("Date", selection: $date)
                .padding()
                .labelsHidden()
                
                Spacer()
                
                Button(
                    action: {
                        if (self.selectedType == 0) {
                            self.alert = true
                        }
                        else { //All other values indicate a selection
                            self.type = WorkoutType(rawValue: self.selectedType)
                            
                            if (self.type! == WorkoutType.weights) {
                                self.freshWeightModel.createWeight()
                                self.freshWeightModel.changeDate(newDate: self.date)

                            }
                            else {
                                self.freshCardioModel.createCardio(withType: self.type!)
                                self.freshCardioModel.setDate(newDate: self.date)
                            }
                            
                            self.show = true
                        }
                    },
                    label: {
                        Text("Create").font(.title)
                    }
                )
                .padding()
                .buttonStyle(GradientButtonStyle())
                .alert(isPresented: $alert) {
                    //Unable to sign user in, alert to issue
                    Alert(title: Text("Error!"), message: Text("Please select a workout type."), dismissButton: .default(Text("Ok")))
                }
            }
            .sheet(isPresented: $show) {
                return EntryForm(formType: self.$type, cardioModel: self.freshCardioModel, weightModel: self.freshWeightModel, modelStorage: self.modelStore)
            }
    }
}

struct EntryForm: View {
    @Binding var formType: WorkoutType?
    @Environment(\.presentationMode) var presentationMode
    @State var cardioModel: CardioModel
    @State var weightModel: WeightModel
    @State var modelStorage: LocalLogList
    
    var body: some View {
        NavigationView () {
            VStack () {
                if (self.formType == WorkoutType.weights) {
                    WeightEntry(model: weightModel)
                }
                else {
                    
                    CardioEntry(model: cardioModel)
                }
                Spacer()
                HStack () {
                    Button(
                        action: {
                            /*
                             TODO: Save in local list/database
                             */
                            if (self.formType == WorkoutType.weights) {
                                //Store as weight workout
                                self.modelStorage.weightLogs.append(self.weightModel.weight!)
                            }
                            else {
                                //Store as cardio workout
                                self.modelStorage.cardioLogs.append(self.cardioModel.cardio!)
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {
                            Text("Save").font(.title)
                        }
                    ).buttonStyle(GradientButtonStyle())
                    Button(
                        action: {
                            if (self.formType == WorkoutType.weights) {
                                self.weightModel.removeWeight()
                            }
                            else {
                                self.cardioModel.removeCardio()
                            }
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
        let modelStore: LocalLogList = LocalLogList()
        return AddEntryView(modelStore: modelStore)
    }
}
