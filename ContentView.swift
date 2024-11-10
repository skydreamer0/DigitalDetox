//
//  ContentView.swift
//  DigitalDetox
//
//  Created by George on 2024/11/8.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            BreatheView()
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
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(Color.oceanTheme.tabBarBackground)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            handleTabChange(newValue)
        }
    }
    
    private func handleTabChange(_ tab: Int) {
        switch tab {
        case 0:
            // 處理首頁切換
            break
        case 1:
            // 處理深呼吸頁面切換
            break
        case 2:
            // 處理商店頁面切換
            break
        case 3:
            // 處理社群頁面切換
            break
        case 4:
            // 處理設置頁面切換
            break
        default:
            break
        }
    }
}

// 主頁視圖（整合統計功能）
struct HomeView: View {
    @State private var selectedTimeRange = 0
    private let timeRanges = ["Today", "Week", "Month"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Time Range", selection: $selectedTimeRange) {
                        ForEach(Array(timeRanges.indices), id: \.self) { index in
                            Text(timeRanges[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .background(Color.oceanTheme.lightBlue.opacity(0.3))
                    .cornerRadius(8)
                    
                    UsageOverviewCard()
                    UsageTrendCard()
                    AppUsageRankingCard()
                }
                .padding(.top)
            }
            .background(
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
            )
            .navigationTitle("Ocean Calm")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// 使用概覽卡片
struct UsageOverviewCard: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "wave.3.right")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Usage Overview")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
            
            HStack(spacing: 30) {
                VStack {
                    Text("6h 30m")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    Text("Total Usage")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
                
                VStack {
                    Text("↑12%")
                        .font(.title2)
                        .foregroundColor(Color.oceanTheme.coral)
                    Text("vs Last Period")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
            }
            
            ProgressView(value: 0.75)
                .padding(.horizontal)
                .tint(Color.oceanTheme.coral)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.oceanTheme.cardBackground)
                .shadow(color: Color.oceanTheme.deepBlue.opacity(0.3), radius: 10)
        )
        .padding(.horizontal)
    }
}

// 使用趨勢圖表
struct UsageTrendCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Usage Trend")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
            .padding(.horizontal)
            
            Rectangle()
                .fill(Color.oceanTheme.mediumBlue.opacity(0.1))
                .frame(height: 200)
                .overlay(
                    Text("Usage Trend Chart")
                        .foregroundColor(Color.oceanTheme.textSecondary)
                )
        }
        .padding(.vertical)
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// 應用使用排行卡片
struct AppUsageRankingCard: View {
    private let appCount = 5  // 定義固定數量
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "list.star")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Most Used Apps")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
            .padding(.horizontal)
            
            // 使用 indices 方式
            let apps = Array(0..<appCount)
            ForEach(apps, id: \.self) { index in
                AppUsageRow()
                    .padding(.horizontal)
                if index != apps.count - 1 {
                    Divider()
                        .background(Color.oceanTheme.divider)
                }
            }
        }
        .padding(.vertical)
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// 單個應用使用行
struct AppUsageRow: View {
    var body: some View {
        HStack {
            Image(systemName: "app.fill")
                .foregroundColor(Color.oceanTheme.coral)
                .frame(width: 32, height: 32)
                .background(Color.oceanTheme.coral.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("App Name")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                Text("2h 30m")
                    .font(.subheadline)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            
            Spacer()
            
            Text("↑12%")
                .foregroundColor(Color.oceanTheme.coral)
        }
    }
}

// 深呼吸視圖
struct BreathingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    WaveView()
                        .frame(height: 200)
                    
                    Text("Take a moment to breathe")
                        .font(.title)
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    
                    Button(action: {
                        // Start breathing exercise
                    }) {
                        HStack {
                            Image(systemName: "wind")
                            Text("Start Session")
                        }
                        .font(.headline)
                        .foregroundColor(Color.oceanTheme.deepBlue)
                        .padding()
                        .background(Color.oceanTheme.accent)
                        .cornerRadius(25)
                    }
                    .rippleEffect()
                }
            }
            .navigationTitle("Ocean Breeze")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// 社群視圖
