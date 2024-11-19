import SwiftUI

public struct OceanTheme: ThemeConfigurable {
    public let id: UUID
    public let name: String
    public let description: String
    public let previewImageName: String
    public let price: Int?
    public let isPurchased: Bool
    
    public let primaryColor: Color
    public let secondaryColor: Color
    public let deepBlue: Color
    public let mediumBlue: Color
    public let lightBlue: Color
    public let coral: Color
    public let accent: Color
    public let textPrimary: Color
    public let textSecondary: Color
    
    public let opacity: Double
    public let waveOpacity: Double
    public let hasWaveEffect: Bool
    public let hasBubbleEffect: Bool
    
    public let themeType: ThemeType = .ocean
    
    // 預設主題
    public static let defaultOcean = OceanTheme(
        id: UUID(),
        name: "Ocean Blue",
        description: "Classic ocean theme",
        previewImageName: "theme_ocean_preview",
        price: nil,
        isPurchased: true,
        primaryColor: Color(hex: "1B4965"),
        secondaryColor: Color(hex: "62B6CB"),
        deepBlue: Color(hex: "1B4965"),
        mediumBlue: Color(hex: "62B6CB"),
        lightBlue: Color(hex: "BEE9E8"),
        coral: Color(hex: "FF9B71"),
        accent: Color(hex: "CAE9FF"),
        textPrimary: .white,
        textSecondary: Color(hex: "BEE9E8"),
        opacity: 0.3,
        waveOpacity: 0.3,
        hasWaveEffect: true,
        hasBubbleEffect: true
    )
    
    // 深邃夜空主題
    public static let deepNight = OceanTheme(
        id: UUID(),
        name: "Deep Night",
        description: "Mysterious deep ocean at night",
        previewImageName: "theme_deep_night_preview",
        price: 500,
        isPurchased: false,
        primaryColor: Color(hex: "001B3D"),
        secondaryColor: Color(hex: "003366"),
        deepBlue: Color(hex: "000B1E"),
        mediumBlue: Color(hex: "001B3D"),
        lightBlue: Color(hex: "003366"),
        coral: Color(hex: "FF6B6B"),
        accent: Color(hex: "4A90E2"),
        textPrimary: .white,
        textSecondary: Color(hex: "003366"),
        opacity: 0.4,
        waveOpacity: 0.35,
        hasWaveEffect: true,
        hasBubbleEffect: true
    )
    
    // 珊瑚礁主題
    public static let coralReef = OceanTheme(
        id: UUID(),
        name: "Coral Reef",
        description: "Beautiful coral reef",
        previewImageName: "theme_coral_reef_preview",
        price: 300,
        isPurchased: false,
        primaryColor: Color(hex: "FF7F50"),
        secondaryColor: Color(hex: "FF6B6B"),
        deepBlue: Color(hex: "FF6B6B"),
        mediumBlue: Color(hex: "FF6B6B"),
        lightBlue: Color(hex: "FF6B6B"),
        coral: Color(hex: "FF6B6B"),
        accent: Color(hex: "FF6B6B"),
        textPrimary: .white,
        textSecondary: Color(hex: "FF6B6B"),
        opacity: 0.3,
        waveOpacity: 0.3,
        hasWaveEffect: true,
        hasBubbleEffect: true
    )
    
    // 極光主題
    public static let aurora = OceanTheme(
        id: UUID(),
        name: "Aurora",
        description: "Stunning aurora borealis",
        previewImageName: "theme_aurora_preview",
        price: 400,
        isPurchased: false,
        primaryColor: Color(hex: "39FF14"),
        secondaryColor: Color(hex: "00FF80"),
        deepBlue: Color(hex: "00FF80"),
        mediumBlue: Color(hex: "00FF80"),
        lightBlue: Color(hex: "00FF80"),
        coral: Color(hex: "00FF80"),
        accent: Color(hex: "00FF80"),
        textPrimary: .white,
        textSecondary: Color(hex: "00FF80"),
        opacity: 0.25,
        waveOpacity: 0.3,
        hasWaveEffect: true,
        hasBubbleEffect: true
    )
    
    // ... 其他主題實現
} 