// BreathingSessionViewModel.swift
//檔案位置: Features/Breathing/BreathingSessionViewModel/BreathingSessionViewModel.swift
//功能：定義呼吸會話的邏輯

import Foundation
import Combine

class BreatheSessionViewModel: ObservableObject {
    @Published var currentPhase: BreathingPhase = .inhale
    @Published var progress: CGFloat = 0.0
    @Published var isBreathing = false
    @Published var currentCycle = 0
    
    private var timer: Timer?
    private var pattern: BreathingPattern
    private var phaseStartTime: Date?
    private let audioService = BreatheAudioService.shared
    
    init(pattern: BreathingPattern = .defaultPattern) {
        self.pattern = pattern
    }
    
    func startBreathing() {
        isBreathing = true
        currentCycle = 0
        startNewPhase(.inhale)
        // 開始播放當前選擇的音樂，如果沒有選擇則播放第一個
        if let currentMusic = audioService.currentMusic {
            audioService.playMusic(currentMusic)
        } else if let firstMusic = audioService.musicOptions.first {
            audioService.playMusic(firstMusic)
        }
    }
    
    func pauseBreathing() {
        isBreathing = false
        timer?.invalidate()
        timer = nil
        // 暫停背景音樂
        audioService.pauseBackgroundMusicIfNeeded()
    }
    
    func resumeBreathing() {
        isBreathing = true
        startNewPhase(currentPhase)
        // 恢復背景音樂
        audioService.resumeBackgroundMusicIfNeeded()
    }
    
    func stopBreathing() {
        isBreathing = false
        currentPhase = .inhale
        progress = 0.0
        currentCycle = 0
        timer?.invalidate()
        timer = nil
        // 停止背景音樂
        audioService.stopBackgroundMusic()
    }
    
    private func startNewPhase(_ phase: BreathingPhase) {
        currentPhase = phase
        progress = 0.0
        phaseStartTime = Date()
        
        let duration = timeForPhase(phase)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateProgress(duration: duration)
        }
    }
    
    private func updateProgress(duration: TimeInterval) {
        guard let startTime = phaseStartTime else { return }
        let elapsed = Date().timeIntervalSince(startTime)
        progress = min(CGFloat(elapsed / duration), 1.0)
        
        if progress >= 1.0 {
            moveToNextPhase()
        }
    }
    
    private func moveToNextPhase() {
        switch currentPhase {
        case .inhale:
            startNewPhase(.hold)
        case .hold:
            startNewPhase(.exhale)
        case .exhale:
            if currentCycle < pattern.cycles - 1 {
                currentCycle += 1
                startNewPhase(.inhale)
            } else {
                stopBreathing()
            }
        case .rest:
            startNewPhase(.inhale)
        }
    }
    
    private func timeForPhase(_ phase: BreathingPhase) -> TimeInterval {
        switch phase {
        case .inhale:
            return pattern.inhaleTime
        case .hold:
            return pattern.holdTime
        case .exhale:
            return pattern.exhaleTime
        case .rest:
            return 2.0  // 固定休息時間
        }
    }
    
    func updatePattern(_ newPattern: BreathingPattern) {
        self.pattern = newPattern
        // 如果正在進行呼吸，可能需要重置當前階段
        if isBreathing {
            startNewPhase(currentPhase)
        }
    }
} 