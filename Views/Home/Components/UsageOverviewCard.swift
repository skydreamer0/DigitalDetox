import SwiftUI

// 從原 HomeView 中抽離的卡片元件
struct UsageOverviewCard: View {
    var body: some View {
        VStack(spacing: 15) {
            CardHeader()
            UsageStatistics()
            UsageProgressBar()
        }
        .padding()
        .cardStyle()
    }
}

private extension UsageOverviewCard {
    struct CardHeader: View {
        var body: some View {
            HStack {
                Image(systemName: "wave.3.right")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Usage Overview")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
        }
    }
    
    struct UsageStatistics: View {
        var body: some View {
            HStack(spacing: 30) {
                VStack {
                    Text("6h 30m")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    Text("Total Usage")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
                
                VStack {
                    Text("↑12%")
                        .font(.title2)
                        .foregroundColor(Color.oceanTheme.coral)
                    Text("vs Last Period")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
            }
        }
    }
    
    struct UsageProgressBar: View {
        var body: some View {
            ProgressView(value: 0.75)
                .padding(.horizontal)
                .tint(Color.oceanTheme.coral)
        }
    }
} 