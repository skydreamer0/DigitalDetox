import SwiftUI

struct OceanWaveView: View {
    @EnvironmentObject private var themeService: ThemeService
    @State private var phase = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let midHeight = height / 2
            let wavelength = width
            let amplitude = height * 0.05
            
            ZStack {
                // 第一層波浪
                WavePath(
                    offset: phase,
                    amplitude: amplitude,
                    frequency: wavelength
                )
                .fill(
                    themeService.currentTheme.lightBlue
                        .opacity(themeService.currentTheme.waveOpacity)
                )
                
                // 第二層波浪
                WavePath(
                    offset: phase * 2,
                    amplitude: amplitude * 0.8,
                    frequency: wavelength * 1.2
                )
                .fill(
                    themeService.currentTheme.mediumBlue
                        .opacity(themeService.currentTheme.waveOpacity * 0.8)
                )
                
                // 第三層波浪
                WavePath(
                    offset: phase * 1.5,
                    amplitude: amplitude * 1.2,
                    frequency: wavelength * 1.4
                )
                .fill(
                    themeService.currentTheme.deepBlue
                        .opacity(themeService.currentTheme.waveOpacity * 0.6)
                )
            }
            .onAppear {
                withAnimation(
                    .linear(duration: 8)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = .pi * 2
                }
            }
        }
    }
}

#Preview {
    OceanWaveView()
        .frame(height: 200)
        .environmentObject(ThemeService.shared)
} 