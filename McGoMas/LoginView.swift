//
//  LoginView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var password: String = ""
    @State private var email: String = ""
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
            CustomTextEntry(label: "Email", entryPrompt: "Enter your email", isSecure: false, enteredText: $email)
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
                    Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
                        if let caughtError = err {
                            Alert(title: Text("Error"), message:
                                Text(caughtError.localizedDescription), dismissButton: .default(Text("OK")))
                        }
                        else {
                            Alert(title: Text("Success"), message:
                                Text("success"), dismissButton: .default(Text("OK")))
                        }
                    }
            }
                
        }
    
    }
}

func attemptSignIn(email: String, pass: String) -> Alert? {
    var alert: Alert = Alert(title: Text("empty"), message:
    Text("empty"), dismissButton: .default(Text("empty")))
    
    Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
        if let caughtError = err {
            alert = Alert(title: Text("Error"), message:
                Text(caughtError.localizedDescription), dismissButton: .default(Text("OK")))
        }
        else {
            alert = Alert(title: Text("Success"), message:
                Text("success"), dismissButton: .default(Text("OK")))
        }
    }
    return alert
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
