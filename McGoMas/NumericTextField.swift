//
//  NumericTextField.swift
//  McGoMas
//  Sanitizes entered text to be just numbers
//  Created by Mikayla Richardson on 3/29/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct NumericTextField: View {
    @State var label: String
    @Binding var enteredText: String
    let validChars: String = "0123456789."
    
    var body: some View {
        TextField(label, text: $enteredText)
            .keyboardType(.numberPad)
            .onReceive(Just(enteredText)) { typedValue in
                //Filter out any non-valid characters
                let sanitized = typedValue.filter { self.validChars.contains($0) }
                self.enteredText = sanitized
        }
        .textFieldStyle(TextEntryStyle())
    }
}
