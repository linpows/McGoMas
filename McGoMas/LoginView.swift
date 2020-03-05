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


class SignInAttempt: ObservableObject {
    @Published var attemptMessage = ""
}

struct LoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var successAlert = false
    @State private var errAlert = false
    @State private var errorTxt: String = ""
    @State private var successTxt: String = ""
    @State private var attempt = false
    
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
                        if let user = authUser {
                            self.successAlert = true //Success in signin
                            let doubleCheckEmail: String! = user.email
                            self.successTxt = "User with email " + doubleCheckEmail + " signed in."
                        }
                        else {
                            self.errAlert = true
                        }
                        self.attempt = true
                    }
                },
                label: {
                    Text("Go")
                        .font(.title)
                        .fontWeight(.bold)
                }
            )
            .buttonStyle(GradientButtonStyle())
            .alert(isPresented: $attempt) {
                if successAlert {
                    return Alert(title: Text("Success!"), message: Text(self.successTxt), dismissButton: .default(Text("Ok")))
                }
                else {
                    return Alert(title: Text("Error!"), message: Text(self.errorTxt), dismissButton: .default(Text("Ok")))
                }
            }
        }
    }
    

    func attemptSignIn(email: String, password: String, callback: @escaping (Firebase.User?) -> ()) {
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
