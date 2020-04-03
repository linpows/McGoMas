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
    @State private var displayName: String = ""
    @State private var email: String = ""
    @State private var picString: String = ""
    @State private var picURL: URL?
    @State private var commitErr: Bool = false
    @State private var errTxtArr: [String] = []
    
    var body: some View {
        //Also show User Info here, allow them to change it
        VStack () {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 200.0,height:200)
            
                Form {
                Section(header: Text("Profile Details")) {
                    TextField("Display Name", text: $displayName)
                        .textFieldStyle(TextEntryStyle())
                        .background(Color.init(UIColor.lightGray).opacity(0.5))
                        .cornerRadius(5.0)
                }
                Section(header: Text("Profile Credentials")) {
                    TextField("Email", text: $email)
                        .textFieldStyle(TextEntryStyle())
                        .background(Color.init(UIColor.lightGray).opacity(0.5))
                        .cornerRadius(5.0)
                        .keyboardType(.emailAddress)
                }
            }
            //Button onEditingChanged, enable
            Button (
                action: {
                    self.saveChanges()
                },
                label: {
                  Text("Save Profile Changes")
                }
            )
            Divider()
            Button(
                action: {
                    self.userSession.signOut()
                },
                label: {
                    Text("Sign Out")
                }
            )
            .buttonStyle(GradientButtonStyle())
            .alert(isPresented: $commitErr) {
                
                Alert(title: Text("Error!"), message: Text(self.errTxtArr[0]), dismissButton: .default(Text("Ok")))
            }
        }
        .onAppear() {
            self.email = self.userSession.user?.email ?? ""
            self.displayName = self.userSession.user?.name ?? ""
        }
    }

    func saveChanges() {
        userSession.updateProfileInfo(email: self.email, displayName: self.displayName) { error in
            if let error = error {
                self.commitErr = true;
                self.errTxtArr.append(error.localizedDescription)
            }
        }
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
