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
    
    init(filename: String, closure: Binding<((Bool) -> Void)?> = Binding.constant(nil), loopMode: LottieLoopMode = .playOnce, speed: Double = 1.0, playSubsection: Bool = false, startFrame: Int = 0, endFrame: Int = 0) {
        self._closure = closure
        self.filename = filename
        self.loopMode = loopMode
        self.speed = CGFloat(speed)
        self.playSubsection = playSubsection
        self.startFrame = startFrame
        self.endFrame = endFrame
    }
    
    @Binding var closure: ((Bool) -> Void)?
    
    var filename: String
    var loopMode: LottieLoopMode
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
            animationView.play(toProgress: 1, loopMode: .playOnce, completion: closure)
    }
}
