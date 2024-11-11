import SwiftUI

extension View {
    func oceanBackground() -> some View {
        self.background(
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
        )
    }
    
    func cardStyle() -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.oceanTheme.cardBackground)
                .shadow(color: Color.oceanTheme.deepBlue.opacity(0.3), radius: 10)
        )
        .padding(.horizontal)
    }
    
    func navigationBarSetup(title: String) -> some View {
        self.navigationTitle(title)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
} 