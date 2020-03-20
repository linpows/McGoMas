//
//  LandingView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

class Toggle: ObservableObject { //Allows re-rendering if a sign-in state changes
    @Published var userAuth = false
}

extension AnyTransition { //Provides splash screen custom transition
    static var shrinkFade: AnyTransition {
        AnyTransition.scale.combined(with: .opacity)
    }
}

struct LandingView: View {
    @State private var splash = true
    @ObservedObject var toggle = Toggle()
    
        var body: some View {
        ZStack {
            Button(
                action: {
                    withAnimation(.easeOut(duration: 1.25)) {
                        self.splash = false
                    }
                },
                    label: { //When user presses the overlayed "Let's Go", triggers animation
                        Text("A Hidden Button").hidden()
                }
            ).zIndex(10.0)
            if (splash) {
                SplashView().transition(.shrinkFade)
            }
            else { //Display either a sign-in or sign-out screen
                MainTabView().environmentObject(toggle)
            }
        }
        .onAppear() { //When this first loads, initialize the boolean properly
            if Auth.auth().currentUser != nil {
                self.toggle.userAuth = true;
            }
            else {
                self.toggle.userAuth = false;
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var toggle: Toggle
    
    var body: some View {
        TabView {
            AuthView()
                .environmentObject(toggle)
                .tabItem {
                    VStack () {
                        Image(systemName: "1.circle")
                        Text("Home")
                    }
            }.tag(1)
            LoggingHomeView()
                .tabItem {
                    VStack () {
                        Image(systemName: "2.circle")
                        Text("Log")
                    }
            }.tag(2)
            PredictionView()
                .tabItem {
                    VStack () {
                        Image(systemName: "3.circle")
                        Text("Traffic")
                    }
            }.tag(3)
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
