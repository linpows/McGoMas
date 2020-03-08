//
//  ContentView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase


extension AnyTransition {
    static var shrinkFade: AnyTransition {
        AnyTransition.scale.combined(with: .opacity)
    }
}

struct ExperimentView: View {
    @State private var splash = true
    
    var body: some View {
        ZStack {
            Button(
                action: {
                    withAnimation(.easeOut(duration: 2)) {
                        self.splash = false
                    }
                },
                    label: {
                        Text("toggle").hidden()
                }
            ).zIndex(10.0)
            if (splash) {
                SplashView().transition(.shrinkFade)
            }
            else{
                NavView()
            }
        }
    }
}

struct NavView: View {
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
            self.view = AnyView(LogoutView())
        }
        else {
            self.text = Text("Sign In Now.")
            self.view = AnyView(LoginView())
        }
    }
}

struct SplashView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var gradientStart: UnitPoint = .leading
    @State private var gradientEnd: UnitPoint = .trailing
    @State private var  colorOne: Color = Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100);
    @State private var colorTwo: Color = Color.init(Color.RGBColorSpace.sRGB, red: 207.0 / 255, green: 69.0 / 255, blue: 32.0 / 255, opacity: 100)
    
    var body: some View {
        VStack(alignment: .center) {
           RoundedRectangle(cornerRadius: 7.0)
                .fill(LinearGradient(gradient: Gradient(colors: [self.colorTwo, self.colorOne]), startPoint: self.gradientStart, endPoint: self.gradientEnd))
                   .frame(width: 200, height: 256, alignment: .center)
                    .scaleEffect(self.animationAmount)
                   .overlay(
                        Text("Let's Go").foregroundColor(.black)
                            .font(.system(size: 25.0, weight: .semibold, design: .default))
                    
                    )
           }
           .onAppear() {
                withAnimation (.easeIn(duration: 1.5)) {
                    self.animationAmount = 3
                    self.gradientEnd = UnitPoint(x: 0, y: 1)
                    self.gradientStart = UnitPoint(x: 1, y: 0)
                }
           }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.gray)
        }
}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
    }
}
