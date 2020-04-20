//
//  TutorialGifPlayer.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/17/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import SwiftyGif

//Wrap the gif player UIView in something that SwiftUI can use
struct TutorialGifPlayer: UIViewRepresentable {
    @State var gifName: String
    
    func makeUIView(context: Context) -> UIView {
        do {
            let image = try UIImage(gifName: self.gifName)
            let view = UIImageView(gifImage: image, loopCount: -1)
            view.contentMode = .scaleAspectFit
            return view
        } catch { //Could not make image from given name
            print(error)
        }
        //If we couldn't make a gif, return an error placeholder
        let errImg = UIImage(systemName: "xmark.octagon")!
        let errView = UIImageView(image: errImg)
        errView.contentMode = .scaleAspectFit
        return errView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TutorialGifPlayer>) {
        //Used to adjust to orientation changes
    }
}

struct TutorialGifPlayer_Previews: PreviewProvider {
    static var previews: some View {
        TutorialGifPlayer(gifName: "leg_curl.gif")
    }
}
