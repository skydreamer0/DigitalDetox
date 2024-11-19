import SwiftUI

struct ThemePreviewCard: View {
    let theme: any ThemeConfigurable
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 預覽圖
            Image(theme.previewImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .cornerRadius(12)
            
            // 主題資訊
            VStack(alignment: .leading, spacing: 4) {
                Text(theme.name)
                    .font(.headline)
                Text(theme.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            // 顏色預覽
            HStack(spacing: 8) {
                ColorPreviewCircle(color: theme.primaryColor)
                ColorPreviewCircle(color: theme.secondaryColor)
                ColorPreviewCircle(color: theme.accent)
                ColorPreviewCircle(color: theme.coral)
            }
        }
        .padding()
        .background(theme.primaryColor.opacity(0.1))
        .cornerRadius(16)
    }
}

private struct ColorPreviewCircle: View {
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 24, height: 24)
            .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
} 