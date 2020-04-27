//
//  PredictionView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/20/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Foundation

// uses RK Calendar from CalendarView
struct PredictionView : View {
    
    @State var presented = true
    @State var showDate = false
    
    var manager = RKManager(calendar: Calendar.current, minimumDate: minPredictionDate, maximumDate: minPredictionDate.addingTimeInterval(60*60*24*365), mode: 0) // display year out from minPredictionDate
    
    var body: some View {
        VStack (spacing: 25) {
            RKViewController(showDate: self.$showDate, rkManager: self.manager)
        }.sheet(isPresented: self.$showDate, onDismiss: self.onDismiss) {
            PredictionDayView(date: self.manager.selectedDate)
        }
    }
    
    func onDismiss() {
        self.manager.selectedDate = nil
    }
}

struct PredictionView_Previews: PreviewProvider {
    static var previews: some View {
        PredictionView()
    }
}
