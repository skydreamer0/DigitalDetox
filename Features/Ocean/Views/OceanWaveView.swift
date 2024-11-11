import SwiftUI

struct OceanWaveView: View {
    @State private var phase = 0.0
    
    // 調整參數使波浪更緩慢平緩
    private let frequency = 1.2    // 降低頻率，原為 3.2
    private let amplitude = 15.0   // 降低振幅，原為 25.3
    private let opacity = 0.1      // 降低透明度，原為 0.13
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 第一層波浪（最底層）
                WavePath(
                    offset: phase,
                    amplitude: amplitude,
                    frequency: frequency
                )
                .fill(Color.oceanTheme.mediumBlue.opacity(opacity))
                
                // 第二層波浪（中層）
                WavePath(
                    offset: phase * 0.8,
                    amplitude: amplitude * 0.8,
                    frequency: frequency * 0.9
                )
                .fill(Color.oceanTheme.lightBlue.opacity(opacity * 0.8))
                
                // 第三層波浪（最上層）
                WavePath(
                    offset: phase * 0.6,
                    amplitude: amplitude * 0.6,
                    frequency: frequency * 0.8
                )
                .fill(Color.oceanTheme.lightBlue.opacity(opacity * 0.6))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                // 使用單一緩慢的無限循環動畫
                withAnimation(
                    .linear(duration: 12)  // 動畫週期加長到12秒
                    .repeatForever(autoreverses: false)
                ) {
                    phase = .pi * 2
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    OceanWaveView()
        .frame(height: 300)
        .background(Color.oceanTheme.deepBlue)
} 