//
//  AddEntryView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import FirebaseDatabase


struct AddEntryView: View {
    var workoutTypes = WorkoutTypeArr.init().arrWithDefault
    //Initialize workout date to current date
    @State private var selectedType = 0
    @State private var type: WorkoutType? = nil
    @State private var alert = false
    @State private var show = false
    
    @EnvironmentObject var user: UserSession;

    
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
                SpecificEntryForm(formType: self.$type, user: self.$user.user)
            }
    }
}

struct SpecificEntryForm: View {
    @Binding var formType: WorkoutType?
    @Binding var user: User?


    @Environment(\.presentationMode) var presentationMode
    var ref = Database.database().reference()
    
    var body: some View {
        VStack () {
            Text("You selected " + (formType?.stringRep ?? "default"))
            Spacer()
            
            
            
            HStack () {
                Button(
                    action: {
                        
                        self.ref.child("logs") // get logs database
                            .child(self.user!.userID) // gets all logs by current signed in user
                            .childByAutoId() // generates a new UUID for new log
                            .setValue(["date": Date().timeIntervalSince1970,
                                       "workoutType": self.formType?.stringRep ?? "default"]) // log details

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
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
