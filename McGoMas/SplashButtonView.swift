import SwiftUI

class AlternatingColor: ObservableObject {
    @Published var colorOne: Color = Color.init(Color.RGBColorSpace.sRGB, red: 99.0 / 255, green: 0, blue: 49.0 / 255, opacity: 100);
    @Published var colorTwo: Color = Color.init(Color.RGBColorSpace.sRGB, red: 207.0 / 255, green: 69.0 / 255, blue: 32.0 / 255, opacity: 100)
}

struct SplashButtonView: View {
    var title: String = "McGoMas"
    var imageName: String = "stopwatch"
    @State private var animationAmount: CGFloat = 1
    @ObservedObject var currColor = AlternatingColor()
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var animate = false
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                Image(systemName: imageName)
                .resizable()
                .frame(width:100, height:100)
                    .foregroundColor(.white)
                Button (
                    action: {
                        self.animate = true
                    },
                    label: {
                        Text("Let's Go, Hokies.")
                    }
                )
            }
            if animate {
            Circle()
                .fill(currColor.colorOne)
                .frame(width: 1, height: 1, alignment: .center)
                .scaleEffect(animationAmount)
                .animation(
                    Animation.easeOut(duration: 3)
                )
                .onAppear {
                    self.animationAmount = CGFloat(1000)
                }
            }
        
//            Circle()
//                .fill(currColor.colorOne)
//                .frame(width: 100, height: 100, alignment: .center)
//                .scaleEffect(animationAmount)
//                .animation(
//                    Animation.easeOut(duration: 3)
//                        .repeatForever(autoreverses: true)
//                )
//                .overlay(
//                    Image(systemName: imageName)
//                    .resizable()
//                    .frame(width:100, height:100)
//                        .foregroundColor(.white)
//                )
//                .onAppear {
//                    self.animationAmount = 8
//                }
//            .onReceive(timer) { _ in
//                let temp = self.currColor.colorOne
//                self.currColor.colorOne = self.currColor.colorTwo
//                self.currColor.colorTwo = temp
//            }
//            Text("McGoMas")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 5.0)
//                .frame(width: nil)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.gray)
    }
}


struct SplashButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SplashButtonView()
    }
}
