

import SwiftUI
import AVFoundation
import Lottie

struct ContentView: View {
    
    @State private var throb_one = false
    @State private var throb_two = true
    @State private var timer: Timer? = nil
    @State private var rectHeight: CGFloat = 100
    @State private var rectWidth: CGFloat = 30
    @State private var audioPlayer: AVAudioPlayer?
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    var body: some View {
        
        ZStack {
            Color(.gray)
                .ignoresSafeArea()
            VStack {
                
                Text("POLICE")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                HStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: rectHeight, height: rectWidth)
                        .foregroundStyle(.blue)
                        .opacity(throb_one ? 1 : 0)
                    
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(width: rectHeight, height: rectWidth)
                        .foregroundStyle(.red)
                        .opacity(throb_two ? 1 : 0)
                }
                .onAppear{
                    startBlinking()
                }
                
                Button{
                    audioPlayerViewModel.playOrPause(trackName: "police")
                }label: {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                }
                
                Text("DUCK")
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                
                LottieView(animation: .named("duck.json"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .frame(width: .infinity, height: 200)
                
                Button{
                    audioPlayerViewModel.playOrPause(trackName: "utka")
                }label: {
                    Image(systemName: "dot.radiowaves.left.and.right")
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    func startBlinking(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { _ in
            withAnimation(Animation.linear(duration: 0.1).repeatCount(5, autoreverses: true)) {
                throb_one.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.linear(duration: 0.1).repeatCount(5, autoreverses: true)) {
                    throb_two.toggle()
                }
            }
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "police", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
