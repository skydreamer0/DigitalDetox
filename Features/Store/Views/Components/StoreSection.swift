import SwiftUI

struct StoreSection: View {
    let title: String
    let items: [StoreItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.oceanTheme.coral)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        StoreItemCard(item: item)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
} 