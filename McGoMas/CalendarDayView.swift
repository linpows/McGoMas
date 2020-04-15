//
//  CalendarDayView.swift
//  McGoMas
//
//  Created by Lin Chen on 4/14/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct CalendarDayView: View {
    var dateString: String
    
    init(date: String) {
        self.dateString = date
    }
    
    var body: some View {
        Text(self.dateString)
    }
}
