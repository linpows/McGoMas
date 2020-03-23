////
////  ContentView.swift
////  McGoMas
////
////  Created by Mikayla Richardson on 3/3/20.
////  Copyright © 2020 Capstone. All rights reserved.
////
//
//import SwiftUI
//import Firebase
//
//class LogInOutToggle: ObservableObject { //Allows re-rendering if a sign-in state changes
//    @Published var loggedIn = false
//}
//
//extension AnyTransition { //Provides splash screen custom transition
//    static var shrinkNFade: AnyTransition {
//        AnyTransition.scale.combined(with: .opacity)
//    }
//}
//
//struct HomeView: View {
//    @State private var splash = true
//    @ObservedObject var toggle = LogInOutToggle()
//
//    
//    var body: some View {
//        ZStack {
//            Button(
//                action: {
//                    withAnimation(.easeOut(duration: 1.25)) {
//                        self.splash = false
//                    }
//                },
//                    label: { //When user presses the overlayed "Let's Go", triggers animation
//                        Text("A Hidden Button").hidden()
//                }
//            ).zIndex(10.0)
//            if (splash) {
//                SplashView().transition(.shrinkNFade)
//            }
//            else { //Display either a sign-in or sign-out screen
//                NavView().environmentObject(toggle)
//            }
//        }
//        .onAppear() { //When this first loads, initialize the boolean properly
//            if Auth.auth().currentUser != nil {
//                self.toggle.loggedIn = true;
//            }
//            else {
//                self.toggle.loggedIn = false;
//            }
//        }
//    }
//}
//
//struct NavView: View { //Navigation view wrapping around sign-in/up views
//    @EnvironmentObject var toggle: LogInOutToggle
//    
//    var body: some View {
//        NavigationView {
//            VStack() {
//                if (toggle.loggedIn) { //Give logged in user option to log out
//                    VStack() {
//                        Text("Hello " + (Auth.auth().currentUser!.email ?? ""))
//                        NavigationLink(destination: LogoutView().environmentObject(toggle)) {
//                            Text("Logout")
//                        }
//                    }
//                }
//                else { //Give un-authenticated user option to sign in or sign up
//                    signInUp().environmentObject(toggle)
//                }
//            }
//            .navigationBarTitle("Welcome")
//        }
//        
//    }
//}
//
//struct signInUp: View {
//    @State private var signup: Int? = 0
//    @State private var login: Int? = 0
//    @EnvironmentObject var toggle: LogInOutToggle
//    
//    var body: some View {
//            VStack() {
//                //Navigation links will listen/navigate based on button clicks and not their view body
//                NavigationLink(destination: SignupView(), tag: 1, selection: $signup) {
//                    EmptyView()
//                }
//                NavigationLink(destination: LoginView().environmentObject(toggle), tag: 1, selection: $login) {
//                    EmptyView()
//                }
//                Button(
//                    action: { //If pressed, trigger navigation to Login Page
//                        self.signup = 0
//                        self.login = 1
//                    },
//                    label: {
//                        Text("Login")
//                    }
//                ).buttonStyle(GradientButtonStyle())
//                
//                Divider()
//                
//                Button(
//                   action: { //If pressed, trigger navigation to Signup Page
//                        self.signup = 1
//                        self.login = 0
//                   },
//                   label: {
//                       Text("Signup")
//                   }
//                ).buttonStyle(GradientButtonStyle())
//            }
//        }
//}
//
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
