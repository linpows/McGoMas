//
//  LoggingHomeView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct LoggingHomeView: View {
    @State private var showAdd: Bool = false
    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView(), isActive: $showAdd) {
                    EmptyView()
                }
                Text("we will show user's workouts here")
                    .navigationBarTitle("Your Log")
            }
            .navigationBarItems(trailing:
                Button(
                    action: {
                        self.showAdd = true;
                    },
                    label: {
                        Image(systemName: "plus.square.fill")
                            .font(.largeTitle)
                            .padding(.top, 20)
                        .foregroundColor(Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100))
                        
                    }
                )
            )
        }
    }
}


struct LoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoggingHomeView()
    }
}
