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
    @State private var showError: Bool = false
    
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var logs: UserLogList
    let ref = Database.database().reference()
    
    @State private var selection: Int = 0
    private var types = ["Cardio", "Weights"]
    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView().environmentObject(self.logs), isActive: $showAdd) {
                    EmptyView()
                }
                Picker("Log Type", selection: $selection) {
                    ForEach( 0 ..< types.count) { index in
                        Text(self.types[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                if (self.selection == 0) {
                    CardioListView().environmentObject(self.logs)
                }
                else {
                    WeightListView().environmentObject(self.logs)
                }
                Spacer()
                Button (
                    action: {
                        let cardioSave = self.logs.cardioLogs.filter({ cardio in
                            cardio.pushToDB
                        })
                        
                        for cardio in cardioSave {
                            self.userSession.uploadCardio(workout: cardio)
                            cardio.pushToDB = false //updated
                        }
                        
                        
                        let weightSave = self.logs.weightLogs.filter({ weight in
                            weight.pushToDB
                        })
                        
                        for weight in weightSave {
                            self.userSession.uploadWeight(workout: weight)
                            weight.pushToDB = false //updated
                        }
                        
                    },
                    label: {
                        Text("Save Changes")
                    }
                )
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Oops"), message: Text("Sign in to access this functionality"), dismissButton: .default(Text("Ok")))
            }
            .navigationBarTitle("Your Log")
            .navigationBarItems(trailing:
                Button(
                    action: {
                        if (self.userSession.user == nil) {
                            self.showError = true;
                        }
                        else {
                            self.showAdd = true;
                        }
                    },
                    label: {
                        Image(systemName: "plus.square.fill")
                            .font(.largeTitle)
                            .padding(.top, 20)
                        .foregroundColor(chicagoMaroon)
                        
                    }
                )
            )
        }
    }
}


struct LoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        let cardioModels: [CardioModel] = [CardioModel(), CardioModel()]
        cardioModels.forEach({
            $0.createCardio(withType: WorkoutType.swim, date: Date(), distance: 10.0, distanceUnit: "mile", time: 60.0)
        })
        return  LoggingHomeView().environmentObject(UserLogList(cardioModels: cardioModels, weightModels: []))
    }
}
