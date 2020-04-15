//
//  LogGraphView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/15/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct LogGraphView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

//Totals: view how many miles run/swum/biked throughout log time
struct TotalLogStats: View {
    @EnvironmentObject var user: UserSession
    var body: some View {
        Text("Totals")
    }
}

struct LogGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LogGraphView()
    }
}
