import SwiftUI

struct AppUsageRankingCard: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "list.number")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("App Usage Ranking")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                Spacer()
            }
            
            ForEach(0..<3) { index in
                AppRankingRow(rank: index + 1)
            }
        }
        .padding()
        .cardStyle()
    }
}

private struct AppRankingRow: View {
    let rank: Int
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .font(.headline)
                .foregroundColor(Color.oceanTheme.coral)
                .frame(width: 30)
            
            Image(systemName: "app")
                .foregroundColor(Color.oceanTheme.mediumBlue)
            
            Text("App Name")
                .foregroundColor(Color.oceanTheme.textPrimary)
            
            Spacer()
            
            Text("2h 30m")
                .foregroundColor(Color.oceanTheme.textSecondary)
        }
    }
} 