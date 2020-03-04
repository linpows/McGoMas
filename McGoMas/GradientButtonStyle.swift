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
private var chicagoMaroon = Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100)
private var hokieStone = Color.init(Color.RGBColorSpace.sRGB, red: 117.0 / 255, green: 120.0 / 255, blue: 123.0 / 255, opacity: 100)
//Gradient for the button
private var maroonGradient = Gradient(colors: [chicagoMaroon, hokieStone])

// Custom styling for our buttons
// Rounded edge with gradient color background
struct GradientButtonStyle: ButtonStyle {
    //Define a function that styles a plain button and returns the styled
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth:0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: maroonGradient, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50)
            .padding(.horizontal, 25)
            //When user presses on button, will appear smaller in a "push down" effect.
            //Returns to normal on release
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
