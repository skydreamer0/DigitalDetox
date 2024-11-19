import SwiftUI

struct CommunityView: View {
    @EnvironmentObject private var themeService: ThemeService
    
    var body: some View {
        VStack {
            Text("社群")
                .font(.largeTitle)
                .foregroundColor(themeService.currentTheme.textPrimary)
            
            // 其他社群內容
        }
        .padding()
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(12)
    }
} 