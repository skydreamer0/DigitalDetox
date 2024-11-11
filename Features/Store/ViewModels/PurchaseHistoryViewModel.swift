import Foundation
import CoreData

class PurchaseHistoryViewModel: ObservableObject {
    @Published var purchases: [Purchase] = []
    private let context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
        fetchPurchases()
    }
    
    private func fetchPurchases() {
        let request: NSFetchRequest<Purchase> = Purchase.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Purchase.purchaseDate, ascending: false)]
        
        do {
            purchases = try context.fetch(request)
        } catch {
            print("讀取購買記錄失敗: \(error)")
        }
    }
} 