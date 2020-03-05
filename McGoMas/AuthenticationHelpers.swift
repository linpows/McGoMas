//
//  AuthenticationHelpers.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth

//Ensure user has entered a valid email
//For login/register purposes
func validateEmail(email: String) -> Bool {
    
    
    return false;
}

//Ensure user has entered a valid password.
//For registering purposes only
func validatePassword(password: String) -> Bool {
    return false
}

//attempt to sign a user in.
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
