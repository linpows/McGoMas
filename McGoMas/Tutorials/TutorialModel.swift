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
    var link: URL //link to mp4
    @Published var userFavorite: Bool //toggle in user favorites
    
    init(id: String, link: URL, isFavorite: Bool) {
        self.id = id
        self.link = link
        self.userFavorite = isFavorite
    }
}
