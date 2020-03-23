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
    @EnvironmentObject var user: UserSession
    
    var body: some View {
        VStack() {
            if (user.user != nil) {
                //User signed in, display their info and give chance to logout
                Text("Welcome " + (user.user!.name ?? user.user!.email))
                LogoutView().environmentObject(user)
            }
            else { //User not signed in. Display log in view
                LoginView().environmentObject(user)
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
            SignupView().environmentObject(self.user)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