struct CommunityView: View {
    private let rankCount = 5
    private let challengeCount = 3
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                List {
                    Section(header: 
                        Text("Leaderboard")
                            .foregroundColor(Color.oceanTheme.accent)
                            .font(.headline)
                    ) {
                        ForEach(Array(0..<rankCount), id: \.self) { _ in
                            UserRankRow()
                        }
                    }
                    
                    Section(header: 
                        Text("Challenges")
                            .foregroundColor(Color.oceanTheme.accent)
                            .font(.headline)
                    ) {
                        ForEach(Array(0..<challengeCount), id: \.self) { _ in
                            ChallengeRow()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Deep Dive Community")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

// 用戶排行行
struct UserRankRow: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.title2)
                .foregroundColor(Color.oceanTheme.coral)
            
            VStack(alignment: .leading) {
                Text("Username")
                    .foregroundColor(Color.oceanTheme.textPrimary)
                Text("30 Days Streak")
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            
            Spacer()
            
            Text("#1")
                .font(.headline)
                .foregroundColor(Color.oceanTheme.accent)
        }
        .padding(.vertical, 8)
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
}

// 挑戰行
struct ChallengeRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("7-Day Digital Detox")
                .font(.headline)
                .foregroundColor(Color.oceanTheme.textPrimary)
            
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("128 Participants")
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
                
                Spacer()
                
                Button("Join") {
                    // Handle join action
                }
                .buttonStyle(.bordered)
                .tint(Color.oceanTheme.coral)
            }
        }
        .padding(.vertical, 8)
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
}

// 設定視圖
struct SettingsView: View {
    @State private var showingIconExporter = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                List {
                    Section {
                        NavigationLink {
                            DailyLimitView()
                        } label: {
                            SettingsRow(
                                icon: "hourglass",
                                title: "Daily Limit",
                                subtitle: "Set your daily usage goals"
                            )
                        }
                        .listRowBackground(Color.oceanTheme.cardBackground)
                        
                        NavigationLink {
                            AppCategoriesView()
                        } label: {
                            SettingsRow(
                                icon: "folder",
                                title: "App Categories",
                                subtitle: "Manage app groupings"
                            )
                        }
                        .listRowBackground(Color.oceanTheme.cardBackground)
                    } header: {
                        Text("Usage Limits")
                            .foregroundColor(Color.oceanTheme.accent)
                            .font(.headline)
                            .textCase(nil)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                    }
                    
                    Section {
                        NavigationLink {
                            RemindersView()
                        } label: {
                            SettingsRow(
                                icon: "bell",
                                title: "Reminders",
                                subtitle: "Customize notifications"
                            )
                        }
                        .listRowBackground(Color.oceanTheme.cardBackground)
                    } header: {
                        Text("Notifications")
                            .foregroundColor(Color.oceanTheme.accent)
                            .font(.headline)
                            .textCase(nil)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                    }
                    
                    Section {
                        NavigationLink {
                            AboutView()
                        } label: {
                            SettingsRow(
                                icon: "info.circle",
                                title: "About",
                                subtitle: "App information & help"
                            )
                        }
                        .listRowBackground(Color.oceanTheme.cardBackground)
                    } header: {
                        Text("More")
                            .foregroundColor(Color.oceanTheme.accent)
                            .font(.headline)
                            .textCase(nil)
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                    }
                    
                    Section(header: Text("App Icon").foregroundColor(Color.oceanTheme.accent)) {
                        Button(action: {
                            showingIconExporter = true
                        }) {
                            SettingsRow(
                                icon: "square.and.arrow.down.fill",
                                title: "Export App Icon",
                                subtitle: "Generate and save app icons"
                            )
                        }
                        .listRowBackground(Color.oceanTheme.cardBackground)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Settings")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showingIconExporter) {
                IconExporter()
            }
        }
    }
}

// 設定行
struct SettingsRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(Color.oceanTheme.coral)
                .frame(width: 32, height: 32)
                .background(Color.oceanTheme.coral.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.accent)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// 設定相關視圖的更新
