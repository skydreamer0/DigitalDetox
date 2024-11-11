import SwiftUI

struct StoreItemCard: View {
    let item: StoreItem
    @EnvironmentObject private var viewModel: StoreViewModel
    
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
                
                Text(item.description)
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
                    .lineLimit(2)
                
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
            
            Button(action: {
                viewModel.purchaseItem(item)
            }) {
                Text("購買")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.oceanTheme.coral)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(16)
    }
} 