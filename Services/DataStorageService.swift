import Foundation
import CoreData

/// 負責本地數據存儲的服務
class DataStorageService {
    static let shared = DataStorageService()
    
    private let context: NSManagedObjectContext
    
    private init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    /// 保存或更新使用記錄
    func saveUsageData(_ data: UsageData, for userId: UUID) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId as CVarArg)
        
        do {
            let user = try context.fetch(fetchRequest).first
            
            let record = UsageRecord(context: context)
            record.id = UUID()
            record.date = data.date
            record.appId = data.appId
            record.appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Unknown"
            record.duration = data.duration
            record.category = data.category.rawValue
            record.lastUpdated = Date()
            record.user = user
            
            try context.save()
        } catch {
            print("保存使用記錄失敗: \(error)")
        }
    }
    
    /// 獲取今日使用記錄
    func fetchTodayUsage(for user: User) -> [UsageData] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let fetchRequest: NSFetchRequest<UsageRecord> = UsageRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "date >= %@ AND date < %@ AND user == %@",
            startOfDay as NSDate,
            endOfDay as NSDate,
            user
        )
        
        do {
            let records = try context.fetch(fetchRequest)
            return records.map { record in
                UsageData(
                    appId: record.appId ?? "",
                    duration: record.duration,
                    category: AppCategory(rawValue: record.category ?? "") ?? .other
                )
            }
        } catch {
            print("讀取使用記錄失敗: \(error)")
            return []
        }
    }
} 