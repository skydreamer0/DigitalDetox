import AVFoundation
import Combine

class BreatheAudioService: ObservableObject {
    static let shared = BreatheAudioService()
    
    @Published private(set) var isBackgroundMusicPlaying = false
    @Published private(set) var currentMusic: MusicOption?
    
    struct MusicOption: Identifiable {
        let id = UUID()
        let name: String
        let fileName: String
        let description: String
    }
    
    let musicOptions: [MusicOption] = [
        MusicOption(
            name: "Forest Dawn",
            fileName: "forest_dawn",
            description: "Dawn chorus in ancient woods, where birdsong and gentle breeze create nature's symphony"
        ),
        MusicOption(
            name: "Sacred Flame",
            fileName: "sacred_flame",
            description: "Temple hearth's eternal flame, where crackling embers whisper ancient wisdom"
        ),
        MusicOption(
            name: "Zen Rain",
            fileName: "zen_rain",
            description: "Bamboo grove rainfall, where each drop on stone tells stories of serenity"
        ),
        MusicOption(
            name: "Singing Bowl",
            fileName: "singing_bowl",
            description: "Himalayan resonance, where pure vibrations guide the soul to profound stillness"
        )
    ]
    
    private var backgroundPlayer: AVAudioPlayer?
    
    private init() {
        setupAudioSession()
        currentMusic = musicOptions.first
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("音頻會話設置失敗: \(error)")
        }
    }
    
    func playMusic(_ option: MusicOption) {
        guard let url = Bundle.main.url(forResource: option.fileName, withExtension: "mp3") else {
            print("找不到音樂文件: \(option.fileName)")
            return
        }
        
        do {
            backgroundPlayer?.stop()
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.3
            backgroundPlayer?.play()
            
            DispatchQueue.main.async {
                self.currentMusic = option
                self.isBackgroundMusicPlaying = true
            }
        } catch {
            print("播放音樂失敗: \(error)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
        backgroundPlayer = nil
        DispatchQueue.main.async {
            self.isBackgroundMusicPlaying = false
        }
    }
    
    func pauseBackgroundMusicIfNeeded() {
        guard isBackgroundMusicPlaying else { return }
        backgroundPlayer?.pause()
        DispatchQueue.main.async {
            self.isBackgroundMusicPlaying = false
        }
    }
    
    func resumeBackgroundMusicIfNeeded() {
        guard !isBackgroundMusicPlaying, backgroundPlayer != nil else { return }
        backgroundPlayer?.play()
        DispatchQueue.main.async {
            self.isBackgroundMusicPlaying = true
        }
    }
} 