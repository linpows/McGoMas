//
//  LandingView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase

extension AnyTransition { //Provides splash screen custom transition
    static var shrinkFade: AnyTransition {
        AnyTransition.scale.combined(with: .opacity)
    }
}

struct LandingView: View {
    @State private var splash = true
    @EnvironmentObject var userSession: UserSession
    
    func getCurrUser () { //Subscribe to changes in user
        userSession.listen()
    }
    
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
                MainTabView().environmentObject(userSession)
            }
        }
        .onAppear(perform: getCurrUser)
    }
}

struct MainTabView: View {
    @EnvironmentObject var user: UserSession
    
    var body: some View {
        TabView {
            AuthView()
                .environmentObject(user)
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
            CalendarView()
                .tabItem {
                    VStack () {
                        Image(systemName: "3.circle")
                        Text("Calendar")
                    }
            }.tag(4)
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
