import CoreData

class DigitalDetoxModel {
    static let shared = DigitalDetoxModel()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DigitalDetox")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("無法載入 Core Data: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - 使用時間追蹤
    func saveUsageTime(appName: String, duration: TimeInterval) {
        let context = persistentContainer.viewContext
        let usage = UsageRecord(context: context)
        usage.id = UUID()
        usage.appName = appName
        usage.appId = Bundle.main.bundleIdentifier ?? ""
        usage.date = Date()
        usage.duration = duration
        usage.lastUpdated = Date()
        usage.category = AppCategory.other.rawValue
        
        do {
            try context.save()
        } catch {
            print("保存使用記錄失敗: \(error)")
        }
    }
    
    // MARK: - 呼吸記錄
    func saveBreathingSession(_ session: BreathingSession) {
        let context = persistentContainer.viewContext
        let record = BreathingRecord(context: context)
        
        record.id = UUID()
        record.startTime = session.startTime
        record.endTime = Date()
        record.patternName = session.pattern.name
        record.completedCycles = Int16(session.currentCycle)
        record.totalDuration = record.endTime?.timeIntervalSince(session.startTime) ?? 0
        
        do {
            try context.save()
        } catch {
            print("保存呼吸記錄失敗: \(error)")
        }
    }
    
    func getBreathingHistory() -> [BreathingRecord] {
        let context = persistentContainer.viewContext
        let request = BreathingRecord.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BreathingRecord.startTime, ascending: false)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("獲取呼吸記錄失敗: \(error)")
            return []
        }
    }
} 