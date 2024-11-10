import SwiftUI
import Combine

class BreatheViewModel: ObservableObject {
    @Published var session: BreathingSession?
    @Published var currentPhase: BreathingPhase = .inhale
    @Published var timeRemaining: TimeInterval = 0
    @Published var isActive = false
    @Published var selectedPattern: BreathingPattern = .defaultPattern
    
    // 音頻相關狀態
    @Published var breathGuidanceEnabled: Bool = true
    @Published var backgroundMusicEnabled: Bool = true
    
    private var timer: Timer?
    private let audioService = BreatheAudioService.shared
    
    // MARK: - 音頻控制
    
    // 切換呼吸引導音效
    func toggleBreathGuidance() {
        breathGuidanceEnabled.toggle()
        if !breathGuidanceEnabled {
            audioService.stopBreathSound()
        }
    }
    
    // 切換背景音樂
    func toggleBackgroundMusic() {
        backgroundMusicEnabled.toggle()
        if backgroundMusicEnabled {
            audioService.playBackgroundMusic("ocean_waves")
        } else {
            audioService.stopBackgroundMusic()
        }
    }
    
    // MARK: - 呼吸控制
    
    func startSession() {
        session = BreathingSession(pattern: selectedPattern)
        currentPhase = .inhale
        timeRemaining = selectedPattern.inhaleTime
        isActive = true
        
        // 開始背景音樂
        if backgroundMusicEnabled {
            audioService.playBackgroundMusic("ocean_waves")
        }
        
        startTimer()
    }
    
    func pauseSession() {
        isActive = false
        timer?.invalidate()
        audioService.stopBackgroundMusic()
    }
    
    func resumeSession() {
        isActive = true
        if backgroundMusicEnabled {
            audioService.playBackgroundMusic("ocean_waves")
        }
        startTimer()
    }
    
    func stopSession() {
        if let currentSession = session {
            // 保存練習記錄
            DigitalDetoxModel.shared.saveBreathingSession(currentSession)
        }
        
        timer?.invalidate()
        session = nil
        isActive = false
        currentPhase = .inhale
        timeRemaining = 0
        audioService.stopBackgroundMusic()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateBreathing()
        }
    }
    
    private func updateBreathing() {
        guard isActive else { return }
        
        timeRemaining -= 0.1
        
        if timeRemaining <= 0 {
            moveToNextPhase()
        }
        
        // 只在啟用引導音效時播放
        if breathGuidanceEnabled {
            audioService.playSound(for: currentPhase)
        }
    }
    
    private func moveToNextPhase() {
        guard var currentSession = session else { return }
        
        switch currentPhase {
        case .inhale:
            currentPhase = .hold
            timeRemaining = selectedPattern.holdTime
        case .hold:
            currentPhase = .exhale
            timeRemaining = selectedPattern.exhaleTime
        case .exhale:
            if currentSession.currentCycle >= selectedPattern.cycles {
                stopSession()
            } else {
                currentSession.currentCycle += 1
                currentPhase = .inhale
                timeRemaining = selectedPattern.inhaleTime
                session = currentSession
            }
        case .rest:
            break
        }
    }
    
    // 添加重置方法
    func resetSession() {
        timer?.invalidate()
        session = nil
        isActive = false
        currentPhase = .inhale
        timeRemaining = 0
        audioService.stopBackgroundMusic()
        audioService.stopBreathSound()
    }
    
    // MARK: - 清理
    
    deinit {
        timer?.invalidate()
        audioService.stopBackgroundMusic()
    }
} 