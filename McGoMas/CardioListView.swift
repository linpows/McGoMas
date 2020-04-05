//
//  CardioListView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct CardioListView: View {
    @ObservedObject var logStore: LocalLogList
    
    var body: some View {
        Text("To View All Cardio")
    }
}

struct CardioListView_Previews: PreviewProvider {

    static var previews: some View {
        let logStore = LocalLogList()
        let cardioWorkout = CardioModel()
        cardioWorkout.createCardio(withType: WorkoutType.swim, date: Date(), distance: 1.5, distanceUnit: "miles", time: 60.0)
        logStore.cardioLogs.append(cardioWorkout.cardio!)
        
        return CardioListView(logStore: logStore)
    }
}
