//
//  CustomTextEntry.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/4/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI


struct CustomTextEntry: View {
    //What the user is inputting
    var label: String
    var entryPrompt: String
    var isSecure: Bool
    @Binding var enteredText: String
    
    var body: some View {
        HStack {
            Text(self.label)
                .font(.system(size: 25.0, weight: .semibold, design: .default))
                .padding(.horizontal, 10)
                
            VStack {
                if self.isSecure {
                    SecureField(self.entryPrompt, text: $enteredText)
                        .textFieldStyle(TextEntryStyle())

                }
                else {
                    TextField(self.entryPrompt, text: $enteredText)
                        .textFieldStyle(TextEntryStyle())
                }

            }.padding(.trailing, 10)
            
        }
    }
    
    
}


struct TextEntryStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(.vertical, 10)
        }
}
