//
//  LoginView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase


struct LoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var errAlert = false
    @State private var errorTxt: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(){
                // Page title
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20.0)
            }
            Divider()
            
            //User text entry
            CustomTextEntry(label: "Email", entryPrompt: "Enter your email", isSecure: false, enteredText: $email)
            CustomTextEntry(label: "Password", entryPrompt: "Enter your password", isSecure: true, enteredText: $password)
            
            //Push the login credentials to the top
            Spacer()
            
            //Interactive button to submit credentials
            Button(
                action: {
                    self.attemptSignIn(email: self.email, password: self.password) {
                        (authUser: Firebase.User?) in
                        if authUser != nil { //Success in signin, have a user
                            //dismiss to home screen
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else { //No user was signed in
                            self.errAlert = true
                        }
                    }
                },
                label: {
                    Text("Go")
                        .font(.title)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(GradientButtonStyle())
            .alert(isPresented: $errAlert) {
                //Unable to sign user in, alert to issue
                Alert(title: Text("Error!"), message: Text(self.errorTxt), dismissButton: .default(Text("Ok")))
            }
            
        }
    }
    

    //Will execute the given callback function with a valid user object or nil
    func attemptSignIn(email: String, password: String, callback: @escaping (Firebase.User?) -> ()) {
        //Have Firebase attempt to retrieve a user with the given password/email
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            if let error = error { //Error encountered in signin
                self.errorTxt = error.localizedDescription
                callback(nil)
            }
            else if user != nil  {
                callback(user?.user)
            }
            else {
                callback(nil)
            }
        }
        
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
