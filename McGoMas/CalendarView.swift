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
    
    @State var events = [Event]()
    
    var body: some View {
        VStack (spacing: 25) {
            RKViewController(showDate: self.$showDate, rkManager: self.manager)
                .onAppear(perform: loadData)
        }.sheet(isPresented: self.$showDate, onDismiss: self.onDismiss) {
            CalendarDayView(date: self.manager.selectedDate, events: self.events)
        }
    }
    
    func onDismiss() {
        self.manager.selectedDate = nil
    }
    
    func loadData() {
        if (!self.events.isEmpty) {
            return
        }
        let today = Date()
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: today))!
        let timeMin = startOfMonth.iso8601withFractionalSeconds
        let timeMax = today.addingTimeInterval(60*60*24*365).iso8601withFractionalSeconds // one year from now
        
        let RFC3339DateFormatter = DateFormatter()
        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
        RFC3339DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let url = URL(string: "https://content.googleapis.com/calendar/v3/calendars/virginiatechfitness@gmail.com/events?showDeleted=false&showHiddenInvitations=false&key=AIzaSyDjh_CPl4VaLWotGNXPFyu46doaJRBc94U&timeMin=" + timeMin +
            "&timeMax=" + timeMax
        )
        
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let data = data else { return }
            
            var listOfEvents: [Event] = []

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                let items = json?["items"] as? [[String: Any]] ?? []
                for item in items {
                    var startDate: Date
                    var endDate: Date
                    var summary: String
                    
                    let start = item["start"] as? [String: Any]
                    let end = item["end"] as? [String: Any]
                    if (start != nil && end != nil) {
                        summary = item["summary"] as! String
                        let startDateString = start!["dateTime"] as! String
                        let endDateString = end!["dateTime"] as! String
                        
                        startDate = RFC3339DateFormatter.date(from: startDateString)!
                        endDate = RFC3339DateFormatter.date(from: endDateString)!
                        listOfEvents.append(Event(start: startDate, end: endDate, summary: summary))
                    }
                }
                DispatchQueue.main.async {
                    self.events = listOfEvents
                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }

}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    static let iso8601withFractionalSeconds = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    var iso8601withFractionalSeconds: String { return Formatter.iso8601withFractionalSeconds.string(from: self) }
}

