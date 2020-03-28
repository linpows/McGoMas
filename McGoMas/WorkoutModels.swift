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

struct Weight: Identifiable {
    var id: ObjectIdentifier
    
}

struct Bike: Identifiable {
    var id: ObjectIdentifier
    
}

struct Run: Identifiable {
    var id: ObjectIdentifier
}

struct Swim: Identifiable {
    var id: ObjectIdentifier
}
