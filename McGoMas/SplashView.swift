//
//  SplashView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/14/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI


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

