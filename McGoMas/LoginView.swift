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
    @EnvironmentObject var user: UserSession;
    
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
                    self.user.signIn(email: self.email, password: self.password) { (res, err) in
                        if let err = err {
                            self.errAlert = true
                            self.errorTxt = err.localizedDescription
                        }
                        else {
                            self.presentationMode.wrappedValue.dismiss()
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
            .padding(.bottom, 50.0)
            
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
