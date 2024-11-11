import SwiftUI

// 直接開始主題實現
public struct DefaultOceanTheme: OceanThemeConfigurable {
    public init() {}
    
    public let primaryColor = Color(hex: "0A2342")
    public let secondaryColor = Color(hex: "126872")
    public let deepBlue = Color(hex: "001B3D")
    public let mediumBlue = Color(hex: "126872")
    public let lightBlue = Color(hex: "2AA5A5")
    public let coral = Color(hex: "FF7F50")
    public let accent = Color(hex: "FF6B6B")
    public let textPrimary = Color.white
    public let opacity = 0.13
    public let waveOpacity = 0.3
    public let themeName = "Default Ocean"
}

// 深邃夜空主題
public struct DeepNightTheme: OceanThemeConfigurable {
    public init() {} // 添加公開初始化器
    
    public let primaryColor = Color(hex: "001B3D")
    public let secondaryColor = Color(hex: "003366")
    public let deepBlue = Color(hex: "000B1E")
    public let mediumBlue = Color(hex: "001B3D")
    public let lightBlue = Color(hex: "003366")
    public let coral = Color(hex: "FF6B6B")
    public let accent = Color(hex: "4A90E2")
    public let textPrimary = Color.white
    public let opacity = 0.4
    public let waveOpacity = 0.35
    public let themeName = "Deep Night"
}

// 珊瑚礁主題
public struct CoralReefTheme: OceanThemeConfigurable {
    public init() {} // 添加公開初始化器
    
    public let primaryColor = Color(hex: "FF7F50")
    public let secondaryColor = Color(hex: "FF6B6B")
    public let deepBlue = Color(hex: "FF6B6B")
    public let mediumBlue = Color(hex: "FF6B6B")
    public let lightBlue = Color(hex: "FF6B6B")
    public let coral = Color(hex: "FF6B6B")
    public let accent = Color(hex: "FF6B6B")
    public let textPrimary = Color.white
    public let opacity = 0.3
    public let waveOpacity = 0.3
    public let themeName = "Coral Reef"
}

// 極光主題
public struct AuroraTheme: OceanThemeConfigurable {
    public init() {} // 添加公開初始化器
    
    public let primaryColor = Color(hex: "39FF14")
    public let secondaryColor = Color(hex: "00FF80")
    public let deepBlue = Color(hex: "00FF80")
    public let mediumBlue = Color(hex: "00FF80")
    public let lightBlue = Color(hex: "00FF80")
    public let coral = Color(hex: "00FF80")
    public let accent = Color(hex: "00FF80")
    public let textPrimary = Color.white
    public let opacity = 0.25
    public let waveOpacity = 0.3
    public let themeName = "Aurora"
} 