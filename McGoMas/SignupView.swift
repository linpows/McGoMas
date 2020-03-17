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
    @State private var password: String = ""
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
            
            //Push the login credentials to the top
            Spacer()
            
            Button(
                action: {
                    self.attemptSignUp(email: self.email, password: self.password) {
                        (authUser: Firebase.User?) in
                        if authUser != nil { //Success in signup, have a user
                            //dismiss to home screen
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else { //No user was created
                            self.errAlert = true
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
        }
    }
    
    func attemptSignUp(email: String, password: String, callback: @escaping (Firebase.User?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if err != nil { //Something went wrong
                self.errorMsg = err!.localizedDescription
                callback(nil)
            }
            if let user = result?.user { //Success
                callback(user)
            }
            else {
                callback(nil)
            }
        }
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
