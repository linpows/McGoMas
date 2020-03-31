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
    //To see if we can retrieve an added/edited model
    @ObservedObject var testModel: CardioModel = CardioModel()
    
    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView(model: self.testModel), isActive: $showAdd) {
                    EmptyView()
                }
                if testModel.cardio !== nil {
                    Text("We have recieved the following Cardio Model:")
                    Text("Date:")
                    Text(self.testModel.cardio!.date.description)
                    Text("Distance:")
                    Text(self.testModel.cardio!.distance?.description ?? "")
                    Text("Time in Minutes:")
                    Text(self.testModel.cardio!.time?.description ?? "")
                    
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
