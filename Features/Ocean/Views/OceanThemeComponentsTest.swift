import SwiftUI

struct OceanThemeComponentsTest: View {
    @StateObject private var themeManager = OceanThemeManager()
    @State private var isAnimating = false
    @State private var breathingPhase: BreathingPhase = .inhale
    @State private var progress: CGFloat = 0.0
    @State private var scale: CGFloat = 1.0
    @State private var timeRemaining: TimeInterval = 4.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 深海背景
            OceanThemeComponents.DeepOceanBackground()
                .ignoresSafeArea()
            
            // 波浪效果
            OceanWaveView()
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: scale)
            
            // 將呼吸圈放在中心
            ZStack {
                // 呼吸圈
                BreathingCircle(
                    phase: breathingPhase,
                    progress: progress
                )
                
                // 氣泡效果
                OceanThemeComponents.BubbleCluster(isAnimating: isAnimating)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 控制按鈕組 - 移到底部
            VStack {
                Spacer()
                
                HStack(spacing: 20) {
                    // 開始/暫停按鈕
                    Button(action: {
                        withAnimation {
                            isAnimating.toggle()
                            if isAnimating {
                                scale = 1.2
                            } else {
                                scale = 1.0
                            }
                        }
                    }) {
                        Image(systemName: isAnimating ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                    }
                    
                    // 重置按鈕
                    Button(action: {
                        withAnimation {
                            resetAnimation()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .environmentObject(themeManager)
        .onReceive(timer) { _ in
            guard isAnimating else { return }
            updateProgress()
        }
    }
    
    private func updateProgress() {
        withAnimation(.linear(duration: 0.1)) {
            if progress < 1.0 {
                progress += 0.01
                timeRemaining = max(0, 4.0 * (1.0 - Double(progress)))
            } else {
                progress = 0.0
                timeRemaining = 4.0
                moveToNextPhase()
            }
        }
    }
    
    private func moveToNextPhase() {
        withAnimation {
            switch breathingPhase {
            case .inhale:
                breathingPhase = .hold
            case .hold:
                breathingPhase = .exhale
            case .exhale:
                breathingPhase = .rest
            case .rest:
                breathingPhase = .inhale
            }
            timeRemaining = 4.0
        }
    }
    
    private func resetAnimation() {
        isAnimating = false
        breathingPhase = .inhale
        progress = 0.0
        scale = 1.0
        timeRemaining = 4.0
    }
}

#Preview {
    OceanThemeComponentsTest()
        .environmentObject(OceanThemeManager())
} 
