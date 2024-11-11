import Foundation
import Combine
import CoreData

class StoreService {
    static let shared = StoreService()
    
    private let networkService: NetworkService
    private let cacheService: CacheService
    private let context: NSManagedObjectContext
    private var coralCoins: Int = 0
    
    init(networkService: NetworkService = .shared,
         cacheService: CacheService = .shared) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.context = PersistenceController.shared.container.viewContext
    }
    
    // MARK: - Store Items
    func fetchStoreItems() -> AnyPublisher<[StoreItem], Error> {
        return networkService.fetchStoreItems()
            .catch { error -> AnyPublisher<[StoreItem], Error> in
                return self.cacheService.getStoreItems()
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Purchase Management
    func purchaseItem(id: UUID, name: String, cost: Int, user: User) -> AnyPublisher<Bool, Error> {
        guard user.coralBalance >= Int32(cost) else {
            return Fail(error: StoreError.insufficientFunds).eraseToAnyPublisher()
        }
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            // 更新用戶的珊瑚幣餘額
            user.coralBalance -= Int32(cost)
            
            // 保存購買記錄
            self.savePurchaseRecord(
                itemName: name,
                cost: cost,
                user: user
            )
            
            do {
                try self.context.save()
                promise(.success(true))
            } catch {
                promise(.failure(StoreError.purchaseFailed))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func savePurchaseRecord(itemName: String, cost: Int, user: User) {
        let record = Purchase(context: context)
        record.id = UUID()
        record.itemName = itemName
        record.price = Int32(cost)
        record.purchaseDate = Date()
        record.user = user
    }
    
    // MARK: - Store Data Management
    func refreshStoreData() {
        networkService.refreshStoreData()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] items in
                    self?.cacheService.saveStoreItems(items)
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: - Error Handling
    enum StoreError: Error {
        case insufficientFunds
        case itemNotFound
        case purchaseFailed
        
        var localizedDescription: String {
            switch self {
            case .insufficientFunds:
                return "餘額不足"
            case .itemNotFound:
                return "商品不存在"
            case .purchaseFailed:
                return "購買失敗"
            }
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
} 
