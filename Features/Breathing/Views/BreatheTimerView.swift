import SwiftUI

struct BreatheTimerView: View {
    let phase: BreathingPhase
    let progress: CGFloat
    let timeRemaining: TimeInterval
    
    var body: some View {
        VStack(spacing: 20) {
            // 進度環
            ZStack {
                Circle()
                    .stroke(Color.oceanTheme.lightBlue.opacity(0.2), lineWidth: 10)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.oceanTheme.coral, style: StrokeStyle(
                        lineWidth: 10,
                        lineCap: .round
                    ))
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.1), value: progress)
            }
            .frame(width: 250, height: 250)
            
            // 階段文字
            Text(phase.rawValue)
                .font(.title)
                .foregroundColor(Color.oceanTheme.textPrimary)
            
            // 剩餘時間
            Text(String(format: "%.1f", timeRemaining))
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color.oceanTheme.coral)
        }
    }
} 