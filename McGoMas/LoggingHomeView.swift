//
//  LoggingHomeView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Firebase


struct LoggingHomeView: View {
    //Show the loading screen while we pull from database
    @State private var loading: Bool = true
    
    //Present view for adding a workout
    @State private var showAdd: Bool = false
    //Present view for data visualization
    @State private var showStats: Bool = false
    
    @EnvironmentObject var userSession: UserSession
    
    @State private var selection: Int = 0
    private let types = ["Cardio", "Weights"]

    
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
                
                SaveButton()
            }
            .navigationBarTitle("Your Log")
            .navigationBarItems(leading: GraphButton(success: $showStats),
                                 trailing: AddButton(success: $showAdd))
        }
        .sheet(isPresented: $loading) {
            Loading(isPresented: self.$loading).environmentObject(self.userSession)
        }
        .onAppear() {
            self.loading = self.userSession.logs.cardioLogs.isEmpty && self.userSession.logs.weightLogs.isEmpty
        }
    }
    
    private struct AddButton: View {
        @EnvironmentObject var userSession: UserSession
        @State var errSignal: Bool = false
        @Binding var success: Bool
        
        var body: some View {
            Button( action: {
                (self.userSession.user == nil) ? (self.errSignal = true) : (self.success = true)
            }, label: {
                Image(systemName: "plus.square.fill")
                .font(.largeTitle)
                .padding(.top, 20)
                .foregroundColor(chicagoMaroon)
            })
            .alert(isPresented: $errSignal) {
                Alert(title: Text("Oops"), message: Text("Sign in to access this functionality"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private struct GraphButton: View {
        @EnvironmentObject var userSession: UserSession
        @State var errSignal: Bool = false
        @Binding var success: Bool
        
        var body: some View {
            Button( action: {
                (self.userSession.user == nil) ? (self.errSignal = true) : (self.success = true)
            }, label: {
                Image(systemName: "chart.pie.fill")
                .font(.largeTitle)
                .padding(.top, 20)
                .foregroundColor(burntOrange)
            })
            .alert(isPresented: $errSignal) {
                Alert(title: Text("Oops"), message: Text("Sign in to access this functionality"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    private struct SaveButton: View {
        @EnvironmentObject var userSession: UserSession
        @State var saveSignal: Bool = false
        @State var errSignal: Bool = false
        
        var body: some View {
            Button (
                action: {
                    if self.userSession.user != nil {
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
                        self.saveSignal = true
                        
                    }
                    else {
                        self.errSignal = true
                    }
                },
                label: {
                    Text("Save Changes").font(.title)
                    .fontWeight(.bold)
                }
            )
            .alert(isPresented: $saveSignal) {
                Alert(title: Text("Success"), message: Text("Changes saved successfully."), dismissButton: .default(Text("Ok")))
            }
            .alert(isPresented: $errSignal) {
                Alert(title: Text("Oops"), message: Text("Sign in to access this functionality"), dismissButton: .default(Text("Ok")))
            }
            .buttonStyle(GradientButtonStyle())
            .padding()
        }
    }
}


struct LoggingHomeView_Previews: PreviewProvider {
    static var previews: some View {
        return LoggingHomeView().environmentObject(UserSession())
    }
}
