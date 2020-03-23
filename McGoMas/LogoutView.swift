//
//  SwiftUIView.swift
//  McGoMas
//  A button that facilitates a signout
//  Created by Mikayla Richardson on 3/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSession: UserSession
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        //Also show User Info here, allow them to change it
        VStack () {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Display Name", text: $firstName)
                        .textFieldStyle(TextEntryStyle())
                        .background(Color.init(UIColor.lightGray).opacity(0.5))
                    .cornerRadius(5.0)
                }
            }
            //Button onEditingChanged
            Button (
                action: {
                    //SAVE user info in firebase
                },
                label: {
                  Text("Save Profile Changes")
                }
            )
            Button(
                action: {
                    self.userSession.signOut()
                },
                label: {
                    Text("Sign Out")
                }
            )
            .buttonStyle(GradientButtonStyle())
        }
    }
    
    func saveChanges() {
        var user = Auth.auth().currentUser
        if let currUser = user {
            
        }
        else {
            //No user logged in, return
            print("Error! No user signed in.")
            return;
        }
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
