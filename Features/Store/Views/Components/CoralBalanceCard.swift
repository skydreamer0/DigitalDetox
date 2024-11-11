import SwiftUI

struct CoralBalanceCard: View {
    let balance: Int
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill")
                .font(.title)
                .foregroundColor(Color.oceanTheme.coral)
            
            VStack(alignment: .leading) {
                Text("Coral Balance")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                
                Text("\(balance) coins")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.oceanTheme.coral)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
    }
} 