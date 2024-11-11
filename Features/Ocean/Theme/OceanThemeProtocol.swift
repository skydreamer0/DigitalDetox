import SwiftUI

public protocol OceanThemeConfigurable {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var deepBlue: Color { get }
    var mediumBlue: Color { get }
    var lightBlue: Color { get }
    var coral: Color { get }
    var accent: Color { get }
    var textPrimary: Color { get }
    var opacity: Double { get }
    var waveOpacity: Double { get }
    var themeName: String { get }
}

public protocol ThemeIdentifiable {
    var themeName: String { get }
} 