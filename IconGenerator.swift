import SwiftUI

// 將 WaveShape 改為 IconWaveShape 並設為 private
private struct IconWaveShape: Shape {
    var offset: Angle
    var percent: Double
    var amplitude: CGFloat = 20
    var frequency: CGFloat = 5
    var phase: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height * CGFloat(percent)
        let wavelength = width / frequency
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let sine = sin(relativeX + offset.radians + phase)
            let y = midHeight + amplitude * CGFloat(sine)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}

// 圖標生成器
struct IconGenerator: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 背景漸層
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "1B4965"),
                        Color(hex: "62B6CB")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // 波浪效果 - 根據尺寸調整
                Group {
                    let size = min(geometry.size.width, geometry.size.height)
                    let scale = size / 1024 // 使用相對比例
                    
                    // 波浪層
                    IconWaveShape(offset: .degrees(0), percent: 0.6,
                                amplitude: 30 * scale,
                                frequency: 8,
                                phase: .pi / 3)
                        .fill(Color(hex: "BEE9E8").opacity(0.3))
                        .offset(y: 200 * scale)
                    
                    IconWaveShape(offset: .degrees(0), percent: 0.65,
                                amplitude: 25 * scale,
                                frequency: 6,
                                phase: .pi / 2)
                        .fill(Color(hex: "62B6CB").opacity(0.4))
                        .offset(y: 250 * scale)
                    
                    IconWaveShape(offset: .degrees(0), percent: 0.7,
                                amplitude: 20 * scale,
                                frequency: 7,
                                phase: .pi / 4)
                        .fill(Color(hex: "CAE9FF").opacity(0.3))
                        .offset(y: 300 * scale)
                    
                    // 珊瑚圖案
                    CoralShape(scale: scale)
                    
                    // 氣泡效果
                    BubbleEffects(scale: scale)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// 將珊瑚圖案抽取為獨立組件
private struct CoralShape: View {
    let scale: CGFloat
    
    var body: some View {
        VStack(spacing: -25 * scale) {
            HStack(spacing: -30 * scale) {
                Image(systemName: "leaf.fill")
                    .rotationEffect(.degrees(45))
                Image(systemName: "leaf.fill")
                    .rotationEffect(.degrees(-45))
            }
            Image(systemName: "leaf.fill")
                .rotationEffect(.degrees(180))
        }
        .font(.system(size: 180 * scale, weight: .bold))
        .foregroundStyle(
            LinearGradient(
                colors: [
                    Color(hex: "FF9B71"),
                    Color(hex: "FF7D5C")
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// 氣泡效果組件
private struct BubbleEffects: View {
    let scale: CGFloat
    
    var body: some View {
        ForEach(0..<3) { index in
            Circle()
                .fill(Color.white)
                .frame(width: [20, 30, 15][index] * scale)
                .offset(
                    x: [-100, 80, 120][index] * scale,
                    y: [-120, -80, -100][index] * scale
                )
        }
    }
}

#Preview("App Icon") {
    IconGenerator()
        .frame(width: 1024, height: 1024)
}

// 添加一個額外的預覽來查看不同尺寸
#Preview("Icon Sizes") {
    VStack(spacing: 20) {
        // App Store size
        IconGenerator()
            .frame(width: 1024, height: 1024)
            .scaleEffect(0.1)
        
        // iPhone sizes
        HStack(spacing: 20) {
            IconGenerator()
                .frame(width: 60, height: 60)
            IconGenerator()
                .frame(width: 87, height: 87)
            IconGenerator()
                .frame(width: 180, height: 180)
        }
    }
    .padding()
} 