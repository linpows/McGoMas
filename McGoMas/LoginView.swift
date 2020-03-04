//
//  LoginView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var willShowAlert = false
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(){
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20.0)
            }
            Divider()
            CustomTextEntry(label: "Username", entryPrompt: "Enter your username", isSecure: false, enteredText: $username)
            CustomTextEntry(label: "Password", entryPrompt: "Enter your password", isSecure: true, enteredText: $password)
            //Push the login credentials to the top
            Spacer()
            Button(
                action: {
                    self.willShowAlert = true;
                },
                label: {
                    Text("Go")
                        .font(.title)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(GradientButtonStyle())
                .alert(isPresented: $willShowAlert) {
                    Alert(title: Text("!!!"), message: Text(username + ", I'm baby."), dismissButton: .default(Text("Boi, bye.")))
            }
                
        }
    
    }
}

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


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
