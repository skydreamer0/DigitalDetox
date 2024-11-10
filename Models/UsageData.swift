import Foundation

/// 使用時間數據模型
struct UsageData: Codable, Identifiable {
    let id: UUID
    let date: Date
    let appId: String
    let duration: TimeInterval
    let category: AppCategory
    
    init(appId: String, duration: TimeInterval, category: AppCategory) {
        self.id = UUID()
        self.date = Date()
        self.appId = appId
        self.duration = duration
        self.category = category
    }
}

/// 應用類別枚舉
enum AppCategory: String, Codable {
    case social
    case entertainment
    case productivity
    case other
} 