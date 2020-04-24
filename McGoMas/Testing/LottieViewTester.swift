//
//  LottieViewTester.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/23/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieViewTester: View {
    @State var name = "dumbell"
    @State var mode: LottieLoopMode = .autoReverse
    @State var speed: CGFloat = CGFloat(1.0)
    @State var closure: ((Bool) -> Void)? = nil
    @State var text: String = ""
    
    var body: some View {
        VStack {
            LottieView(closure: $closure, loopMode: $mode, filename: self.name, speed: CGFloat(Double(self.speed)))
            Text(self.text)
            
            HStack {
                
                Spacer()
                Button("Close up") {
                    self.mode = LottieLoopMode.playOnce
                    self.closure = self.close(doneAnimating:)
                }
                Spacer()

                
            }

        }
    }
    
    func close(doneAnimating: Bool) {
        if doneAnimating {
            self.text = "Done!"
        }
    }
}

struct LottieViewTester_Previews: PreviewProvider {
    static var previews: some View {
        LottieViewTester()
    }
}
