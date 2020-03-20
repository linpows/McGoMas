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
    @EnvironmentObject var toggle: Toggle
    
    var body: some View {
        Button(
            action: {
                do {
                    try Auth.auth().signOut()
                    self.toggle.userAuth = false
                    self.presentationMode.wrappedValue.dismiss()
                } catch let signOutError as NSError {
                  print ("Error signing out: %@", signOutError)
                }
            },
            label: {
                Text("Sign Out")
            }
        )
        .buttonStyle(GradientButtonStyle())
    }
        
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
