//
//  CardioListView.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/5/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import Foundation

struct CardioListView: View {
    @EnvironmentObject var logStore: UserLogList
    @EnvironmentObject var user: UserSession
    
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
                CardioRow(displayedCardio: cardio)
            }.onDelete(perform: deleteCardio)
        }
        .onAppear() {
            self.sortLogs()
        }
    }
    
    //ROW HEADER
    struct CardioRow: View {
        @EnvironmentObject var logStore: UserLogList
        @State var displayedCardio: CardioModel
        
        var body: some View {
            NavigationLink(destination: CardioDetail(displayedCardio: self.displayedCardio)) {
                HStack() {
                    rowImage().resizable().aspectRatio(contentMode: .fit).frame(height: 50).padding(.trailing)
                    Text(self.displayedCardio.cardio!.workoutType.stringRep + " ").bold()
                    Text(formatDate(date: self.displayedCardio.cardio!.date)).multilineTextAlignment(.center)
                }
            }
        }
        
        func rowImage() -> Image {
            switch(self.displayedCardio.cardio!.workoutType) {
                case WorkoutType.swim:
                    return Image("swim")
                case WorkoutType.run:
                    return Image("run")
                case WorkoutType.bike:
                    return Image("bike")
                default:
                    return Image("run")
            }
        }
    }
    
    //ROW DETAIL
    struct CardioDetail: View {
        @EnvironmentObject var logStore: UserLogList
        @ObservedObject var displayedCardio: CardioModel
        @State private var edit = false
        
        func rowImage() -> Image {
            switch(self.displayedCardio.cardio!.workoutType) {
                case WorkoutType.swim:
                    return Image("swim")
                case WorkoutType.run:
                    return Image("run")
                case WorkoutType.bike:
                    return Image("bike")
                default:
                    return Image("run")
            }
        }
        
        var body: some View {
            VStack() {
                rowImage().resizable().aspectRatio(contentMode: .fit).frame(height: 100)
                Text(self.displayedCardio.cardio!.workoutType.stringRep + " Workout Completed")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("\t" + formatDate(date: self.displayedCardio.cardio!.date) + "\t").font(.largeTitle).multilineTextAlignment(.center)
                Divider()
                
                Text("Distance").font(.title)
                Text((self.displayedCardio.cardio!.distance ?? 0.0).description + " " + (self.displayedCardio.cardio!.distanceUnit ?? "miles"))
                    .fontWeight(.bold)
                    .padding()
                
                Text("Total Time").font(.title)
                Text(self.timeToString(minutes: self.displayedCardio.cardio!.time ?? 0.0))
                    .fontWeight(.bold)
                    .padding()
                    
            }
            .navigationBarItems(trailing: Button(
                action: {
                    self.logStore.editingCardioInstance = self.displayedCardio
                    self.displayedCardio.pushToDB = true //Will need changes saved in backend
                    self.edit = true
                },
                label: {Text("Edit")}
            ))
            .sheet(isPresented: $edit) {
                CardioEditWrapper().environmentObject(self.logStore)
            }
        }
        
        struct CardioEditWrapper: View {
            @EnvironmentObject var logStore: UserLogList
            @Environment(\.presentationMode) var presentationMode
            
            var body: some View {
                VStack() {
                    Spacer()
                    CardioEntry().environmentObject(self.logStore)
                    Spacer()
                    Button(
                        action: {
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        label: {Text("Done")}
                    ).buttonStyle(GradientButtonStyle())
                    Spacer()
                }
            }
        }
        
        func timeToString(minutes: Double) -> String {
            let hours: Int = Int(minutes / 60)
            let remainingMinutes: Int = Int(minutes) % 60
            let remainder = minutes.truncatingRemainder(dividingBy: 1.0)
            var secs = remainder * 60.0
            secs.round()
            let seconds = Int(secs)
            
            let strRep = String(format: "%02d:%02d:%02d", hours, remainingMinutes, seconds)
            
            return strRep
            
        }
    }
    
    func deleteCardio(at offsets: IndexSet) {
        for idx in offsets {//Remove from database
            user.removeCardio(idx: idx)
        }
    }
}

struct CardioListView_Previews: PreviewProvider {

    static var previews: some View {
        let cardioWorkout = CardioModel()
        cardioWorkout.createCardio(withType: WorkoutType.swim, date: Date(), distance: 1.5, distanceUnit: "miles", time: 60.0)
        let logStore = UserLogList(cardioModels: [cardioWorkout], weightModels: [])

        let navWrapped = NavigationView {
            CardioListView().environmentObject(logStore).environmentObject(UserSession())
        }
        return navWrapped
    }
}
