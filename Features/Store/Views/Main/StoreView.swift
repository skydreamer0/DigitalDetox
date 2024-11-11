import SwiftUI

public struct StoreView: View {
    @StateObject private var viewModel = StoreViewModel()
    @State private var showingPurchaseHistory = false
    @State private var showingCoralGuide = false
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    CoralBalanceCard(balance: viewModel.coralBalance)
                    
                    if !viewModel.limitedTimeOffers.isEmpty {
                        LimitedTimeOffers(offers: viewModel.limitedTimeOffers)
                    }
                    
                    ForEach(StoreCategory.allCases, id: \.self) { category in
                        StoreSection(
                            title: category.displayName,
                            items: viewModel.items.filter { $0.category == category }
                        )
                    }
                }
                .padding(.top)
            }
            .oceanBackground()
            .navigationBarSetup(title: "Ocean Store")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: { showingCoralGuide = true }) {
                            Image(systemName: "plus.circle")
                        }
                        
                        Button(action: { showingPurchaseHistory = true }) {
                            Image(systemName: "clock")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingPurchaseHistory) {
            PurchaseHistoryView()
        }
        .sheet(isPresented: $showingCoralGuide) {
            CoralGuideView()
        }
        .onAppear {
            viewModel.loadStoreItems()
        }
    }
} 