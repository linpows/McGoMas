//
//  LogGraphView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/15/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct LogGraphView: View {
    @EnvironmentObject var user: UserSession
    
    @State private var tiles: [[GridCell]] = [[]]
    
    var body: some View {
        VStack {
            ForEach(0..<self.tiles.count) { idx in
                HStack() {
                    ForEach(self.tiles[idx]) { cell in
                        cell
                    }
                }
            }
        }
        .onAppear() {
            withAnimation(Animation.easeIn(duration: 1.0)) {
                self.tiles = GridCell.allCells(withUserSession: self.user).chunked(into: 2)
            }
        }
    }
}


