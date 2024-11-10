import SwiftUI

struct BreatheAnimationView: View {
    let phase: BreathingPhase
    let isBreathing: Bool
    
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var waveOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            // 深層海水背景
            DeepOceanBackground()
            
            // 動態波浪層
            WaveLayers(isAnimating: isBreathing)
            
            // 光線效果
            LightRaysEffect(isAnimating: isBreathing)
            
            // 主要呼吸圓環
            BreathingCircle(phase: phase, scale: scale)
                .rotationEffect(.degrees(rotation))
                .overlay(
                    // 漣漪效果
                    RippleEffect(isAnimating: isBreathing)
                )
            
            // 氣泡群
            BubbleCluster(isBreathing: isBreathing)
        }
        .onChange(of: isBreathing) { oldValue, newValue in
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                scale = newValue ? 1.2 : 1.0
                rotation = newValue ? 360 : 0
            }
        }
    }
}

// 深層海水背景
struct DeepOceanBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "0A2342"),  // 深海藍
                Color(hex: "126872"),  // 中層藍綠
                Color(hex: "2AA5A5").opacity(0.6)  // 淺層藍綠
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay(
            NoisePattern()
                .opacity(0.05)
        )
    }
}

// 波浪層效果
struct WaveLayers: View {
    let isAnimating: Bool
    @State private var phase: CGFloat = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                WaveShape(frequency: Double(i + 1) * 2, amplitude: 10)
                    .fill(Color.oceanTheme.lightBlue.opacity(0.1 - Double(i) * 0.02))
                    .offset(x: phase * CGFloat(i + 1) * 20)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
}

// 光線效果
struct LightRaysEffect: View {
    let isAnimating: Bool
    @State private var rotation = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<8) { i in
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.2),
                                .white.opacity(0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 2, height: geometry.size.height * 0.7)
                    .rotationEffect(.degrees(Double(i) * 45 + rotation))
                    .offset(y: -geometry.size.height * 0.2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
        }
    }
}

// 漣漪效果
struct RippleEffect: View {
    let isAnimating: Bool
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Circle()
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    .scaleEffect(scale + CGFloat(i) * 0.1)
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                scale = 1.5
                opacity = 0
            }
        }
    }
}

// 氣泡群
struct BubbleCluster: View {
    let isBreathing: Bool
    
    var body: some View {
        BubbleEffect()
            .opacity(isBreathing ? 1 : 0.3)
    }
} 