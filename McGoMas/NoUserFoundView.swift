//
//  NoUserFoundView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/3/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct NoUserFoundView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack () {
            Spacer()
            Text("Oops!")
                .font(.largeTitle)
            Spacer()
            Text("You are not signed in.")
                .font(.title)
                .padding()
            Text("Please navigate to the home screen and sign in to access the logging feature.")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .background(LinearGradient(gradient: maroonOrangeGradient, startPoint: .top, endPoint: .bottom))
    }
}

struct NoUserFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoUserFoundView()
    }
}
