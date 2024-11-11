import Foundation
import Combine

class CoralGuideViewModel: ObservableObject {
    @Published var guides: [CoralGuide] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadGuides()
    }
    
    private func loadGuides() {
        isLoading = true
        
        // 模擬加載指南數據
        let mockGuides = [
            CoralGuide(
                id: UUID(),
                title: "每日登入",
                description: "連續登入獲得獎勵",
                reward: 10,
                taskType: .daily,
                requirements: ["登入應用"],
                isCompleted: false
            ),
            CoralGuide(
                id: UUID(),
                title: "完成呼吸練習",
                description: "完成一次完整的呼吸練習",
                reward: 20,
                taskType: .daily,
                requirements: ["完成一次呼吸練習"],
                isCompleted: false
            ),
            CoralGuide(
                id: UUID(),
                title: "達成每週目標",
                description: "完成本週設定的使用時間目標",
                reward: 50,
                taskType: .weekly,
                requirements: ["達成週目標"],
                isCompleted: false
            )
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.guides = mockGuides
            self.isLoading = false
        }
    }
} 