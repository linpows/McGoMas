//
//  TypePicker.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/29/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct TypePicker: View {
    @State var typeOptions = ["All", "Swim", "Bike", "Run"]
    @Binding var typeSelection: Int
    
    var body: some View {
        Picker("Type", selection: $typeSelection) {
            ForEach( 0 ..< typeOptions.count) { index in
                Text(self.typeOptions[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle()).padding()
        
    }
}
