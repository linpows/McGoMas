//
//  TutorialHome.swift
//  McGoMas
// Use to make dynamically filtering search bar:
// https://medium.com/@axelhodler/creating-a-search-bar-for-swiftui-e216fe8c8c7f
// Used for incorporating GIFS : https://github.com/kirualex/SwiftyGif
//  Created by Mikayla Richardson on 4/10/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI

struct TutorialHome: View {
    private var tutorialArray: [TutorialModel] = tutorials
    private var pickerOptions = ["All", "Favorites"]
    @State private var selection: Int = 0
    
    @State private var query: String = ""
    
    var body: some View {
        NavigationView {
            VStack () {
                //Search bar
                SearchBar(query: $query)
                //Optional toggle to search through self-selected favorites
                Picker("Filter", selection: $selection) {
                    ForEach( 0 ..< pickerOptions.count) { index in
                        Text(self.pickerOptions[index]).tag(index)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                //Results
                List {
                    //Filter out non-favorited IF user has selected to only search favorites
                    ForEach(
                        self.tutorialArray
                            .filter{self.selection == 0 ? true : $0.userFavorite}
                            .filter{self.query.isEmpty ? true : $0.id.lowercased().contains(self.query.lowercased())}
                    ) { tutorial in
                        NavigationLink(destination: TutorialDetail(tutorial: tutorial)) {
                            Text(tutorial.id)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Tutorials"))
        }
    }
}

struct TutorialDetail: View {
    @ObservedObject var tutorial: TutorialModel
    @State var systemImgName = "" //SF Symbol ID for image button
    
    var body: some View {
        VStack() {
            TutorialGifPlayer(gifName: tutorial.gifName)
            Button( //Toggle this tutorial in/out of the favorites
                action: {
                    self.tutorial.userFavorite.toggle()
                },
                label: { //Filled heart if favorite, empty heart if not
                    Image(systemName: self.tutorial.userFavorite ? "heart.fill" : "heart")
                }
            )
            .font(Font.system(size: 50)).padding()
            .buttonStyle(FavButtonStyle())
            
        }
        .navigationBarTitle(Text(self.tutorial.id + " Tutorial"))
    }
    
    struct FavButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.8 : 1.0) //press down effect
            
        }
    }
    
}

struct TutorialHome_Previews: PreviewProvider {
    static var previews: some View {
        TutorialHome()
    }
}
