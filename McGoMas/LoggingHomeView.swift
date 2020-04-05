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
    @State private var showError: Bool = false
    @EnvironmentObject var userSession: UserSession
    //Observes multiple additions
    @ObservedObject var logs: LocalLogList = LocalLogList()
    @State private var selection: Int = 0
    private var types = ["Cardio", "Weights"]
    
    var body: some View {
        NavigationView {
            VStack () {
                NavigationLink(destination: AddEntryView(modelStore: self.logs), isActive: $showAdd) {
                    EmptyView()
                }
                Picker("Log Type", selection: $selection) {
                    ForEach( 0 ..< types.count) { index in
                        Text(self.types[index]).tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                if (self.selection == 0) {
                    CardioListView(logStore: self.logs)
                }
                else {
                    WeightListView(logStore: self.logs)
                }
                Spacer()
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
        LoggingHomeView()
    }
}
