import SwiftUI

struct BreatheGuideView: View {
    @Binding var currentPhase: BreathingPhase
    let pattern: BreathingPattern
    
    var body: some View {
        VStack(spacing: 20) {
            Text(currentPhase.rawValue)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Text(guideText)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding()
            
            PhaseProgressView(phase: currentPhase, pattern: pattern)
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.clear
        )
    }
    
    private var guideText: String {
        switch currentPhase {
        case .inhale:
            return "緩慢吸氣，感受空氣流入"
        case .hold:
            return "保持呼吸，保持平靜"
        case .exhale:
            return "緩慢呼氣，釋放壓力"
        case .rest:
            return "休息片刻，準備下一輪"
        }
    }
}

struct PhaseProgressView: View {
    let phase: BreathingPhase
    let pattern: BreathingPattern
    
    var body: some View {
        // 實現進度指示器
        Circle()
            .stroke(Color.white.opacity(0.2), lineWidth: 4)
            .overlay(
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.white, lineWidth: 4)
                    .rotationEffect(.degrees(-90))
            )
            .frame(width: 100, height: 100)
    }
    
    private var progress: Double {
        // 根據當前階段計算進度
        switch phase {
        case .inhale:
            return pattern.inhaleTime / totalTime
        case .hold:
            return pattern.holdTime / totalTime
        case .exhale:
            return pattern.exhaleTime / totalTime
        case .rest:
            return 0
        }
    }
    
    private var totalTime: Double {
        pattern.inhaleTime + pattern.holdTime + pattern.exhaleTime
    }
} 