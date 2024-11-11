import SwiftUI

struct UsageTrendCard: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Usage Trend")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                Spacer()
            }
            
            // 這裡可以添加趨勢圖表
            Rectangle()
                .fill(Color.clear)
                .frame(height: 200)
                .overlay(
                    Text("Trend Chart Placeholder")
                        .foregroundColor(Color.oceanTheme.textSecondary)
                )
        }
        .padding()
        .cardStyle()
    }
} 