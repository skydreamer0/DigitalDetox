import SwiftUI

struct LimitedTimeItemCard: View {
    @EnvironmentObject private var themeService: ThemeService
    let item: StoreItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .cornerRadius(8)
            
            Text(item.name)
                .font(.headline)
                .foregroundColor(themeService.currentTheme.textPrimary)
            
            Text(item.description)
                .font(.caption)
                .foregroundColor(themeService.currentTheme.textSecondary)
            
            HStack {
                Text("\(item.price) 珊瑚幣")
                    .font(.caption)
                    .foregroundColor(themeService.currentTheme.coral)
                
                Spacer()
                
                Button(action: {
                    // 購買操作
                }) {
                    Text("購買")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(themeService.currentTheme.coral)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(12)
    }
} 