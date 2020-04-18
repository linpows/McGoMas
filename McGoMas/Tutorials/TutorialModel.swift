//
//  File.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/12/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import Foundation

class TutorialModel: Identifiable, ObservableObject {
    var id: String //Name of weight
    var gifName: String //locally held gif of tutorial
    @Published var userFavorite: Bool //toggle in user favorites
    
    init(id: String, gifName: String, isFavorite: Bool) {
        self.id = id
        self.gifName = gifName
        self.userFavorite = isFavorite
    }
}
