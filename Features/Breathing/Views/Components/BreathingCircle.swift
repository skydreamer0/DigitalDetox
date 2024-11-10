import SwiftUI

struct BreathingCircle: View {
    let phase: BreathingPhase
    let scale: CGFloat
    
    var body: some View {
        Circle()
            .strokeBorder(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.oceanTheme.coral,
                        Color.oceanTheme.lightBlue
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: 3
            )
            .frame(width: 200, height: 200)
            .scaleEffect(scale)
            .overlay(
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .blur(radius: 5)
                    .scaleEffect(0.8)
            )
    }
} 