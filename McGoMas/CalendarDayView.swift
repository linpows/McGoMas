//
//  CalendarDayView.swift
//  McGoMas
//
//  Created by Lin Chen on 4/14/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct CalendarDayView: View {
    var date: Date
    var events: [Event]
    var activeEvents = [Event]()
    
    
    init(date: Date, events: [Event]) {
        self.date = date
        self.events = events
        self.activeEvents = events.filter({ getTextFromDate(date: date) == getTextFromDate(date: $0.start) }).sorted(by: {$0.start < $1.start})
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.activeEvents) { event in
                    EventRow(event: event)
                }
            }
            .navigationBarTitle(getTextFromDate(date: date))
        }
    }
    
    func getTextFromDate(date: Date!) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM d"
        return date == nil ? "" : formatter.string(from: date)
    }
    
    struct EventRow: View {
        @State var event: Event
        
        var body: some View {
            VStack() {
                NavigationLink(destination: EventDetails(event: event)) {
                    Text(event.summary)
                }
            }
        }
    }
    
    struct EventDetails: View {
        @State var event: Event
        
        let formatter = DateFormatter()

        var body: some View {
            VStack() {
                Spacer()
                Text(event.summary).font(.system(size: 25)).padding()
                HStack() {
                    Text("Starts: ").fontWeight(.heavy)
                    Text(getTime(date: event.start))
                }
                HStack() {
                    Text("Ends: ").fontWeight(.heavy)
                    Text(getTime(date: event.end))
                }
                Spacer()
            }
        }
        
        func getTime(date: Date) -> String {
            self.formatter.dateFormat = "HH:mm"
            return formatter.string(from: date)
        }
    }
}
