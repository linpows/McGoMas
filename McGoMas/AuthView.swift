//
//  AuthView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/20/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

struct AuthView: View { //Main authentication view
    @State private var signup: Bool = false
    @EnvironmentObject var toggle: Toggle
    
    var body: some View {
        VStack() {
            if (self.toggle.userAuth) {
                //User signed in, display their info and give chance to logout
                Text("Welcome " + (Auth.auth().currentUser!.email ?? ""))
                LogoutView().environmentObject(toggle)
            }
            else { //User not signed in. Display log in view
                LoginView().environmentObject(toggle)
                HStack () { //Give user option to create an account
                    Text("Not registered?")
                    Button(
                        action: {
                            self.signup = true;
                        },
                        label: {
                            Text("Create an account.")
                        }
                    )
                }
            }
        }.sheet(isPresented: $signup) { //Modal presentation
            SignupView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
