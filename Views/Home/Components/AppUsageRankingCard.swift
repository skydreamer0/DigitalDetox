import SwiftUI

struct AppUsageRankingCard: View {
    @EnvironmentObject private var themeService: ThemeService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("應用使用排名")
                .font(.headline)
                .foregroundColor(themeService.currentTheme.textPrimary)
            
            // 排名列表
        }
        .padding()
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(12)
    }
} 