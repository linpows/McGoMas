//
//  TutorialVideoPlayer.swift
//  McGoMas
//
//  Created by Mikayla Richardson on 4/12/20.
//  Copyright © 2020 Capstone. All rights reserved.
//

import SwiftUI
import AVFoundation

//Must make the UIKit's AV player compatible with SwiftUI
struct VideoView: UIViewRepresentable {
    @State var url: URL
    
    func makeUIView(context: Context) -> UIView {
        let myPlayer = TutorialVideoPlayer(frame: .zero, url: self.url)
        
        return myPlayer
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoView>) {
    }
    
    
}

class TutorialVideoPlayer: UIView {
    private let av = AVPlayerLayer()
    
    init(frame: CGRect, url: URL) {
        super.init(frame: frame)
        //Create the actual AudioVideo Player from given URL
        let tutorialPlayer = AVPlayer(url: url)
                
        //Set video in motion and loop
        tutorialPlayer.play()
        loopVideo(videoPlayer: tutorialPlayer)
        
        //Add to the player layer
        av.player = tutorialPlayer
        layer.addSublayer(av)
    }
    
    required init?(coder: NSCoder) { //No compatibility with NSCoder
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        av.frame = bounds
    }
    
    
    

    func loopVideo(videoPlayer: AVPlayer) {
        //Notification center alerts when AV play is finished
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: OperationQueue.main) { notification in
            //Run back to the beginning and play
            videoPlayer.seek(to: CMTime.zero)
            videoPlayer.play()
        }
    }
}

