import Foundation

struct PurchaseRecord: Identifiable, Codable {
    let id: UUID
    let itemId: UUID
    let itemName: String
    let price: Int
    let purchaseDate: Date
    let category: StoreCategory
} 