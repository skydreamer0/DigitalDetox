import SwiftUI

struct ThemeSwitcher: View {
    @EnvironmentObject private var themeManager: OceanThemeManager
    
    var body: some View {
        Menu {
            ForEach(themeManager.availableThemes, id: \.themeName) { theme in
                Button(action: {
                    themeManager.switchTheme(theme)
                }) {
                    HStack {
                        Circle()
                            .fill(theme.primaryColor)
                            .frame(width: 20, height: 20)
                        Text(theme.themeName)
                        if theme.themeName == themeManager.currentTheme.themeName {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "paintpalette")
                .imageScale(.large)
        }
    }
} 