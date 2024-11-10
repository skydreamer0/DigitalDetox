import Foundation
import Combine

class UsageTrackingService: ObservableObject {
    static let shared = UsageTrackingService()
    
    @Published var dailyUsage: [String: TimeInterval] = [:]
    private var timer: Timer?
    private var currentAppStartTime: Date?
    
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
        
        DispatchQueue.main.async {
            self.dailyUsage[bundleId] = duration
            self.checkAndNotifyIfNeeded()
            
            // 保存使用記錄
            DigitalDetoxModel.shared.saveUsageTime(
                appName: Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "Unknown",
                duration: duration
            )
        }
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