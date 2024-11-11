import Foundation
import Combine

class CacheService {
    static let shared = CacheService()
    private let defaults = UserDefaults.standard
    private let storeItemsKey = "cached_store_items"
    
    func saveStoreItems(_ items: [StoreItem]) {
        if let encoded = try? JSONEncoder().encode(items) {
            defaults.set(encoded, forKey: storeItemsKey)
        }
    }
    
    func getStoreItems() -> AnyPublisher<[StoreItem], Error> {
        return Future { promise in
            if let data = self.defaults.data(forKey: self.storeItemsKey),
               let items = try? JSONDecoder().decode([StoreItem].self, from: data) {
                promise(.success(items))
            } else {
                promise(.success([]))
            }
        }
        .eraseToAnyPublisher()
    }
} 