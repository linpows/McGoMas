//
//  SwiftUIView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/20/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct MinuteMilePicker: View {
    @Binding var selection: Int
    @State private var units = ["distance", "time"]
    
    var body: some View {
        Picker("Unit", selection: $selection) {
            ForEach( 0 ..< units.count) { index in
                Image(self.units[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle()).padding()
    }
}

extension Binding { //Allows us to handle a change in picker selection
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: {self.wrappedValue},
            set: {selection in
                self.wrappedValue = selection
                handler(selection)
            }
        )
    }
}

