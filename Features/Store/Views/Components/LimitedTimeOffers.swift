import SwiftUI

struct LimitedTimeOffers: View {
    let offers: [StoreItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "timer")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Limited Time Offers")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(offers) { offer in
                        LimitedTimeItemCard(item: offer)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
} 