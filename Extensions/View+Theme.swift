import SwiftUI

extension View {
    func withTheme() -> some View {
        self.modifier(ThemeModifier())
    }
}

struct ThemeModifier: ViewModifier {
    @EnvironmentObject private var themeService: ThemeService
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(themeService.currentTheme.textPrimary)
            .background(
                themeService.currentTheme.primaryColor
                    .opacity(themeService.currentTheme.opacity)
            )
            .animation(.easeInOut(duration: 0.3), value: themeService.currentTheme.id)
    }
} 