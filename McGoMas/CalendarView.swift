//
//  CalendarView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/22/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct CalendarView : View {
    
    @State var presented = true
    @State var showDate = false
    
    var manager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)

    var body: some View {
        VStack (spacing: 25) {
            RKViewController(showDate: self.$showDate, rkManager: self.manager)
        }.sheet(isPresented: self.$showDate, onDismiss: self.onDismiss) {
            CalendarDayView(date: self.getTextFromDate(date: self.manager.selectedDate))
        }
    }
    
    func onDismiss() {
        self.manager.selectedDate = nil
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return date == nil ? "" : formatter.string(from: date)
    }

}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
