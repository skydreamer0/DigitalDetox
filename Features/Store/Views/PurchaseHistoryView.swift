import SwiftUI

struct PurchaseHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = PurchaseHistoryViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.purchases) { purchase in
                PurchaseHistoryRow(purchase: purchase)
            }
            .navigationBarSetup(title: "Purchase History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
} 