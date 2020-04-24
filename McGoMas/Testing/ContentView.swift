//
//  ContentView.swift
//  BeerTest
//
//  Created by Keenan Rebera on 4/23/20.
//  Copyright © 2020 Keenan Rebera. All rights reserved.
//

import SwiftUI
import Lottie

class Frames: ObservableObject {
    let beerFrames = [(0,48),(49, 57), (58, 67), (68, 77), (78, 87), (88, 97), (98, 110), (150, 195)]
    
    @Published var start: Int
    @Published var end: Int
    private var myIdx: Int = 0
    
    init() {
        start = beerFrames[myIdx].0
        end = beerFrames[myIdx].1
    }
    
    func stepUp() {
        self.myIdx += 1
        start = beerFrames[myIdx].0
        end = beerFrames[myIdx].1
    }
    
    func stepDown() {
        self.myIdx -= 1
        start = beerFrames[myIdx].0
        end = beerFrames[myIdx].1
    }
}

struct ContentView: View {
    @State var beers = 0
    @State var circleScale : Double = 0
    
    @ObservedObject var frames = Frames()

    @State var direction: CGFloat = 1.0
    
    @State var model: LottieModel = LottieModel(loopMode: .playOnce, speed: 1.0, playSubsection: true, start: 0, end: 48)
    
    func scaleCircle() {
        circleScale = 1
    }
    
    var body: some View {
        VStack{
//            Spacer()
//            ZStack {
//                Circle().fill(Color(hue: 0.6, saturation: 0.38, brightness: 0.95)).offset(x: 25, y: 17).scaleEffect(CGFloat(circleScale)).animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 1.0))
            LottieView(filename: "beer", model: self.$model)
//            }.frame(width: 300, height: 300)
//            Spacer()
            Text("\(beers) beers in cart").font(.title).padding(.bottom, 20)
            HStack {
            Spacer()
            Button("+") {
                    if (self.beers < 6) {
                        self.beers += 1
                        self.frames.stepUp()
                        self.model.startFrame = self.frames.start
                        self.model.endFrame = self.frames.end
                        self.direction = 1
                }
            }
                Spacer()
            
            Button("-") {
                if(self.beers > 0) {
                    self.frames.stepDown()
                    self.model.startFrame -= 1
                    self.model.endFrame = self.frames.end
                    self.direction = -1
               }
            }
                Spacer()
        }
            
            /*Stepper("", onIncrement: {
                if(self.beers < 6) {
                    self.beers = self.beers + 1
                    self.direction = 1
                    self.beerIndex = self.beers
                    self.startFrame = self.beerFrames[self.beerIndex].0
                    self.endFrame = self.beerFrames[self.beerIndex].1
                }
            }, onDecrement: {
                if(self.beers > 0) {
                    self.beers = self.beers - 1
                    self.direction = -1
                    self.beerIndex = self.beers
                    self.startFrame = self.beerFrames[self.beerIndex].0
                    self.endFrame = self.beerFrames[self.beerIndex].1
                }
            }).padding(.leading, 50).padding(.trailing, 50)*/
            Spacer()
        }//.onAppear(perform: scaleCircle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
