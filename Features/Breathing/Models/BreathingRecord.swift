// BreathingRecord.swift
//檔案位置: Features/Breathing/Models/BreathingRecord.swift
//功能：定義呼吸記錄的結構
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