//
//  GradientButtonStyle.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/4/20.
//  Copyright © 2020 Capstone. All rights reserved.

// TUTORIAL FOUND HERE: https://www.appcoda.com/swiftui-button-style-animation/
//

import Foundation
import SwiftUI

//Create color for chicago maroon, gray
let chicagoMaroon = Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100)
let darkMaroon = Color.init(Color.RGBColorSpace.sRGB, red: 30.0 / 255, green: 0, blue: 0.0 / 255, opacity: 100)

let hokieStone = Color.init(Color.RGBColorSpace.sRGB, red: 117.0 / 255, green: 120.0 / 255, blue: 123.0 / 255, opacity: 100)

let lightOrange: Color = Color.init(Color.RGBColorSpace.sRGB, red: 255.0 / 255, green: 192.0 / 255, blue: 77.0 / 255, opacity: 100)

let burntOrange: Color = Color.init(Color.RGBColorSpace.sRGB, red: 207.0 / 255, green: 69.0 / 255, blue: 32.0 / 255, opacity: 100)
//Gradient for the button
let maroonGradient = Gradient(colors: [chicagoMaroon, darkMaroon])
let orangeGradient = Gradient(colors: [lightOrange, burntOrange])
let maroonOrangeGradient = Gradient(colors: [chicagoMaroon, hokieStone, burntOrange])

// Custom styling for our buttons
// Rounded edge with gradient color background
struct GradientButtonStyle: ButtonStyle {
    //Define a function that styles a plain button and returns the styled
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth:0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: maroonGradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(50)
            .padding(.horizontal, 25)
            //When user presses on button, will appear smaller in a "push down" effect.
            //Returns to normal on release
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}


struct AltGradientButtonStyle: ButtonStyle { //Same, but alternate coloring
    //Define a function that styles a plain button and returns the styled
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth:0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: orangeGradient, startPoint: .top, endPoint: .bottom))
            .cornerRadius(50)
            .padding(.horizontal, 25)
            //When user presses on button, will appear smaller in a "push down" effect.
            //Returns to normal on release
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
