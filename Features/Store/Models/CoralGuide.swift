import Foundation

struct CoralGuide: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    let reward: Int
    let taskType: TaskType
    let requirements: [String]
    let isCompleted: Bool
    
    enum TaskType: String, Codable {
        case daily
        case weekly
        case achievement
        case special
    }
} 