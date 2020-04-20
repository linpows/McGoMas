//
//  CalendarModels.swift
//  McGoMas
//
//  Created by Lin Chen on 4/19/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation

class Event: Identifiable {
    var summary: String
    var start: Date
    var end: Date
    
    init(start: Date, end: Date, summary: String) {
        self.summary = summary
        self.start = start
        self.end = end
    }
}
