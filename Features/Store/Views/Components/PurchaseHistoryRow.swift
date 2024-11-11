import SwiftUI

struct PurchaseHistoryRow: View {
    let purchase: Purchase
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(purchase.itemName ?? "未知商品")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                
                if let date = purchase.purchaseDate {
                    Text(date.formatted())
                        .font(.subheadline)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
            }
            
            Spacer()
            
            Text("\(purchase.price) 珊瑚幣")
                .font(.headline)
                .foregroundColor(Color.oceanTheme.coral)
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
    }
} 