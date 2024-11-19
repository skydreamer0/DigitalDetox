import SwiftUI

struct LimitedTimeOffers: View {
    @EnvironmentObject private var themeService: ThemeService
    let offers: [StoreItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("限時特惠")
                .font(.headline)
                .foregroundColor(themeService.currentTheme.textPrimary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(offers) { offer in
                        LimitedTimeItemCard(item: offer)
                            .environmentObject(themeService)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(themeService.currentTheme.primaryColor.opacity(0.1))
        .cornerRadius(12)
    }
} 