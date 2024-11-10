import Foundation

// 呼吸階段枚舉
enum BreathingPhase: String {
    case inhale = "Inhale"
    case hold = "Hold"
    case exhale = "Exhale"
    case rest = "Rest"
}

// 呼吸模式結構
struct BreathingPattern {
    let name: String
    let description: String
    let inhaleTime: TimeInterval
    let holdTime: TimeInterval
    let exhaleTime: TimeInterval
    let cycles: Int
    
    // 預設的 4-7-8 模式
    static let defaultPattern = BreathingPattern(
        name: "4-7-8 Relaxing Breath",
        description: "Helps with relaxation and sleep",
        inhaleTime: 4,
        holdTime: 7,
        exhaleTime: 8,
        cycles: 4
    )
    
    // 添加預設模式
    static let focusPattern = BreathingPattern(
        name: "4-4-4 Focus Breath",
        description: "Enhances concentration and focus",
        inhaleTime: 4,
        holdTime: 4,
        exhaleTime: 4,
        cycles: 4
    )
    
    static let sleepPattern = BreathingPattern(
        name: "5-8-9 Sleep Breath",
        description: "Promotes better sleep",
        inhaleTime: 5,
        holdTime: 8,
        exhaleTime: 9,
        cycles: 3
    )
    
    // 自定義模式建構器
    static func custom(
        name: String,
        description: String,
        inhaleTime: TimeInterval,
        holdTime: TimeInterval,
        exhaleTime: TimeInterval,
        cycles: Int
    ) -> BreathingPattern {
        BreathingPattern(
            name: name,
            description: description,
            inhaleTime: inhaleTime,
            holdTime: holdTime,
            exhaleTime: exhaleTime,
            cycles: cycles
        )
    }
}

// 呼吸會話結構
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