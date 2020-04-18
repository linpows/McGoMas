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
        let errImg = UIImage(systemName: "xmark.octagon")!
        let errView = UIImageView(image: errImg)
        errView.contentMode = .scaleAspectFit
        return errView
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TutorialGifPlayer>) {
        //Used to adjust to orientation changes
    }
}

class Gif: UIView {
    private var gifView: UIImageView = UIImageView()
    
    init(frame: CGRect, gifURL: URL) {
        
        super.init(frame: frame)
        
        //Infinite gif loop
        self.gifView = UIImageView(gifURL: gifURL, loopCount: -1)
        
        self.addSubview(gifView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct TutorialGifPlayer_Previews: PreviewProvider {
    static var previews: some View {
        TutorialGifPlayer(gifName: "leg_curl.gif")
    }
}
