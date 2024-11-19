import SwiftUI

extension View {
    // 卡片動畫
    func cardAnimation(delay: Double = 0) -> some View {
        self.modifier(CardAnimationModifier(delay: delay))
    }
    
    // 數據更新動畫
    func dataUpdateAnimation() -> some View {
        self.modifier(DataUpdateAnimationModifier())
    }
    
    // 波紋效果
    func rippleEffect() -> some View {
        self.modifier(RippleEffectModifier())
    }
}

// 卡片動畫修飾器
struct CardAnimationModifier: ViewModifier {
    let delay: Double
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5).delay(delay)) {
                    isVisible = true
                }
            }
    }
}

// 數據更新動畫修飾器
struct DataUpdateAnimationModifier: ViewModifier {
    @State private var isUpdating = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isUpdating ? 1.05 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isUpdating)
            .onAppear {
                isUpdating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isUpdating = false
                }
            }
    }
}

// 波紋效果修飾器
struct RippleEffectModifier: ViewModifier {
    @EnvironmentObject private var themeService: ThemeService
    @State private var isRippling = false
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(themeService.currentTheme.accent)
                    .scaleEffect(isRippling ? 2 : 1)
                    .opacity(isRippling ? 0 : 0.3)
            )
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                    isRippling = true
                }
            }
    }
} 