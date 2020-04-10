//
//  WeightListView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct WeightListView: View {
    @EnvironmentObject var logStore: UserLogList
    @EnvironmentObject var user: UserSession
    
    func sortLogs() {
        //Sort logs by date
        logStore.weightLogs.sort { one, two in
            one.weight!.dayCompleted >= two.weight!.dayCompleted
        }
    }
    
    var body: some View {
        List {
            ForEach(self.logStore.weightLogs) { weight in
                WeightRow(displayedWeight: weight.weight!)
            }.onDelete(perform: deleteWeight)
        }
        .onAppear() {
            self.sortLogs()
        }
    }
    
    //ROW
    struct WeightRow: View {
        @State var displayedWeight: WeightModel.Weight
        var body: some View {
            NavigationLink(destination: WeightDetail(displayedWeight: self.displayedWeight, sets: self.displayedWeight.sets)) {
                Text(formatDate(date: self.displayedWeight.dayCompleted))
            }
        }
    }
    
    //DETAIL
    struct WeightDetail: View {
        @State var displayedWeight: WeightModel.Weight
        @ObservedObject var sets: SetArray
        
        var body: some View {
            VStack() {
                Text("Workout Completed\n" + formatDate(date: self.displayedWeight.dayCompleted)).font(.largeTitle)
                Divider()
                Text("Sets Completed: ").font(.title)
                SetList(mySets: self.sets)
            }
        }
    }
    
    func deleteWeight(at offsets: IndexSet) {
        for idx in offsets {//Remove from database
            let ref = self.logStore.weightLogs[idx]
            user.removeWeight(weight: ref)
        }
        self.logStore.weightLogs.remove(atOffsets: offsets) //Remove locally
    }
    
}



struct SetList: View {
    //Sets to display
    @ObservedObject var mySets: SetArray
    
    var body: some View {
        List {
            ForEach (self.mySets.sets) { logSet in
                NavigationLink(destination: SetDetail(displayedSet: logSet)) {
                    Text(logSet.weightName)
                }
            }.onDelete(perform: removeSet)
        }.padding(0.0)
    }
    
    func removeSet(at offsets: IndexSet) {
        self.mySets.sets.remove(atOffsets: offsets)
    }
    
    //Detail view of a logged set
    struct SetDetail: View {
        @State var displayedSet: WeightSet
        
        var body: some View {
            VStack () {
                Text(displayedSet.weightName).font(.largeTitle).bold()
                Divider()
                Spacer()
                HStack() {
                    Text("Weight Lifted: ").font(.title)
                    Text(String(displayedSet.weight)).font(.title).bold()
                    Text(displayedSet.weightUnit).font(.title)
                }.padding()
                HStack() {
                    Text("Number of Reps: ").font(.title)
                    Text(String(displayedSet.repetitions)).font(.title).bold()
                }
                Spacer()
            }
        }
    }
}

func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    return dateFormatter.string(from: date)
}


struct WeightListView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = WeightModel()
        workout.createWeight()
        workout.changeDate(newDate: Date())
        workout.addSet(name: "Test", mass: 3.0, massUnit: "pounds", reps: 3)
        let logStore = UserLogList(cardioModels: [], weightModels: [workout])
        
        return WeightListView().environmentObject( logStore)
    }
}
