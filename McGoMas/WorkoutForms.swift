//
//  WorkoutForms.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 3/22/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation
import SwiftUI

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


