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


class LocalLogList: ObservableObject {
    @Published var cardioLogs: [CardioModel.Cardio] = []
    @Published var weightLogs: [WeightModel.Weight] = []
}

struct LoggingHomeView: View {
    @State private var showAdd: Bool = false
    
    @EnvironmentObject var userSession: UserSession
    //Observes multiple additions
    @ObservedObject var logs: LocalLogList = LocalLogList()

    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView(modelStore: self.logs), isActive: $showAdd) {
                    EmptyView()
                }
                ForEach(logs.cardioLogs, id: \.self.id) { log in
                    Group {
                        Text("Received log with following CARDIO data:")
                        Text("Date:")
                        Text(log.date.description)
                        Text("Distance:")
                        Text(log.distance?.description ?? "")
                        Text("Time in Minutes:")
                        Text(log.time?.description ?? "")
                        Divider()
                    }
                }
                ForEach(logs.weightLogs, id: \.self.id) { log in
                    Group {
                        Text("Received log with following WEIGHT data:")
                        Text("Date:")
                        Text(log.dayCompleted.description)
                        Text("Sets:")
                        ForEach(log.sets) { set in
                            Text(set.getStrRep())
                        }
                        Divider()
                    }
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
