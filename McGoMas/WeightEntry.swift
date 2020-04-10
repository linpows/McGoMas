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
        SetEntry().environmentObject(models.editingWeightInstance!.weight!.sets)
    }
}



struct WeightEntry_Previews: PreviewProvider {
    static var previews: some View {
        let model = WeightModel()
        let inNavView = NavigationView {
            WeightEntry().environmentObject(model)
        }
        return inNavView
    }
}
