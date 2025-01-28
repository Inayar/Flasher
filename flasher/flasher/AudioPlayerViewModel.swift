
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var currentTrack: String? = nil
    
    func playOrPause(trackName: String, type: String = "mp3") {
        if currentTrack == trackName {
            togglePlayPause()
            return
        }
        
        LoadTrack(name: trackName, type: type)
        audioPlayer?.play()
        isPlaying = true
        
        func LoadTrack(name: String, type: String) {
            if isPlaying {
                audioPlayer?.stop()
                isPlaying = false
            }
            
            if let soundPath = Bundle.main.path(forResource: name, ofType: type) {
                do{
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
                    currentTrack = name
                    print("Трек загружен: \(name)")
                }catch{
                    print("Ошибка загрузки аудиофайла: \(error.localizedDescription)")
                }
            } else {
                print("Файл \(name).\(type) не найден в Bundle.")
            }
        }
        
        func togglePlayPause() {
            guard let player = audioPlayer else {
                print("Аудиоплеер не инициализирован.")
                return
            }
            
            if player.isPlaying {
                player.pause()
                isPlaying = false
            } else {
                player.play()
                isPlaying = true
            }
        }
        
    }
}
