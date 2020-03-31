//
//  TimeTextField.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/30/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Combine

struct TimeTextField: View {
    @State private var hour: String = ""
    @State private var min: String = ""
    @State private var sec: String = ""
    let validChars = "1234567890"
    
    var body: some View {
        HStack () {
            TextField("Hours", text: $hour)
                .textFieldStyle(TextEntryStyle())
                .keyboardType(.numberPad)
                .onReceive(Just(hour)) { typedValue in
                        //Filter out any non-valid characters
                        let sanitized = typedValue.filter { self.validChars.contains($0)
                            
                        }
                        self.hour = sanitized
                }
            Text(":")
            TextField("Minutes", text: $min)
                .textFieldStyle(TextEntryStyle())
                .keyboardType(.numberPad)
                .onReceive(Just(min)) { typedValue in
                        //Filter out any non-valid characters
                        let sanitized = typedValue.filter { self.validChars.contains($0) }
                        self.min = sanitized
                }
            Text(".")
            TextField("Seconds", text: $sec)
                .textFieldStyle(TextEntryStyle())
                .keyboardType(.numberPad)
                .onReceive(Just(sec)) { typedValue in
                        //Filter out any non-valid characters
                        let sanitized = typedValue.filter { self.validChars.contains($0) }
                        self.sec = sanitized
                }
        }
    }
    
    func totalTimeInMinutes() -> Double {
        let hourSum: Double = (Double(self.hour) ?? 0.0) * 60.0
        let minSum: Double = Double(self.min) ?? 0.0
        let secSum: Double = (Double(self.sec) ?? 0.0) / 60.0
        return hourSum + minSum + secSum
    }
}

struct TimeTextField_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextField()
    }
}
