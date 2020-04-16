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
    @State private var showStats: Bool = false
    @State private var showError: Bool = false
    @State private var done: Bool = false
    
    @EnvironmentObject var userSession: UserSession
    let ref = Database.database().reference()
    
    @State private var selection: Int = 0
    private var types = ["Cardio", "Weights"]

    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView().environmentObject(self.userSession.logs), isActive: $showAdd) {
                    EmptyView()
                }
                NavigationLink(destination: LogGraphView().environmentObject(self.userSession), isActive: $showStats) {
                    EmptyView()
                }
                Picker("Log Type", selection: $selection) {
                    ForEach( 0 ..< types.count) { index in
                        Text(self.types[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding()
                Spacer()
                
                if (self.selection == 0) {
                    CardioListView().environmentObject(self.userSession).environmentObject(self.userSession.logs)
                }
                else {
                    WeightListView().environmentObject(self.userSession).environmentObject(self.userSession.logs)
                }
                Spacer()
                Button (
                    action: {
                        let cardioSave = self.userSession.logs.cardioLogs.filter({ cardio in
                            cardio.pushToDB //Push only the ones that need adding/updating
                        })
                        
                        for cardio in cardioSave {
                            self.userSession.uploadCardio(workout: cardio)
                            cardio.pushToDB = false //updated
                        }
                        
                        
                        let weightSave = self.userSession.logs.weightLogs.filter({ weight in
                            weight.pushToDB
                        })
                        
                        for weight in weightSave {
                            self.userSession.uploadWeight(workout: weight)
                            weight.pushToDB = false //updated
                        }
                        self.done = true
                    },
                    label: {
                        Text("Save Changes").font(.title)
                        .fontWeight(.bold)
                    }
                )
                .buttonStyle(GradientButtonStyle())
                .padding()
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Oops"), message: Text("Sign in to access this functionality"), dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $done) {
                Alert(title: Text("Success"), message: Text("Changes saved successfully."), dismissButton: .default(Text("Ok")))
            }
            .navigationBarTitle("Your Log")
            .navigationBarItems(
                leading:
                Button(
                    action: {
                        if (self.userSession.user == nil) {
                            self.showError = true;
                        }
                        else {
                            self.showStats = true;
                        }
                    },
                    label: {
                        Image(systemName: "chart.pie.fill")
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .foregroundColor(burntOrange)
                    }
                ), trailing:
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
        return LoggingHomeView().environmentObject(UserSession())
    }
}
