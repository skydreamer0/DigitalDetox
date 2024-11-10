import AVFoundation

enum AudioType {
    case inhale, hold, exhale
    case background(String) // 背景音樂名稱
}

class BreatheAudioService {
    static let shared = BreatheAudioService()
    
    private var breathSoundPlayer: AVAudioPlayer?
    private var backgroundPlayer: AVAudioPlayer?
    
    // 音量控制
    var breathSoundVolume: Float = 0.7  // 呼吸引導音效音量
    var backgroundVolume: Float = 0.3   // 背景音樂音量
    
    // 播放呼吸引導音效
    func playSound(for phase: BreathingPhase) {
        let soundName: String
        switch phase {
        case .inhale:
            soundName = "inhale_sound"
        case .hold:
            soundName = "hold_sound"
        case .exhale:
            soundName = "exhale_sound"
        case .rest:
            return
        }
        
        playBreathSound(named: soundName)
    }
    
    // 停止呼吸引導音效
    func stopBreathSound() {
        breathSoundPlayer?.stop()
    }
    
    // 播放背景音樂
    func playBackgroundMusic(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1 // 循環播放
            backgroundPlayer?.volume = backgroundVolume
            backgroundPlayer?.play()
        } catch {
            print("背景音樂播放失敗: \(error)")
        }
    }
    
    // 停止背景音樂
    func stopBackgroundMusic() {
        backgroundPlayer?.stop()
    }
    
    private func playBreathSound(named: String) {
        guard let url = Bundle.main.url(forResource: named, withExtension: "mp3") else { return }
        
        do {
            breathSoundPlayer = try AVAudioPlayer(contentsOf: url)
            breathSoundPlayer?.volume = breathSoundVolume
            breathSoundPlayer?.play()
        } catch {
            print("呼吸音效播放失敗: \(error)")
        }
    }
} 