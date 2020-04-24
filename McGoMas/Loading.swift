//
//  Loading.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/21/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Lottie

struct Loading: View {
    @Binding var isPresented: Bool
    @State var closure: ((Bool) -> Void)? = nil
    @State var loopMode: LottieLoopMode = .autoReverse
    
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        VStack () {
            Text("Loading Logs...").font(.largeTitle)
            LottieView(closure: $closure, loopMode: $loopMode, filename: "dumbell").frame(width:200, height: 200)
        }
        .onAppear() {
            if (self.userSession.user == nil) { //No user to pull logs for
                self.isPresented = false
            }
            else {
                self.userSession.databasePull { success in
                    if (success) { //We are ready to dismiss.
                        //Wrap up the animation nicely
                        self.loopMode = .playOnce
                        self.closure = self.dismissWhenDone(done:)
                    }
                }
            }
        }
    }
    
    func dismissWhenDone(done: Bool) {
        self.isPresented = false
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading(isPresented: Binding.constant(true))
    }
}
