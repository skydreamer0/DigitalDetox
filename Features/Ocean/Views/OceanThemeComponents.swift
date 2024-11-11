import SwiftUI

// 海洋主題相關的所有基礎元件
public struct OceanThemeComponents {
    // 深層海水背景
    public struct DeepOceanBackground: View {
        public var body: some View {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "0A2342"),
                    Color(hex: "126872"),
                    Color(hex: "2AA5A5").opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .overlay(
                NoisePattern()
                    .opacity(0.05)
            )
            .ignoresSafeArea(edges: .all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    // 漣漪效果
    public struct RippleEffect: View {
        let isAnimating: Bool
        @State private var scale: CGFloat = 1.0
        @State private var opacity: Double = 0.5
        
        public var body: some View {
            Circle()
                .stroke(Color.white.opacity(opacity), lineWidth: 2)
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    guard isAnimating else { return }
                    withAnimation(
                        .easeInOut(duration: 2)
                        .repeatForever(autoreverses: false)
                    ) {
                        scale = 2.0
                        opacity = 0
                    }
                }
        }
    }
    
    // 氣泡群
    public struct BubbleCluster: View {
        let isAnimating: Bool
        
        public var body: some View {
            BubbleEffect()
                .opacity(isAnimating ? 1 : 0.3)
        }
    }
} 