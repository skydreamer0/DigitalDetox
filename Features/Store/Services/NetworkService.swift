import Foundation
import Combine

class NetworkService {
    static let shared = NetworkService()
    
    func fetchStoreItems() -> AnyPublisher<[StoreItem], Error> {
        // 模擬網絡請求
        return Future { promise in
            // TODO: 實現實際的網絡請求
            let mockItems = [
                StoreItem(id: UUID(), 
                         name: "Ocean Theme", 
                         description: "Calming ocean theme",
                         price: 100,
                         category: .theme,
                         imageUrl: nil,
                         isLimitedTime: false,
                         endDate: nil,
                         discountPercentage: nil)
            ]
            promise(.success(mockItems))
        }
        .delay(for: .seconds(1), scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func refreshStoreData() -> AnyPublisher<[StoreItem], Error> {
        return fetchStoreItems()
    }
} 