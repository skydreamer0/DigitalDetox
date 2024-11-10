import Foundation
import CoreData

extension BreathingRecord {
    var durationInMinutes: Double {
        return totalDuration / 60.0
    }
    
    var formattedDuration: String {
        let minutes = Int(durationInMinutes)
        return "\(minutes) 分鐘"
    }
} 