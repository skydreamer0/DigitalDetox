import SwiftUI

// MARK: - 波浪視圖
struct OceanWaveView: View {  // 改名以避免衝突
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            // 第一層波浪
            OceanWaveShape(frequency: 3, amplitude: 20)  // 改名以避免衝突
                .fill(Color.oceanTheme.mediumBlue.opacity(0.3))
                .offset(x: CGFloat(waveOffset.degrees))
                .ignoresSafeArea()
            
            // 第二層波浪（錯開相位）
            OceanWaveShape(frequency: 4, amplitude: 15)  // 改名以避免衝突
                .fill(Color.oceanTheme.lightBlue.opacity(0.2))
                .offset(x: -CGFloat(waveOffset.degrees))
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false)
            ) {
                waveOffset = Angle(degrees: 360)
            }
        }
    }
}

// MARK: - 波浪形狀
struct OceanWaveShape: Shape {  // 改名以避免衝突
    let frequency: Double
    let amplitude: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        
        for x in stride(from: 0, through: rect.width, by: 1) {
            let y = sin(x / rect.width * .pi * frequency) * amplitude + rect.midY
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - 預覽
struct OceanComponents_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // 波浪視圖預覽
            OceanWaveView()
                .frame(height: 200)
                .background(Color.oceanTheme.deepBlue)
            
            // 波浪形狀預覽
            OceanWaveShape(frequency: 3, amplitude: 20)
                .fill(Color.oceanTheme.mediumBlue.opacity(0.3))
                .frame(height: 100)
        }
        .padding()
    }
} 