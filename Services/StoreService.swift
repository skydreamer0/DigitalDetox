import Foundation
import CoreData

class StoreService {
    static let shared = StoreService()
    
    private var coralCoins: Int = 0
    
    func purchaseItem(id: String, cost: Int) -> Bool {
        guard coralCoins >= cost else { return false }
        coralCoins -= cost
        // 保存購買記錄到 Core Data
        savePurchaseRecord(itemId: id, itemName: "Item \(id)", price: cost)
        return true
    }
    
    private func savePurchaseRecord(itemId: String, itemName: String, price: Int) {
        let context = DigitalDetoxModel.shared.persistentContainer.viewContext
        let record = Purchase(context: context)
        record.id = UUID()
        record.itemName = itemName
        record.price = Int32(price)
        record.purchaseDate = Date()
        
        do {
            try context.save()
        } catch {
            print("保存購買記錄失敗: \(error)")
        }
    }
} 