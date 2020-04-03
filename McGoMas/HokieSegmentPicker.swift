//
//  HokieSegmentPicker.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct HokieSegmentPicker: View {
    @State var picker: Picker<Text, Int, Text>
    
    init(forPicker: Picker<Text, Int, Text>) {
        //Maroon with white text when selected
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 99.0 / 255, green: 0, blue: 49.0 / 255, alpha: 1)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        //Maroon text white white background for unselected
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(red: 99.0 / 255, green: 0, blue: 49.0 / 255, alpha: 1)], for: .normal)
        
        self.picker = forPicker
    
    
    var body: some View {
        self.picker
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct HokieSegmentPicker_Previews: PreviewProvider {
    static var previews: some View {
        @State var selection: Int = 0
        let picker: Picker<Text, Int, Text> =
            Picker(selection: $selection, label: Text("")) {
            Text("Active").tag(0).foregroundColor(Color.white)
            Text("Completed").tag(1)
        
        return HokieSegmentPicker()
    }
}
