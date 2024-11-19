import SwiftUI

struct CoralGuideCard: View {
    @EnvironmentObject private var themeService: ThemeService
    let guide: CoralGuide
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(guide.title)
                .font(.headline)
                .foregroundColor(themeService.currentTheme.textPrimary)
            
            Text(guide.description)
                .font(.caption)
                .foregroundColor(themeService.currentTheme.textSecondary)
            
            ForEach(guide.requirements, id: \.self) { requirement in
                HStack {
                    Image(systemName: guide.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(guide.isCompleted ? themeService.currentTheme.coral : themeService.currentTheme.textSecondary)
                    Text(requirement)
                        .font(.caption)
                        .foregroundColor(themeService.currentTheme.textSecondary)
                }
            }
            
            Button(action: {
                // 執行任務的操作
            }) {
                Text(guide.isCompleted ? "Completed" : "Start Task")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(guide.isCompleted ? themeService.currentTheme.textSecondary : themeService.currentTheme.deepBlue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(guide.isCompleted ? Color.clear : themeService.currentTheme.coral)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(12)
    }
} 