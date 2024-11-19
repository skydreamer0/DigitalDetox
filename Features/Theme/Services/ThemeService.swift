import SwiftUI
import Combine

@MainActor
public final class ThemeService: ObservableObject {
    static let shared = ThemeService()
    
    @Published private(set) var currentTheme: any ThemeConfigurable
    @Published private(set) var availableThemes: [any ThemeConfigurable] = []
    @Published private(set) var purchasedThemes: Set<UUID> = []
    
    private let storeService: StoreService
    private let userDefaults = UserDefaults.standard
    
    init(storeService: StoreService = .shared) {
        self.storeService = storeService
        self.currentTheme = Self.defaultTheme
        loadThemes()
    }
    
    private func loadThemes() {
        availableThemes = [
            OceanTheme.defaultOcean,
            OceanTheme.deepNight,
            OceanTheme.coralReef,
            OceanTheme.aurora
        ]
    }
    
    func switchTheme(_ theme: any ThemeConfigurable) {
        guard theme.isPurchased else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            currentTheme = theme
            saveThemePreference()
        }
    }
    
    func purchaseTheme(_ theme: any ThemeConfigurable) async throws {
        guard let price = theme.price else { return }
        try await storeService.purchaseItem(id: theme.id, price: price)
        await MainActor.run {
            purchasedThemes.insert(theme.id)
            updateThemeStatus()
        }
    }
    
    private func updateThemeStatus() {
        availableThemes = availableThemes.map { theme in
            if purchasedThemes.contains(theme.id) {
                return ThemeModel(
                    id: theme.id,
                    name: theme.name,
                    description: theme.description,
                    previewImageName: theme.previewImageName,
                    price: theme.price,
                    isPurchased: true,
                    themeType: theme.themeType
                )
            }
            return theme
        }
    }
    
    private func saveThemePreference() {
        userDefaults.set(currentTheme.id.uuidString, forKey: "selectedThemeId")
    }
    
    static var defaultTheme: any ThemeConfigurable {
        ThemeModel(
            id: UUID(),
            name: "Ocean Breeze",
            description: "Default ocean theme",
            previewImageName: "theme_ocean_preview",
            price: nil,
            isPurchased: true,
            themeType: .ocean
        )
    }
} 