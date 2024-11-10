import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("通知權限已獲得")
            } else if let error = error {
                print("通知權限請求失敗: \(error)")
            }
        }
    }
    
    func scheduleUsageReminder(timeLimit: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "使用時間提醒"
        content.body = "您已經使用設備超過設定時間了，建議休息一下！"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeLimit, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
} 