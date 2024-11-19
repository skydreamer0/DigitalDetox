import SwiftUI

struct OceanThemeComponentsTest: View {
    @EnvironmentObject private var themeService: ThemeService
    @State private var isAnimating = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // 背景
            themeService.currentTheme.primaryColor
                .opacity(0.3)
                .ignoresSafeArea()
            
            // 測試內容
            VStack(spacing: 30) {
                // 波浪效果
                if themeService.currentTheme.hasWaveEffect {
                    OceanWaveView()
                        .frame(height: 200)
                }
                
                // 氣泡效果
                if themeService.currentTheme.hasBubbleEffect {
                    BubbleEffect()
                        .frame(height: 200)
                }
                
                // 顏色測試
                ColorTestView(theme: themeService.currentTheme)
                
                // 動畫控制
                AnimationControlView(
                    isAnimating: $isAnimating,
                    scale: $scale
                )
            }
            .padding()
        }
        .navigationTitle("主題元件測試")
    }
}

private struct ColorTestView: View {
    let theme: any ThemeConfigurable
    
    var body: some View {
        VStack(spacing: 10) {
            Text("顏色測試")
                .foregroundColor(theme.textPrimary)
            
            HStack(spacing: 8) {
                ColorCircle(color: theme.primaryColor, name: "Primary")
                ColorCircle(color: theme.secondaryColor, name: "Secondary")
                ColorCircle(color: theme.accent, name: "Accent")
                ColorCircle(color: theme.coral, name: "Coral")
            }
        }
    }
}

private struct ColorCircle: View {
    let color: Color
    let name: String
    
    var body: some View {
        VStack {
            Circle()
                .fill(color)
                .frame(width: 30, height: 30)
            Text(name)
                .font(.caption)
        }
    }
}

private struct AnimationControlView: View {
    @Binding var isAnimating: Bool
    @Binding var scale: CGFloat
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                withAnimation {
                    isAnimating.toggle()
                    scale = isAnimating ? 1.2 : 1.0
                }
            }) {
                Image(systemName: isAnimating ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
            }
            
            Button(action: {
                withAnimation {
                    isAnimating = false
                    scale = 1.0
                }
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
            }
        }
    }
} 
