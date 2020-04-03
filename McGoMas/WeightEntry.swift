//
//  WeightEntry.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/1/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

class SetArray: ObservableObject {
    @Published var sets: [WeightSet] = []
    
    func addSet(set: WeightSet) {
        self.sets.append(set)
    }
    
    func removeSet(set: WeightSet) {
        
        let filtered = self.sets.filter( { mySet in
                mySet.id != set.id
            }
        )
        
        self.sets = filtered
    }
}

struct WeightEntry: View {
    //Given model we will be storing changes in
    @ObservedObject var model: WeightModel
    //Sets within this workout model
    @ObservedObject var setEntries = SetArray()
    
    var body: some View {
 
        SetEntry(currentLoggedSets: self.setEntries)
        .onDisappear() {
            //Save data before exiting
            if let weight = self.model.weight {
                weight.sets = self.setEntries.sets
            }
        }
    }
    
}



struct WeightEntry_Previews: PreviewProvider {
    static var previews: some View {
        let model = WeightModel()
        let inNavView = NavigationView {
            WeightEntry(model: model)
        }
        return inNavView
    }
}
