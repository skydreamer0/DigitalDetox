import SwiftUI

public protocol ThemeConfigurable: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
    var previewImageName: String { get }
    var price: Int? { get }
    var isPurchased: Bool { get }
    
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var deepBlue: Color { get }
    var mediumBlue: Color { get }
    var lightBlue: Color { get }
    var coral: Color { get }
    var accent: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    
    var opacity: Double { get }
    var waveOpacity: Double { get }
    var hasWaveEffect: Bool { get }
    var hasBubbleEffect: Bool { get }
    
    var themeType: ThemeType { get }
}

// 提供默認值
public extension ThemeConfigurable {
    var hasWaveEffect: Bool { false }
    var hasBubbleEffect: Bool { false }
    var waveOpacity: Double { 0.3 }
    var textSecondary: Color { textPrimary.opacity(0.7) }
}

public enum ThemeType: String, Codable {
    case ocean
    case forest
    case mountain
    case space
    case desert
} 