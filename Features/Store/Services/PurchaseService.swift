import Foundation
import Combine
import CoreData

class PurchaseService {
    static let shared = PurchaseService()
    private let context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    func purchase(_ item: StoreItem) -> AnyPublisher<PurchaseRecord, Error> {
        return Future { promise in
            let record = PurchaseRecord(
                id: UUID(),
                itemId: item.id,
                itemName: item.name,
                price: item.price,
                purchaseDate: Date(),
                category: item.category
            )
            
            promise(.success(record))
        }
        .eraseToAnyPublisher()
    }
    
    func getPurchaseHistory() -> AnyPublisher<[PurchaseRecord], Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(PurchaseError.serviceError))
                return
            }
            
            let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.purchaseDate, ascending: false)]
            
            do {
                let purchases = try self.context.fetch(request)
                let records = purchases.map { purchase in
                    PurchaseRecord(
                        id: purchase.id ?? UUID(),
                        itemId: UUID(), // 這裡需要根據實際情況調整
                        itemName: purchase.itemName ?? "Unknown",
                        price: Int(purchase.price),
                        purchaseDate: purchase.purchaseDate ?? Date(),
                        category: .theme // 這裡需要根據實際情況調整
                    )
                }
                promise(.success(records))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    enum PurchaseError: Error {
        case serviceError
        case purchaseFailed
    }
} 