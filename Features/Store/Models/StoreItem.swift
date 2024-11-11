import Foundation

struct StoreItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Int
    let category: StoreCategory
    let imageUrl: String?
    let isLimitedTime: Bool
    let endDate: Date?
    let discountPercentage: Int?
    
    var discountedPrice: Int? {
        guard let discount = discountPercentage else { return nil }
        return price - (price * discount / 100)
    }
}

enum StoreCategory: String, Codable, CaseIterable {
    case theme
    case breathingPattern
    case achievement
    case special
    
    var displayName: String {
        switch self {
        case .theme:
            return "主題"
        case .breathingPattern:
            return "呼吸模式"
        case .achievement:
            return "成就徽章"
        case .special:
            return "限定商品"
        }
    }
} 