import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
           Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LottieView

        init(_ animationView: LottieView) {
            self.parent = animationView
            super.init()
        }
    }

    @Binding var closure: ((Bool) -> Void)?
    @Binding var loopMode: LottieLoopMode
    
    var filename: String
    var speed: CGFloat = 1.0
    var playSubsection = false
    var startFrame = 0
    var endFrame = 0
    var animationView = AnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
        let animation = Animation.named(filename)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        

        if(playSubsection) {
            animationView.play(fromFrame: AnimationFrameTime(startFrame), toFrame: AnimationFrameTime(endFrame), loopMode: loopMode, completion: closure)
        } else {
            animationView.play(completion: closure)
        }
        
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
            animationView.loopMode = loopMode
        
            animationView.play(toProgress: 1, loopMode: loopMode, completion: closure)
    }
}
