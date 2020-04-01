//
//  WorkoutForms.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/22/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct WorkoutTypeArr {
    let arrWithDefault : Array<String> =
        ["---", "Swim", "Bike", "Run", "Weights"]
}

enum WorkoutType: Int {
    case swim = 1
    case bike = 2
    case run = 3
    case weights = 4
    
    var stringRep : String {
        switch self {
            case WorkoutType.swim:
                return "Swim"
            case WorkoutType.bike:
                return "Bike"
            case WorkoutType.weights:
                return "Weights"
            case WorkoutType.run:
                return "Run"
        }
    }
}


/*
 Models for different types of workouts.
 Stored under user's UID in Firebase Database
 */

class WeightModel: ObservableObject {
    //Publisher-- subscribers will get notified if a given model changes
    var didChange = PassthroughSubject<WeightModel, Never>()
    @Published var weight: Weight? { didSet {
        //When a class in "weight" is set, broadcast change
        self.didChange.send(self)
    }}
    
    /*
     Initializes a new weight
     */
    func createWeight() {
        self.weight = Weight(startingSets: nil, startingDate: nil)
    }
    
    /*
     Completely remove the workout by setting to nil
     */
    func removeWeight() {
        self.weight = nil
    }
    
    /*
    Add a single set to this weight workout
    */
    func addSet(name: String, mass: Double, massUnit: String, reps: Int) {
        if let myWeight = self.weight {
            myWeight.sets.append(Weight.WeightSet(weightName: name, weight: mass, weightUnit: massUnit, repetitions: reps))
            self.weight = myWeight
        }
    }
    
    /*
    remove a set with a specific ID from the workout
    */
    func removeSet(withID: UUID) {
        if let weight = self.weight {
            //Get the set that does not have that id
           let removed = weight.sets.filter( { set in
                set.id != withID
            })
            weight.sets = removed
            self.weight = weight
        }
    }
    
    /*
    Change the date of the workout
    */
    func changeDate(newDate: Date) {
        if let myWeight = self.weight {
            myWeight.dayCompleted = newDate
            self.weight = myWeight
        }
    }
    
    class Weight: Identifiable {
        var id: UUID
        var dayCompleted: Date
        var sets: [WeightSet]
        
        /*
         Can optionally specify some predefined sets.
         If none specified, will assume an empty set array
         Can optionally specify a day this was completed.
         Default assumes the date is moment of creation
         */
        init(startingSets: [WeightSet]?, startingDate: Date?) {
            self.id = UUID()
            if let initial = startingSets {
                self.sets = initial
            }
            else {
                self.sets = []
            }
            if let aDate = startingDate {
                self.dayCompleted = aDate
            }
            else {
                self.dayCompleted = Date()
            }
            
        }
        
        
        struct WeightSet: Identifiable {
            let id: UUID = UUID()
            var weightName: String
            var weight: Double
            var weightUnit: String
            var repetitions: Int
        }
    }
}



class CardioModel: ObservableObject {
    var didChange = PassthroughSubject<CardioModel, Never>()
    @Published var cardio: Cardio? { didSet {
        //When a class in "weight" is set, broadcast change
        self.didChange.send(self)
    } }
    
    /*
     Initializes a new cardio workout
     */
    func createCardio(withType: WorkoutType) {
        self.cardio = Cardio(type: withType, date: nil, distance: nil, distanceUnit: nil, time: nil)
    }
    /*
     Override with options to specify fields
     */
    func createCardio(withType: WorkoutType, date: Date, distance: Double, distanceUnit: String, time: Double) {
        self.cardio = Cardio(type: withType, date: date, distance: distance, distanceUnit: distanceUnit, time: time)
    }
    
    /*
     Completely remove the workout by setting to nil
     */
    func removeCardio() {
        self.cardio = nil
    }
    
    /*
    SETTERS
    */
    func setDate(newDate: Date) {
        if let myCardio = self.cardio {
            myCardio.date = newDate
            self.cardio = myCardio
        }
    }
    
    
    func setDistance(newDistance: Double) {
        if let myCardio = self.cardio {
            myCardio.distance = newDistance
            self.cardio = myCardio
        }
    }
    
    func setUnit(newUnit: String) {
        if let myCardio = self.cardio {
            myCardio.distanceUnit = newUnit
            self.cardio = myCardio
        }
    }

    func setTime(newTime: Double) {
        if let myCardio = self.cardio {
            myCardio.time = newTime
            self.cardio = myCardio
        }
    }
    
    class Cardio: Identifiable {
        
        
        let id: UUID = UUID()
        //Bike, run, swim...
        var workoutType: WorkoutType
        var date: Date
        //distance covered and its unit (meter/mile/kilometer)
        var distance: Double?
        var distanceUnit: String?
        //time represented in # minutes
        var time: Double?
        
        init(type: WorkoutType, date: Date?, distance: Double?, distanceUnit: String?, time: Double?) {
            self.workoutType = type
            if let date = date {
                self.date = date
            }
            else {
                self.date = Date()
            }
            self.distance = distance
            self.distanceUnit = distanceUnit
            self.time = time
        }
        
    }
}
