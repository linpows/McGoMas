//
//  SwiftUIView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

struct LogoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var toggle: LogInOutToggle
    
    var body: some View {
        VStack() {
            Text("You are signed in")
                .padding(.bottom, 25)
                .font(.system(size: 40.0, weight: .semibold, design: .default))
            Divider()
            Button(
                action: {
                    do {
                        try Auth.auth().signOut()
                        self.toggle.loggedIn = false
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
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}
