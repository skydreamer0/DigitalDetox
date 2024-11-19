import SwiftUI
import Foundation

struct ThemeModel: ThemeConfigurable, Codable {
    let id: UUID
    let name: String
    let description: String
    let previewImageName: String
    let price: Int?
    var isPurchased: Bool
    let themeType: ThemeType
    
    // ThemeConfigurable 必要屬性
    let primaryColor: Color
    let secondaryColor: Color
    let deepBlue: Color
    let mediumBlue: Color
    let lightBlue: Color
    let coral: Color
    let accent: Color
    let textPrimary: Color
    let textSecondary: Color
    
    let opacity: Double
    let waveOpacity: Double
    let hasWaveEffect: Bool
    let hasBubbleEffect: Bool
    
    // Codable 實現
    enum CodingKeys: String, CodingKey {
        case id, name, description, previewImageName, price, isPurchased, themeType
        case primaryColor, secondaryColor, deepBlue, mediumBlue, lightBlue
        case coral, accent, textPrimary, textSecondary
        case opacity, waveOpacity, hasWaveEffect, hasBubbleEffect
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        previewImageName = try container.decode(String.self, forKey: .previewImageName)
        price = try container.decodeIfPresent(Int.self, forKey: .price)
        isPurchased = try container.decode(Bool.self, forKey: .isPurchased)
        themeType = try container.decode(ThemeType.self, forKey: .themeType)
        
        // 解碼顏色（假設使用十六進制字符串）
        primaryColor = Color(hex: try container.decode(String.self, forKey: .primaryColor))
        secondaryColor = Color(hex: try container.decode(String.self, forKey: .secondaryColor))
        deepBlue = Color(hex: try container.decode(String.self, forKey: .deepBlue))
        mediumBlue = Color(hex: try container.decode(String.self, forKey: .mediumBlue))
        lightBlue = Color(hex: try container.decode(String.self, forKey: .lightBlue))
        coral = Color(hex: try container.decode(String.self, forKey: .coral))
        accent = Color(hex: try container.decode(String.self, forKey: .accent))
        textPrimary = Color(hex: try container.decode(String.self, forKey: .textPrimary))
        textSecondary = Color(hex: try container.decode(String.self, forKey: .textSecondary))
        
        opacity = try container.decode(Double.self, forKey: .opacity)
        waveOpacity = try container.decode(Double.self, forKey: .waveOpacity)
        hasWaveEffect = try container.decode(Bool.self, forKey: .hasWaveEffect)
        hasBubbleEffect = try container.decode(Bool.self, forKey: .hasBubbleEffect)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(previewImageName, forKey: .previewImageName)
        try container.encode(price, forKey: .price)
        try container.encode(isPurchased, forKey: .isPurchased)
        try container.encode(themeType, forKey: .themeType)
        
        // 編碼顏色為十六進制字符串
        try container.encode(primaryColor.toHex(), forKey: .primaryColor)
        try container.encode(secondaryColor.toHex(), forKey: .secondaryColor)
        try container.encode(deepBlue.toHex(), forKey: .deepBlue)
        try container.encode(mediumBlue.toHex(), forKey: .mediumBlue)
        try container.encode(lightBlue.toHex(), forKey: .lightBlue)
        try container.encode(coral.toHex(), forKey: .coral)
        try container.encode(accent.toHex(), forKey: .accent)
        try container.encode(textPrimary.toHex(), forKey: .textPrimary)
        try container.encode(textSecondary.toHex(), forKey: .textSecondary)
        
        try container.encode(opacity, forKey: .opacity)
        try container.encode(waveOpacity, forKey: .waveOpacity)
        try container.encode(hasWaveEffect, forKey: .hasWaveEffect)
        try container.encode(hasBubbleEffect, forKey: .hasBubbleEffect)
    }
}

// Color 擴展，用於十六進制轉換
extension Color {
    func toHex() -> String {
        // 實現顏色到十六進制字符串的轉換
        // 這裡需要實現具體的轉換邏輯
        return ""  // 臨時返回空字符串
    }
} 