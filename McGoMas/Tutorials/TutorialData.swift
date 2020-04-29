//
//  TutorialData.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation


let tutorials: [TutorialModel] = [
    TutorialModel(id: "Bicep Cable Press", gifName: "bicep_cable_press.gif", isFavorite: false),
    TutorialModel(id: "Deadlift", gifName: "deadlift.gif", isFavorite: false),
    TutorialModel(id: "Hanging Leg Raise", gifName: "hanging_leg_raise.gif", isFavorite: false),
    TutorialModel(id: "Lat Pull Down", gifName: "lat_pull_down.gif", isFavorite: false),
    TutorialModel(id: "Leg Curl", gifName: "leg_curl.gif", isFavorite: false),
    TutorialModel(id: "Leg Extension", gifName: "leg_extension.gif", isFavorite: false),
    TutorialModel(id: "Leg Press", gifName: "leg_press.gif", isFavorite: false),
    TutorialModel(id: "Tricep Cable Press", gifName: "tricep_cable_press.gif", isFavorite: false)
    TutorialModel(id: "Barbell Hip Thrust", gifName: "Barbell hip thrust.gif", isFavorite: false)
    TutorialModel(id: "Bench Press", gifName: "Bench Press.gif", isFavorite: false)
    TutorialModel(id: "Bicep Cable Curl", gifName: "Bicep Cable Curl.gif", isFavorite: false)
    TutorialModel(id: "Deadbug", gifName: "Deadbug.gif", isFavorite: false),
    TutorialModel(id: "Dumbbell Lunge", gifName: "dumbbell lunge.gif", isFavorite: false),
    TutorialModel(id: "Floor Press", gifName: "Floor Press.gif", isFavorite: false),
    TutorialModel(id: "Goblet Squad", gifName: "Goblet Squad.gif", isFavorite: false),
    TutorialModel(id: "Pushup", gifName: "Pushup.gif", isFavorite: false),
    TutorialModel(id: "Renegade Row", gifName: "renegade row.gif", isFavorite: false),
    TutorialModel(id: "Romanian Deadlift", gifName: "romanian deadlift.gif", isFavorite: false),
    TutorialModel(id: "Rowing Machine", gifName: "Rowing Machine.gif", isFavorite: false)
    TutorialModel(id: "Squats With Bar", gifName: "Squats With Bar.gif", isFavorite: false)
    
]

enum WeightTags: Int {
    case arm, leg, core
}
