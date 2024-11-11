import Foundation
import Combine

class StoreViewModel: ObservableObject {
    @Published var items: [StoreItem] = []
    @Published var limitedTimeOffers: [StoreItem] = []
    @Published var coralBalance: Int = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let storeService: StoreService
    private let purchaseService: PurchaseService
    private var cancellables = Set<AnyCancellable>()
    
    init(storeService: StoreService = .shared,
         purchaseService: PurchaseService = .shared) {
        self.storeService = storeService
        self.purchaseService = purchaseService
        setupBindings()
    }
    
    func loadStoreItems() {
        isLoading = true
        storeService.fetchStoreItems()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] items in
                self?.items = items
                self?.limitedTimeOffers = items.filter { $0.isLimitedTime }
            })
            .store(in: &cancellables)
    }
    
    func purchaseItem(_ item: StoreItem) {
        guard let currentUser = PersistenceController.shared.currentUser else {
            errorMessage = "用戶未登入"
            return
        }
        
        storeService.purchaseItem(
            id: item.id,
            name: item.name,
            cost: item.price,
            user: currentUser
        )
        .sink(
            receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            },
            receiveValue: { [weak self] _ in
                self?.loadStoreItems()
            }
        )
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
        // 設置數據綁定
    }
} 