struct DailyLimitView: View {
    var body: some View {
        ZStack {
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
            
            List {
                Section(header: 
                    Text("Daily Goals")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                        .textCase(nil)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                ) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(Color.oceanTheme.coral)
                            .frame(width: 32, height: 32)
                            .background(Color.oceanTheme.coral.opacity(0.1))
                            .cornerRadius(8)
                        Text("Set Time Limit")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                        Spacer()
                        Text("6 hours")
                            .foregroundColor(Color.oceanTheme.accent)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.oceanTheme.cardBackground)
                    
                    HStack {
                        Image(systemName: "bell")
                            .foregroundColor(Color.oceanTheme.coral)
                            .frame(width: 32, height: 32)
                            .background(Color.oceanTheme.coral.opacity(0.1))
                            .cornerRadius(8)
                        Text("Alert Frequency")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                        Spacer()
                        Text("Every hour")
                            .foregroundColor(Color.oceanTheme.accent)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.oceanTheme.cardBackground)
                }
                
                Section(header: 
                    Text("Exceptions")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                        .textCase(nil)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                ) {
                    HStack {
                        Image(systemName: "star")
                            .foregroundColor(Color.oceanTheme.coral)
                            .frame(width: 32, height: 32)
                            .background(Color.oceanTheme.coral.opacity(0.1))
                            .cornerRadius(8)
                        Text("Priority Apps")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.oceanTheme.cardBackground)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Daily Limit")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct AppCategoriesView: View {
    var body: some View {
        ZStack {
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
            
            List {
                Section(header: 
                    Text("Productivity")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    ForEach(0..<3, id: \.self) { _ in
                        AppCategoryRow(appName: "Work App", category: "Productivity")
                    }
                }
                
                Section(header: 
                    Text("Social")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    ForEach(0..<3, id: \.self) { _ in
                        AppCategoryRow(appName: "Social App", category: "Social")
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("App Categories")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct AppCategoryRow: View {
    let appName: String
    let category: String
    
    var body: some View {
        HStack {
            Image(systemName: "app.fill")
                .foregroundColor(Color.oceanTheme.coral)
                .frame(width: 32, height: 32)
                .background(Color.oceanTheme.coral.opacity(0.1))
                .cornerRadius(8)
            
            Text(appName)
                .foregroundColor(Color.oceanTheme.textPrimary)
            
            Spacer()
            
            Text(category)
                .font(.caption)
                .foregroundColor(Color.oceanTheme.textSecondary)
        }
        .padding(.vertical, 8)
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
}

struct RemindersView: View {
    var body: some View {
        ZStack {
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
            
            List {
                Section(header: 
                    Text("Notification Types")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    ReminderRow(title: "Usage Alerts", description: "When reaching limits")
                    ReminderRow(title: "Break Time", description: "Regular break reminders")
                    ReminderRow(title: "Daily Summary", description: "End of day report")
                }
                
                Section(header: 
                    Text("Quiet Hours")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    ReminderRow(title: "Start Time", description: "10:00 PM")
                    ReminderRow(title: "End Time", description: "7:00 AM")
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Reminders")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ReminderRow: View {
    let title: String
    let description: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                Text(description)
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            
            Spacer()
            
            Toggle("", isOn: .constant(true))
                .tint(Color.oceanTheme.coral)
        }
        .padding(.vertical, 4)
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
}

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
            
            List {
                Section(header: 
                    Text("App Info")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    InfoRow(title: "Version", detail: "1.0.0")
                    InfoRow(title: "Build", detail: "2024.1")
                }
                
                Section(header: 
                    Text("Support")
                        .foregroundColor(Color.oceanTheme.accent)
                        .font(.headline)
                ) {
                    InfoRow(title: "Help Center", detail: "")
                    InfoRow(title: "Privacy Policy", detail: "")
                    InfoRow(title: "Terms of Use", detail: "")
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("About")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct InfoRow: View {
    let title: String
    let detail: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color.oceanTheme.textPrimary)
            Spacer()
            if !detail.isEmpty {
                Text(detail)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
        }
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
}

// 波浪動畫視圖
struct WaveView: View {
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            // 使用更新後的 OceanWaveView
            OceanWaveView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false)
            ) {
                waveOffset = Angle(degrees: 360)
            }
        }
    }
}

// 商城視圖
struct StoreView: View {
    @State private var showingPurchaseConfirmation = false
    @State private var selectedItem: StoreItem?
    @State private var showingPurchaseHistory = false
    @State private var showingCoralGuide = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 珊瑚幣餘額卡片
                        CoralBalanceCard()
                            .cardAnimation(delay: 0.1)
                        
                        // 限時特惠商品
                        LimitedTimeOffers()
                            .cardAnimation(delay: 0.15)
                        
                        // 原有的商品分類
                        StoreSection(
                            title: "Themes",
                            items: [
                                StoreItem(name: "Deep Ocean", price: 100, image: "paintpalette.fill"),
                                StoreItem(name: "Coral Reef", price: 150, image: "sparkles"),
                                StoreItem(name: "Arctic Sea", price: 200, image: "snowflake")
                            ],
                            icon: "paintpalette.fill"
                        )
                        .cardAnimation(delay: 0.2)
                        
                        StoreSection(
                            title: "Achievements",
                            items: [
                                StoreItem(name: "Ocean Explorer", price: 300, image: "star.fill"),
                                StoreItem(name: "Wave Master", price: 250, image: "crown.fill"),
                                StoreItem(name: "Deep Diver", price: 400, image: "medal.fill")
                            ],
                            icon: "trophy.fill"
                        )
                        .cardAnimation(delay: 0.3)
                        
                        StoreSection(
                            title: "Special Items",
                            items: [
                                StoreItem(name: "Focus Booster", price: 500, image: "bolt.fill"),
                                StoreItem(name: "Time Crystal", price: 1000, image: "clock.fill"),
                                StoreItem(name: "Ocean Pass", price: 2000, image: "ticket.fill")
                            ],
                            icon: "sparkles"
                        )
                        .cardAnimation(delay: 0.4)
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Coral Store")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.oceanTheme.deepBlue.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { showingPurchaseHistory = true }) {
                            Label("Purchase History", systemImage: "clock.arrow.circlepath")
                        }
                        
                        Button(action: { showingCoralGuide = true }) {
                            Label("Coral Guide", systemImage: "questionmark.circle")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundColor(Color.oceanTheme.accent)
                    }
                }
            }
            .sheet(isPresented: $showingPurchaseHistory) {
                PurchaseHistoryView()
            }
            .sheet(isPresented: $showingCoralGuide) {
                CoralGuideView()
            }
            .alert("Confirm Purchase", isPresented: $showingPurchaseConfirmation, presenting: selectedItem) { item in
                Button("Cancel", role: .cancel) { }
                Button("Buy") {
                    // 處理購買邏輯
                }
            } message: { item in
                Text("Would you like to purchase \(item.name) for \(item.price) corals?")
            }
        }
    }
}

// 珊瑚幣餘額卡片
struct CoralBalanceCard: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("Coral Balance")
                    .font(.headline)
                    .foregroundColor(Color.oceanTheme.textPrimary)
            }
            
            Text("1,250")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.oceanTheme.coral)
            
            Text("Complete tasks to earn more corals!")
                .font(.caption)
                .foregroundColor(Color.oceanTheme.textSecondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.oceanTheme.cardBackground)
                .shadow(color: Color.oceanTheme.deepBlue.opacity(0.3), radius: 10)
        )
        .padding(.horizontal)
    }
}

