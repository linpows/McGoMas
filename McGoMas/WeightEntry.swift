//
//  WeightEntry.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/1/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct WeightEntry: View {
    //Given model we will be storing changes in
    @EnvironmentObject var models: UserLogList
    
    var body: some View {
        VStack() {
            SetEntry(prepopulatedFields: nil, saveWillDismiss: false).environmentObject(models)
            Divider()
            SetList(mySets: self.models.editingWeightInstance!.weight?.sets ?? SetArray(fromSets: []), forModel: self.models.editingWeightInstance!).padding(.top, 0)
        }
    }
}



struct WeightEntry_Previews: PreviewProvider {
    static var previews: some View {
        let models = UserLogList(cardioModels: [], weightModels: [])
        let inNavView = NavigationView {
            WeightEntry().environmentObject(models)
        }
        return inNavView
    }
}
