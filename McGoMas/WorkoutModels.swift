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

struct Weight: Identifiable, Hashable {
    var id: ObjectIdentifier
    //Example Set: ["weightName": "deadlift", "weight": "500", "repetitions": "5"]
    var set: [String: String]
}

struct Bike: Identifiable, Hashable {
    var id: ObjectIdentifier
    var distance: Double
    var time: TimeInterval
}

struct Run: Identifiable, Hashable {
    var id: ObjectIdentifier
    var distance: Double
    var time: TimeInterval
}

struct Swim: Identifiable, Hashable {
    var id: ObjectIdentifier
    var distance: Double
    var time: TimeInterval
}