// 商品分類
struct StoreSection: View {
    let title: String
    let items: [StoreItem]
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            StoreSectionTitle(title: title, icon: icon)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(items, id: \.id) { item in
                        StoreItemCard(item: item)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// 商品數據模型
struct StoreItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
    var originalPrice: Int? = nil  // 添加原價屬性
}

// 商品卡片
struct StoreItemCard: View {
    let item: StoreItem
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: item.image)
                .font(.system(size: 30))
                .foregroundColor(Color.oceanTheme.coral)
                .frame(width: 60, height: 60)
                .background(Color.oceanTheme.coral.opacity(0.1))
                .cornerRadius(15)
            
            Text(item.name)
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(Color.oceanTheme.textPrimary)
            
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("\(item.price)")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.oceanTheme.coral)
            }
            
            if let originalPrice = item.originalPrice {
                Text("\(originalPrice)")
                    .font(.system(.caption2, design: .rounded))
                    .strikethrough()
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            
            Button(action: {
                withAnimation(.spring()) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }) {
                Text("Buy")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color.oceanTheme.deepBlue)
                    .frame(width: 80)
                    .padding(.vertical, 8)
                    .background(Color.oceanTheme.accent)
                    .cornerRadius(20)
            }
        }
        .padding()
        .frame(width: 140)
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
        .shadow(color: Color.oceanTheme.deepBlue.opacity(0.2), radius: 5, x: 0, y: 2)
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
    }
}

