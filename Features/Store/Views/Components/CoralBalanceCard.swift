import SwiftUI

struct CoralBalanceCard: View {
    @EnvironmentObject private var themeService: ThemeService
    let balance: Int
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.title)
                .foregroundColor(themeService.currentTheme.coral)
            
            VStack(alignment: .leading) {
                Text("珊瑚幣餘額")
                    .font(.caption)
                    .foregroundColor(themeService.currentTheme.textSecondary)
                
                Text("\(balance)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(themeService.currentTheme.textPrimary)
            }
            
            Spacer()
            
            Button(action: {
                // TODO: 實現充值功能
            }) {
                Text("充值")
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(themeService.currentTheme.coral)
                    .foregroundColor(themeService.currentTheme.textPrimary)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    CoralBalanceCard(balance: 1000)
        .environmentObject(ThemeService.shared)
        .padding()
} 