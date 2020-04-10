//
//  CardioListView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct CardioListView: View {
    @EnvironmentObject var logStore: UserLogList
    @State private var sorted: [CardioModel] = []
    
    func sortLogs() {
        //Sort logs by date
        logStore.cardioLogs.sort { one, two in
            one.cardio!.date >= two.cardio!.date
        }

    }
    
    var body: some View {
        List {
            ForEach(self.logStore.cardioLogs) { cardio in
                CardioRow(displayedCardio: cardio.cardio!)
            }.onDelete(perform: deleteCardio)
        }
        .onAppear() {
            self.sortLogs()
        }
    }
    
    //ROW HEADER
    struct CardioRow: View {
        @State var displayedCardio: CardioModel.Cardio
        
        var body: some View {
            NavigationLink(destination: CardioDetail(displayedCardio: self.displayedCardio)) {
                Text(self.displayedCardio.workoutType.stringRep + " " + formatDate(date: self.displayedCardio.date))
            }
        }
    }
    
    //ROW DETAIL
    struct CardioDetail: View {
        @State var displayedCardio: CardioModel.Cardio
        
        var body: some View {
            VStack() {
                Text(self.displayedCardio.workoutType.stringRep + " Workout Completed\n" + formatDate(date: self.displayedCardio.date)).font(.largeTitle).multilineTextAlignment(.center)
                Divider()
                Text("Distance").font(.title)
                Text((self.displayedCardio.distance ?? 0.0).description + " " + (self.displayedCardio.distanceUnit ?? "miles")).padding()
                
                Text("Total Time").font(.title)
                Text(self.timeToString(minutes: self.displayedCardio.time ?? 0.0))
            }
        }
        
        func timeToString(minutes: Double) -> String {
            let hours: Int = Int(minutes / 60)
            let remainingMinutes: Int = Int(minutes) % 60
            let remainder = minutes.truncatingRemainder(dividingBy: 1.0)
            var secs = remainder * 60.0
            secs.round()
            let seconds = Int(secs)
            
            let strRep: String = "\(hours):\(remainingMinutes).\(seconds)"
            
            return strRep
            
        }
    }
    
    func deleteCardio(at offset: IndexSet) {
        self.logStore.cardioLogs.remove(atOffsets: offset)
    }
}

struct CardioListView_Previews: PreviewProvider {

    static var previews: some View {
        let cardioWorkout = CardioModel()
        cardioWorkout.createCardio(withType: WorkoutType.swim, date: Date(), distance: 1.5, distanceUnit: "miles", time: 60.0)
        let logStore = UserLogList(cardioModels: [cardioWorkout], weightModels: [])

        
        return CardioListView().environmentObject( logStore)
    }
}
