// BreathingModels.swift
//檔案位置: Features/Breathing/Models/BreathingModels.swift
//功能：定義呼吸模式和呼吸會話的結構
import Foundation

// Breathing phase enumeration
enum BreathingPhase: String {
    case inhale = "Inhale"
    case hold = "Hold"
    case exhale = "Exhale"
    case rest = "Rest"
}

// Breathing pattern structure
struct BreathingPattern: Equatable {
    let name: String
    let description: String
    let inhaleTime: TimeInterval
    let holdTime: TimeInterval
    let exhaleTime: TimeInterval
    let cycles: Int
    
    static func == (lhs: BreathingPattern, rhs: BreathingPattern) -> Bool {
        return lhs.name == rhs.name &&
               lhs.description == rhs.description &&
               lhs.inhaleTime == rhs.inhaleTime &&
               lhs.holdTime == rhs.holdTime &&
               lhs.exhaleTime == rhs.exhaleTime &&
               lhs.cycles == rhs.cycles
    }
    
    static let defaultPattern = BreathingPattern(
        name: "4-7-8 Relaxation Breath",
        description: "A breathing pattern that helps with relaxation and sleep",
        inhaleTime: 4,
        holdTime: 7,
        exhaleTime: 8,
        cycles: 4
    )
    
    static let focusPattern = BreathingPattern(
        name: "4-4-4 Focus Breath",
        description: "A breathing pattern to enhance concentration",
        inhaleTime: 4,
        holdTime: 4,
        exhaleTime: 4,
        cycles: 6
    )
    
    static let sleepPattern = BreathingPattern(
        name: "5-8-9 Sleep Breath",
        description: "Deep relaxation breathing pattern for better sleep",
        inhaleTime: 5,
        holdTime: 8,
        exhaleTime: 9,
        cycles: 3
    )
    
    static var allPatterns: [BreathingPattern] {
        return [
            .defaultPattern,
            .focusPattern,
            .sleepPattern
        ]
    }
}

// Breathing session structure
struct BreathingSession {
    let pattern: BreathingPattern
    let startTime: Date
    var currentPhase: BreathingPhase
    var currentCycle: Int
    var isCompleted: Bool
    
    init(pattern: BreathingPattern = .defaultPattern) {
        self.pattern = pattern
        self.startTime = Date()
        self.currentPhase = .inhale
        self.currentCycle = 1
        self.isCompleted = false
    }
} 