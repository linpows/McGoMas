//
//  SignupView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/9/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @EnvironmentObject var userSession: UserSession
    @State private var password: String = ""
    @State private var confirmpassword: String = ""
    @State private var email: String = ""
    @State private var errorMsg: String = ""
    @State private var errAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(){
            // Page title
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20.0)
        
            Divider().padding(.bottom, 30)
        
            //User text entry
            CustomTextEntry(label: "Email", entryPrompt: "Enter your email", isSecure: false, enteredText: $email)
            Divider().padding(.bottom, 20)
            CustomTextEntry(label: "Password", entryPrompt: "Enter your password", isSecure: true, enteredText: $password)
            CustomTextEntry(label: "Confirm Password", entryPrompt: "Enter your password", isSecure: true, enteredText: $confirmpassword)
            
            //Push the login credentials to the top
            Spacer()
            
            Button(
                action: {
                    if (self.password != self.confirmpassword) {
                        self.errAlert = true
                        self.errorMsg = "Passwords do not match."
                    }
                    else {
                        self.userSession
                            .signUp(email: self.email, password: self.password) { (res, err) in
                                if let res = res {
                                    //Success
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                else {
                                    let error = err!
                                    self.errAlert = true
                                    self.errorMsg = error.localizedDescription
                                }
                        }
                    }
                },
                label: {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(GradientButtonStyle())
                .padding(.bottom, 50)
            .alert(isPresented: $errAlert) {
                //Unable to sign user in, alert to issue
                Alert(title: Text("Error!"), message: Text(self.errorMsg), dismissButton: .default(Text("Ok")))
            }
            
            Button (
                action: {
                    self.presentationMode.wrappedValue.dismiss()
                },
                label: {
                  Text("Cancel")
                }
            )
        }
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
