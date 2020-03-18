//
//  AddEntryView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct AddEntryView: View {
    var workoutTypes = ["Swim", "Bike", "Treadmill", "Weights"]
    //Initialize workout date to current date
    @State private var workoutDate = Date()
    @State private var selectedType = 0
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedType, label: Text("Workout Type")) {
                        ForEach(0 ..< workoutTypes.count) {
                            Text(self.workoutTypes[$0])
                        }
                    }
                }
                Section {
                    //Date of the workout
                    DatePicker(selection: $workoutDate, in: ...Date(), displayedComponents: .date) {
                        Text("Workout Date")
                    }
                }
            }.navigationBarTitle("Log Your Workout")
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
