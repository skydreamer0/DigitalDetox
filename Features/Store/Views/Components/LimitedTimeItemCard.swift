import SwiftUI

struct LimitedTimeItemCard: View {
    let item: StoreItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 商品圖片
            if let imageUrl = item.imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.oceanTheme.deepBlue
                }
                .frame(width: 120, height: 120)
                .cornerRadius(12)
            } else {
                Image(systemName: "gift.fill")
                    .font(.system(size: 40))
                    .foregroundColor(Color.oceanTheme.coral)
                    .frame(width: 120, height: 120)
                    .background(Color.oceanTheme.deepBlue.opacity(0.3))
                    .cornerRadius(12)
            }
            
            // 商品信息
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                
                if let endDate = item.endDate {
                    Text("Ends in \(timeRemaining(until: endDate))")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.coral)
                }
                
                HStack {
                    if let discountedPrice = item.discountedPrice {
                        Text("\(discountedPrice)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.oceanTheme.coral)
                        
                        Text("\(item.price)")
                            .font(.caption)
                            .strikethrough()
                            .foregroundColor(Color.oceanTheme.textSecondary)
                    } else {
                        Text("\(item.price)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.oceanTheme.coral)
                    }
                }
            }
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(16)
    }
    
    private func timeRemaining(until date: Date) -> String {
        let components = Calendar.current.dateComponents([.day, .hour], from: Date(), to: date)
        if let days = components.day, days > 0 {
            return "\(days)d"
        } else if let hours = components.hour {
            return "\(hours)h"
        }
        return "Soon"
    }
} 