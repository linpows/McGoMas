//
//  LoggingHomeView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct LoggingHomeView: View {
    @State private var showAdd: Bool = false
    @EnvironmentObject var userSession: UserSession
    @State private var dummyData: [Swim] = [
        Swim(id: ObjectIdentifier(Swim.Type.self), distance: 500.0, time: TimeInterval(30.00)),
        Swim(id: ObjectIdentifier(Swim.Type.self), distance: 700.0, time: TimeInterval(60.00))
    ]
    
    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView(), isActive: $showAdd) {
                    EmptyView()
                }
                ScrollView(Axis.Set.vertical, showsIndicators: true){

                        ForEach(self.dummyData, id: \.self) { item in
                            Text("Test")
                        }
                        //https://firebase.google.com/docs/database/ios/lists-of-data
                        //Query, get JSON, convert to array of workout objects
                        //Display in a List UI component
                    
                }
            }
            .navigationBarTitle("Your Log")
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
    
    func renderWorkout(jsonData: Decodable) {
        
    }
}


struct LoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoggingHomeView()
    }
}
