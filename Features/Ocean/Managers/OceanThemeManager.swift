import SwiftUI
import Combine

@MainActor
public final class OceanThemeManager: ObservableObject {
    @Published public var currentTheme: OceanThemeConfigurable
    @Published public var availableThemes: [OceanThemeConfigurable]
    
    private let themeKey = "selectedTheme"
    
    public init(theme: OceanThemeConfigurable = DefaultOceanTheme()) {
        self.currentTheme = theme
        self.availableThemes = [
            DefaultOceanTheme(),
            DeepNightTheme(),
            CoralReefTheme(),
            AuroraTheme()
        ]
        loadSavedTheme()
    }
    
    public func switchTheme(_ theme: OceanThemeConfigurable) {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentTheme = theme
        }
        saveThemePreference()
    }
    
    public func saveThemePreference() {
        UserDefaults.standard.set(currentTheme.themeName, forKey: themeKey)
    }
    
    private func loadSavedTheme() {
        if let savedThemeName = UserDefaults.standard.string(forKey: themeKey),
           let savedTheme = availableThemes.first(where: { $0.themeName == savedThemeName }) {
            currentTheme = savedTheme
        }
    }
    
    private func getThemeByName(_ name: String) -> OceanThemeConfigurable {
        return availableThemes.first { $0.themeName == name } ?? DefaultOceanTheme()
    }
}