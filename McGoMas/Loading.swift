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
    
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        VStack () {
            Text("Loading Logs...").font(.largeTitle)
            LottieView(filename: "dumbell", closure: $closure, loopMode: .autoReverse).frame(width:200, height: 200)
        }
        .onAppear() {
            self.userSession.databasePull { success in
                if (success) { //We are ready to dismiss.
                    //Wrap up the animation nicely
                    self.closure = self.dismissWhenDone(done:)
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
