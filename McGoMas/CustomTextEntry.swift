//
//  CustomTextEntry.swift
//  McGoMas
//  Provides styling for TextFields. Supports both normal and secure text fields

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
    let bigFont = Font.system(size: 25.0, weight: .semibold, design: .default)
    @Binding var enteredText: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.label)
                .font(bigFont)
                
            HStack() {
                if self.isSecure {
                    SecureField(self.entryPrompt, text: $enteredText) {
                        //Resign keyboard on "enter"
                            UIApplication.shared.endEditing()
                    }
                        .textFieldStyle(TextEntryStyle())

                }
                else {
                    TextField(self.entryPrompt, text: $enteredText){
                        //Resign keyboard on "enter"
                            UIApplication.shared.endEditing()
                    }
                        .textFieldStyle(TextEntryStyle())
                }

            }
            
        }.padding(.horizontal, 15)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TextEntryStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(.all)
                .background(Color.init(UIColor.lightGray).opacity(0.5))
                .cornerRadius(5.0)
        }
}
