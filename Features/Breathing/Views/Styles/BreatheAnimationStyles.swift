import SwiftUI

// 按鈕縮放樣式
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// 氣泡背景視圖
struct BubblesBackground: View {
    let isAnimating: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<15) { index in
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: CGFloat.random(in: 10...30))
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? 
                            geometry.size.height + 100 : 
                            -100
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 5...10))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...3)),
                        value: isAnimating
                    )
            }
        }
    }
} 