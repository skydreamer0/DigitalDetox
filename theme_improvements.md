# 主題系統改善計劃

## 優先級規劃

### P0 - 核心轉換（立即進行）
- [x] 建立統一主題協議 (ThemeConfigurable)
- [x] 實現主題服務 (ThemeService)
- [x] 建立基礎海洋主題 (OceanThemes)
- [ ] 移除舊的主題系統檔案：
  ```
  - Features/Ocean/Theme/OceanThemeConfig.swift
  - Features/Ocean/Theme/OceanThemeVariants.swift
  - Features/Ocean/Managers/OceanThemeManager.swift
  - Features/Ocean/Views/ThemeSwitcher.swift
  ```
- [ ] 更新所有使用 .oceanTheme 的組件

### P1 - 基礎功能（1週內）
- [x] 實現主題切換動畫
- [x] 添加主題修飾器 (ThemeModifier)
- [ ] 完善主題持久化
- [ ] 實現主題預覽功能
- [ ] 優化主題切換性能

### P2 - 使用者體驗（2週內）
- [ ] 添加主題切換過渡動畫
- [ ] 實現主題預覽卡片
- [ ] 優化主題設置介面
- [ ] 添加主題搜索功能

### P3 - 功能擴展（3週內）
- [ ] 實現主題購買流程
- [ ] 添加主題收藏功能
- [ ] 支援主題評分系統
- [ ] 實現主題推薦功能

### P4 - 性能優化（4週內）
- [ ] 實現主題資源預加載
- [ ] 優化主題資源管理
- [ ] 添加主題資源緩存
- [ ] 實現漸進式加載

### P5 - 進階功能（後期規劃）
- [ ] 支援主題自定義
- [ ] 實現主題分享功能
- [ ] 添加主題社區功能
- [ ] 支援主題導出/導入

## 當前實現示例

### 1. 主題配置
```swift
public protocol ThemeConfigurable: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
    var previewImageName: String { get }
    var price: Int? { get }
    var isPurchased: Bool { get }
    
    // 顏色配置
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var deepBlue: Color { get }
    var mediumBlue: Color { get }
    var lightBlue: Color { get }
    var coral: Color { get }
    var accent: Color { get }
    var textPrimary: Color { get }
    var textSecondary: Color { get }
}
```

### 2. 主題使用
```swift
// 視圖中使用
struct ContentView: View {
    @EnvironmentObject private var themeService: ThemeService
    
    var body: some View {
        Text("Hello")
            .foregroundColor(themeService.currentTheme.textPrimary)
            .withTheme()
    }
}

// App 入口點配置
@main
struct DigitalDetoxApp: App {
    @StateObject private var themeService = ThemeService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeService)
                .withTheme()
        }
    }
}
```

### 3. 主題切換
```swift
// 在視圖中切換主題
Button("Switch Theme") {
    themeService.switchTheme(OceanTheme.deepNight)
}
```

## 開發規範

### 1. 命名規範
- 主題相關類型使用 "Theme" 後綴
- 顏色屬性使用描述性名稱
- 修飾器使用動詞開頭

### 2. 檔案組織
```
Features/Theme/
├── Core/
│   └── Protocols/
│       └── ThemeConfigurable.swift
├── Models/
│   └── ThemeModel.swift
├── Services/
│   └── ThemeService.swift
├── Themes/
│   └── Ocean/
│       └── OceanThemes.swift
└── Views/
    └── ThemeSettingsView.swift
```

### 3. 代碼風格
- 使用 SwiftLint 規則
- 添加完整的文檔註釋
- 遵循 MVVM 架構
- 保持代碼簡潔

### 4. 測試要求
- 所有主題需要單元測試
- 主題切換需要 UI 測試
- 性能測試基準：
  - 主題切換 < 300ms
  - 資源加載 < 1s

## 注意事項

1. 並存期間
   - 保持新舊系統功能一致
   - 逐步遷移現有組件
   - 確保無縫切換
   - 保留必要的相容性代碼

2. 效能考量
   - 監控記憶體使用
   - 優化資源加載
   - 避免主線程阻塞
   - 實現高效緩存

3. 用戶體驗
   - 保持動畫流暢
   - 提供清晰的回饋
   - 處理錯誤情況
   - 支援無障礙功能 