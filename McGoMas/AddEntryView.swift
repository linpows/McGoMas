//
//  AddEntryView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase


struct AddEntryView: View {
    var workoutTypes = WorkoutTypeArr.init().arrWithDefault
    @State private var selectedType = 0
    @State private var type: WorkoutType? = nil
    @State private var date: Date = Date()
    
    @State private var alert = false
    @State private var show = false

    @EnvironmentObject var user: UserSession
    
    var body: some View {
        VStack () {
            Text("Workout Mode").font(.title)
                .frame(height: 50.0)
                .frame(minWidth:0, maxWidth: .infinity)
                .background(hokieStone)
                .cornerRadius(5.0)
                .padding(.horizontal)
                
            Picker("Type", selection: $selectedType) {
                ForEach(0 ..< workoutTypes.count) {
                    Text(self.workoutTypes[$0]).tag([$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .labelsHidden()
            
            
            Text("Workout Date").font(.title)
            .frame(height: 50.0)
            .frame(minWidth:0, maxWidth: .infinity)
            .background(hokieStone)
            .cornerRadius(5.0)
            .padding(.horizontal)
            
            DatePicker("Date", selection: $date)
            .padding()
            .labelsHidden()
            
            
            Button(
                action: {
                    if (self.selectedType == 0) {
                        self.alert = true
                    }
                    else { //All other values indicate a selection
                        self.type = WorkoutType(rawValue: self.selectedType)
                        
                        if (self.type! == WorkoutType.weights) {
                            let model = WeightModel()
                            model.createWeight()
                            model.changeDate(newDate: self.date)
                            
                            self.user.logs.weightLogs.append(model)
                            self.user.logs.editingWeightInstance = model
                            
                        }
                        else {
                            let model = CardioModel()
                            model.createCardio(withType: self.type!)
                            model.setDate(newDate: self.date)
                            
                            self.user.logs.cardioLogs.append(model)
                            self.user.logs.editingCardioInstance = model
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
            Spacer()
        }
        .sheet(isPresented: $show) {
            return EntryForm(formType: self.$type).environmentObject(self.user)
        }
    }
}

struct EntryForm: View {
    @Binding var formType: WorkoutType?
    
    @EnvironmentObject var user: UserSession
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack () {
            if (self.formType == WorkoutType.weights) {
                WeightEntry().environmentObject(self.user.logs)
            }
            else {
                CardioEntry().environmentObject(self.user.logs)
            }
            Spacer()
            HStack () {
                Button(
                    action: {
                        //Dismiss to logging home view
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Done").font(.title)
                    }
                ).buttonStyle(GradientButtonStyle())
                
                Button( //Cancel button, discard current workout
                    action: {
                        if (self.formType == WorkoutType.weights) {
                            let cancelled = self.user.logs.editingWeightInstance
                            if let cancelled = cancelled {
                                cancelled.removeWeight()
                            }
                            self.user.logs.weightLogs.removeAll(where: { weight in
                                weight.weight == nil
                            })
                            //self.modelStorage.editingWeightInstance = nil
                        }
                        else {
                            let cancelled = self.user.logs.editingCardioInstance
                            if let cancelled = cancelled {
                                cancelled.removeCardio()
                            }
                            
                            self.user.logs.cardioLogs.removeAll(where: { cardio in
                                cardio.cardio == nil
                            })
                            self.user.logs.editingCardioInstance = nil
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Cancel").font(.title)
                    }
                ).buttonStyle(AltGradientButtonStyle())
            }
        }
        .navigationBarTitle("New \(self.formType?.stringRep ?? "") Entry")
    }
}


struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        return AddEntryView().environmentObject(UserSession())
    }
}
