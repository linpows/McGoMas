//
//  ContentView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase





struct HomeView: View {
    @State private var text: Text = Text("")
    @State private var view: AnyView?
    
    
    var body: some View {
        NavigationView {
            VStack() {
                NavigationLink(destination: self.view) {
                    self.text
                }
            }
            .onAppear() {
                self.buildNavLink(user: Auth.auth().currentUser)
            }
        }
    }
    
    func buildNavLink(user: User?){
        if let user = Auth.auth().currentUser {
            self.text = Text("Hello " + (user.email ?? ""))
            self.view = AnyView(SwiftUIView())
        }
        else {
            self.text = Text("Sign In Now.")
            self.view = AnyView(LoginView())
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
