import SwiftUI

extension View {
    func oceanNavigationBar(title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.oceanTheme.deepBlue,
                        Color.oceanTheme.deepBlue.opacity(0.85)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
    }
} 