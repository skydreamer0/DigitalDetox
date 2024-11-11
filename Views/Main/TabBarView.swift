import SwiftUI
import UIKit
import Foundation

// 將原本 ContentView 中的 TabView 相關邏輯移至此
struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var showBreatheGuide = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            BreatheGuideView()
                .tabItem {
                    Label("Breathe", systemImage: "wind")
                }
                .tag(1)
            
            StoreView()
                .tabItem {
                    Label("Store", systemImage: "bag.fill")
                }
                .tag(2)
            
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
        }
        .tint(Color.oceanTheme.accent)
        .onAppear {
            configureTabBarAppearance()
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            handleTabChange(newValue)
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.oceanTheme.tabBarBackground)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.oceanTheme.textSecondary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.oceanTheme.textSecondary)
        ]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.oceanTheme.accent)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.oceanTheme.accent)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func handleTabChange(_ tab: Int) {
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        
        switch tab {
        case 0:
            // 處理首頁切換
            NotificationCenter.default.post(
                name: .didSwitchToHomeTab,
                object: nil
            )
            
        case 1:
            // 修改深呼吸頁面切換的處理
            NotificationCenter.default.post(
                name: .didSwitchToBreatheTab,
                object: nil
            )
            // 如果正在進行呼吸練習，暫停背景音樂
            BreatheAudioService.shared.pauseBackgroundMusicIfNeeded()
            
        case 2:
            // 處理商店頁面切換
            NotificationCenter.default.post(
                name: .didSwitchToStoreTab,
                object: nil
            )
            // 刷新商店數據
            StoreService.shared.refreshStoreData()
            
        case 3:
            // 處理社群頁面切換
            NotificationCenter.default.post(
                name: .didSwitchToCommunityTab,
                object: nil
            )
            // 刷新社群數據
            CommunityService.shared.refreshFeed()
            
        case 4:
            // 處理設置頁面切換
            NotificationCenter.default.post(
                name: .didSwitchToSettingsTab,
                object: nil
            )
            // 檢查並更新設置
            SettingsService.shared.checkForUpdates()
            
        default:
            break
        }
        
        // 記錄分析數據
        AnalyticsService.shared.logTabSwitch(to: tab)
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let didSwitchToHomeTab = Notification.Name("didSwitchToHomeTab")
    static let didSwitchToBreatheTab = Notification.Name("didSwitchToBreatheTab")
    static let didSwitchToStoreTab = Notification.Name("didSwitchToStoreTab")
    static let didSwitchToCommunityTab = Notification.Name("didSwitchToCommunityTab")
    static let didSwitchToSettingsTab = Notification.Name("didSwitchToSettingsTab")
}

// MARK: - Preview
#Preview {
    TabBarView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
} 