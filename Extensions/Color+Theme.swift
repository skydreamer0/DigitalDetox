import SwiftUI

extension Color {
    static let oceanTheme = OceanTheme()
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct OceanTheme {
    // 主要顏色
    let deepBlue = Color(hex: "1B4965")      // 深邃海藍
    let mediumBlue = Color(hex: "62B6CB")    // 清澈海水藍
    let lightBlue = Color(hex: "BEE9E8")     // 淺層海藍
    let accent = Color(hex: "CAE9FF")        // 波光色
    let coral = Color(hex: "FF9B71")         // 珊瑚色(強調色)
    
    // 輔助顏色
    let textPrimary = Color.white            // 主要文字
    let textSecondary = Color(hex: "BEE9E8") // 次要文字
    let divider = Color(hex: "62B6CB")       // 分隔線
    
    // 背景漸層
    var backgroundGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [deepBlue, mediumBlue.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // 卡片背景
    var cardBackground: Color {
        deepBlue.opacity(0.3)
    }
    
    // 標籤列背景
    var tabBarBackground: Color {
        deepBlue.opacity(0.95)
    }
    
    // 列表背景
    var listBackground: Color {
        deepBlue.opacity(0.2)
    }
} 