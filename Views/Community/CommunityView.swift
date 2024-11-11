import SwiftUI

struct CommunityView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 社群功能卡片
                    CommunityCard(
                        icon: "person.2.fill",
                        title: "Ocean Groups",
                        description: "Join mindfulness communities"
                    )
                    
                    CommunityCard(
                        icon: "chart.bar.fill",
                        title: "Challenges",
                        description: "Participate in group challenges"
                    )
                    
                    CommunityCard(
                        icon: "trophy.fill",
                        title: "Leaderboard",
                        description: "Compare your progress"
                    )
                }
                .padding(.top)
            }
            .oceanBackground()
            .navigationBarSetup(title: "Deep Dive Community")
        }
    }
}

private struct CommunityCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(Color.oceanTheme.coral)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                
                Spacer()
                
                Text("Coming Soon")
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.oceanTheme.deepBlue.opacity(0.3))
                    .cornerRadius(8)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(Color.oceanTheme.textSecondary)
        }
        .padding()
        .cardStyle()
    }
} 