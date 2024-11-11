import Foundation
import Combine

class UsageTrackingService: ObservableObject {
    static let shared = UsageTrackingService()
    
    @Published var dailyUsage: [String: TimeInterval] = [:]
    private var timer: Timer?
    private var currentAppStartTime: Date?
    private let dataStorageService = DataStorageService.shared
    
    private init() {
        setupTracking()
    }
    
    private func setupTracking() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateUsageTime()
        }
    }
    
    private func updateUsageTime() {
        guard let startTime = currentAppStartTime else {
            currentAppStartTime = Date()
            return
        }
        
        let duration = Date().timeIntervalSince(startTime)
        let bundleId = Bundle.main.bundleIdentifier ?? "unknown"
        
        DispatchQueue.main.async(execute: DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            self.dailyUsage[bundleId] = duration
            self.checkAndNotifyIfNeeded()
            
            // 保存使用記錄
            if let currentUser = PersistenceController.shared.currentUser,
               let userId = currentUser.id {  // 安全解包 UUID
                let usageData = UsageData(
                    appId: bundleId,
                    duration: duration,
                    category: .productivity // 這裡可以根據實際需求設置類別
                )
                self.dataStorageService.saveUsageData(usageData, for: userId)
            }
        }))
    }
    
    func startTracking() {
        currentAppStartTime = Date()
    }
    
    func stopTracking() {
        currentAppStartTime = nil
    }
    
    func getAppUsage(for bundleId: String) -> TimeInterval {
        return dailyUsage[bundleId] ?? 0
    }
    
    func isOverLimit(for bundleId: String, limit: TimeInterval) -> Bool {
        let usage = getAppUsage(for: bundleId)
        return usage >= limit
    }
}

// MARK: - 通知處理
extension UsageTrackingService {
    func checkAndNotifyIfNeeded() {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let usage = getAppUsage(for: bundleId)
        
        if usage.truncatingRemainder(dividingBy: 1800) < 1 {
            NotificationCenter.default.post(
                name: .usageLimitWarning,
                object: nil,
                userInfo: ["usage": usage]
            )
        }
    }
}

extension Notification.Name {
    static let usageLimitWarning = Notification.Name("usageLimitWarning")
} 