// 限時特惠商品視圖
struct LimitedTimeOffers: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                StoreSectionTitle(title: "Limited Time Offers", icon: "timer")
                
                Spacer()
                
                Text("23:59:59")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.medium)
                    .foregroundColor(Color.oceanTheme.coral)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.oceanTheme.coral.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(limitedTimeItems, id: \.id) { item in
                        LimitedTimeItemCard(item: item)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var limitedTimeItems: [StoreItem] = [
        StoreItem(name: "Special Theme", price: 80, image: "wand.and.stars", originalPrice: 100),
        StoreItem(name: "Premium Pack", price: 450, image: "gift.fill", originalPrice: 600),
        StoreItem(name: "Rare Badge", price: 200, image: "star.circle.fill", originalPrice: 300)
    ]
}

// 限時特惠商品卡片
struct LimitedTimeItemCard: View {
    let item: StoreItem
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 12) {
            // ... 原有的商品卡片內容 ...
            
            if let originalPrice = item.originalPrice {
                Text("\(originalPrice)")
                    .font(.caption)
                    .strikethrough()
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
        }
        // ... 其他樣式保持不變 ...
    }
}

// 購買歷史視圖
struct PurchaseHistoryView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                List {
                    ForEach(purchaseHistory, id: \.id) { purchase in
                        PurchaseHistoryRow(purchase: purchase)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Purchase History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // 關閉視圖
                    }
                }
            }
        }
    }
    
    private var purchaseHistory: [PurchaseRecord] = [
        PurchaseRecord(itemName: "Deep Ocean", price: 100, date: Date()),
        PurchaseRecord(itemName: "Focus Booster", price: 500, date: Date().addingTimeInterval(-86400))
    ]
}

// 珊瑚幣獲取指南視圖
struct CoralGuideView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(coralGuides, id: \.id) { guide in
                            CoralGuideCard(guide: guide)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Coral Guide")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        // 關閉視圖
                    }
                }
            }
        }
    }
    
    private var coralGuides: [CoralGuide] = [
        CoralGuide(title: "Daily Check-in", description: "Get 10 corals every day you open the app", reward: 10),
        CoralGuide(title: "Complete Goals", description: "Earn 50 corals for each completed daily goal", reward: 50),
        CoralGuide(title: "Weekly Streak", description: "Maintain a weekly streak to earn bonus corals", reward: 100),
        CoralGuide(title: "Share Progress", description: "Share your progress to earn extra corals", reward: 20)
    ]
}

// 數據模型
struct PurchaseRecord: Identifiable {
    let id = UUID()
    let itemName: String
    let price: Int
    let date: Date
}

struct CoralGuide: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let reward: Int
}

// 購買歷史行
struct PurchaseHistoryRow: View {
    let purchase: PurchaseRecord
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(purchase.itemName)
                    .foregroundColor(Color.oceanTheme.textPrimary)
                    .fontWeight(.medium)
                
                Text(formatDate(purchase.date))
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundColor(Color.oceanTheme.coral)
                Text("\(purchase.price)")
                    .foregroundColor(Color.oceanTheme.coral)
                    .fontWeight(.medium)
            }
        }
        .padding(.vertical, 8)
        .listRowBackground(Color.oceanTheme.cardBackground)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// 珊瑚幣指卡片
struct CoralGuideCard: View {
    let guide: CoralGuide
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(guide.title)
                        .font(.headline)
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    
                    Text(guide.description)
                        .font(.subheadline)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(Color.oceanTheme.coral)
                    Text("\(guide.reward)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.oceanTheme.coral)
                }
            }
            
            Button(action: {
                // 執行關任務的操作
            }) {
                Text("Start Task")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.oceanTheme.deepBlue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.oceanTheme.accent)
                    .cornerRadius(20)
            }
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
    }
}

// 商城視圖中的卡片標題樣式
struct StoreSectionTitle: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.oceanTheme.coral)
            Text(title)
                .font(.headline)
                .foregroundColor(Color.oceanTheme.textPrimary)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

