//
//  GridCell.swift
//  McGoMas
// Lays out square views in a grid
// Drawn from https://medium.com/@azamsharp/building-grid-layout-in-swiftui-bcd3bc9627af
//
//  Created by Mikayla Richardson on 4/19/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI

struct GridCell: View, Identifiable {
    let id = UUID()
    @State var imgStr: String
    @State var text: String
    @State var navDest: AnyView
    
    var body: some View {
        ZStack () {
            Image(self.imgStr)
                .resizable()
                .scaledToFit()
                .opacity(0.3)
                .zIndex(0)
            NavigationLink(destination: self.navDest) {
                Text(self.text)
                    .bold()
                    .font(.title)
                    .zIndex(1)
            }
        }
    }
}

extension GridCell { //ADD NEW NAVIGABLE CELLS HERE

    static func allCells(withUserSession: UserSession) -> [GridCell] {
        return [
            GridCell(imgStr: "totals", text: "Totals", navDest: AnyView(Totals().environmentObject(withUserSession))),
            GridCell(imgStr: "weekly", text: "Weekly", navDest: AnyView(Weekly().environmentObject(withUserSession)))
        ]
    }
}

extension Array {
    //Break the instance of array into an array of array
    func chunked(into size:Int) -> [[Element]] {
        var arrOfArr = [[Element]]()
        
        for i in 0...self.count {
            if i % size == 0 && i != 0 {
                //If you have reached an index that fills "size" requirement,
                //append a new array to chunked array that is this element and the "size" elements before it
                arrOfArr.append(Array(self[(i - size)..<i]))
            }
            else if (i == self.count) {
                //Else we must make a smaller array because we cannot fulfill this "size" requirement
                //Smaller array consists of all elements we have missed (back up i % size elements)
                arrOfArr.append(Array(self[i - (i % size)..<i]))
            }
            //Else step forward and loop through logic again
        }
        
        return arrOfArr
    }
}

struct GridCell_Previews: PreviewProvider {
    static var previews: some View {
        return GridCell(imgStr: "totals", text: " Totals", navDest: AnyView(Totals()))
    }
}
