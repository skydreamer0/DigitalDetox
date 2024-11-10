import SwiftUI

struct BubbleEffect: View {
    let bubbleCount = 20
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<bubbleCount, id: \.self) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.3),
                                .white.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: CGFloat.random(in: 5...20))
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? -20 : geometry.size.height + 20
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 4...8))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...3)),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
} 