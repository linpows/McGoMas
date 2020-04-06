//
//  WeightListView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct WeightListView: View {
    @ObservedObject var logStore: LocalLogList
    
    var body: some View {
        List {
            ForEach(self.logStore.weightLogs) { weight in
                WeightRow(displayedWeight: weight)
            }.onDelete(perform: deleteWeight)
        }
    }
    //ROW
    struct WeightRow: View {
        @State var displayedWeight: WeightModel.Weight
        @State private var setArray: SetArray = SetArray()
        var body: some View {
            NavigationLink(destination: WeightDetail(displayedWeight: self.displayedWeight)) {
                Text(formatDate(date: self.displayedWeight.dayCompleted))
            }
        }
    }
    
    //DETAIL
    struct WeightDetail: View {
        @State var displayedWeight: WeightModel.Weight
        
        var body: some View {
            VStack() {
                Text("Workout Completed\n" + formatDate(date: self.displayedWeight.dayCompleted)).font(.largeTitle)
                Divider()
                Text("Sets Completed: ").font(.title)
                SetList(mySets: getMySetArray())
            }
        }
        
        func getMySetArray() -> SetArray {
            let setArray = SetArray()
            let allSets = displayedWeight.sets
            
            for set in allSets {
                setArray.addSet(set: set)
            }
            
            return setArray
        }
    }
    
    func deleteWeight(at offsets: IndexSet) {
        self.logStore.weightLogs.remove(atOffsets: offsets)
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
        let logStore = LocalLogList()
        let workout = WeightModel()
        workout.createWeight()
        workout.changeDate(newDate: Date())
        workout.addSet(name: "Test", mass: 3.0, massUnit: "pounds", reps: 3)
        logStore.weightLogs.append(workout.weight!)
        
        return WeightListView(logStore: logStore)
    }
}
