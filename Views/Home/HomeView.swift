import SwiftUI

// 簡化後的 HomeView
struct HomeView: View {
    @State private var selectedTimeRange = 0
    private let timeRanges = ["Today", "Week", "Month"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    TimeRangePicker(selection: $selectedTimeRange, ranges: timeRanges)
                    
                    UsageOverviewCard()
                    UsageTrendCard()
                    AppUsageRankingCard()
                }
                .padding(.top)
            }
            .oceanBackground()
            .navigationBarSetup(title: "Ocean Calm")
        }
    }
} 