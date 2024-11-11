# 商城系統實現文檔

## 功能概述

商城系統提供用戶使用珊瑚幣購買各種數位商品的功能，包括主題、呼吸模式、成就徽章等。系統採用 MVVM 架構，結合 Core Data 實現數據持久化。

## 系統架構

### 1. 數據層 (Models)

#### 核心模型
```swift
struct StoreItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let price: Int
    let category: StoreCategory
    let imageUrl: String?
    let isLimitedTime: Bool
    let endDate: Date?
    let discountPercentage: Int?
}

enum StoreCategory: String, Codable, CaseIterable {
    case theme
    case breathingPattern
    case achievement
    case special
}

struct PurchaseRecord: Identifiable, Codable {
    let id: UUID
    let itemId: UUID
    let itemName: String
    let price: Int
    let purchaseDate: Date
    let category: StoreCategory
}
```

#### Core Data 實體
- Purchase: 購買記錄實體
- User: 用戶實體（包含珊瑚幣餘額）

### 2. 服務層 (Services)

#### StoreService
- 負責商品數據管理和購買邏輯
- 處理珊瑚幣餘額檢查
- 管理購買記錄的保存

#### PurchaseService
- 處理購買流程
- 管理購買歷史記錄
- 提供購買相關的錯誤處理

#### NetworkService
- 處理網絡請求
- 獲取商品數據
- 處理網絡錯誤

#### CacheService
- 管理本地數據緩存
- 提供離線數據支持
- 優化數據加載性能

### 3. 視圖模型層 (ViewModels)

#### StoreViewModel
```swift
class StoreViewModel: ObservableObject {
    @Published var items: [StoreItem] = []
    @Published var limitedTimeOffers: [StoreItem] = []
    @Published var coralBalance: Int = 0
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadStoreItems()
    func purchaseItem(_ item: StoreItem)
}
```

#### PurchaseHistoryViewModel
- 管理購買歷史記錄的顯示
- 提供歷史記錄的排序和過濾

### 4. 視圖層 (Views)

#### 主要視圖
- StoreView: 商城主頁面
- PurchaseHistoryView: 購買歷史記錄
- CoralGuideView: 珊瑚幣獲取指南

#### 組件
- StoreItemCard: 商品卡片
- CoralBalanceCard: 珊瑚幣餘額顯示
- LimitedTimeOffers: 限時特惠展示
- PurchaseHistoryRow: 購買記錄行

## 數據流程

### 購買流程
1. 用戶點擊購買按鈕
2. StoreViewModel 檢查用戶餘額
3. 調用 StoreService 進行購買
4. 更新用戶珊瑚幣餘額
5. 保存購買記錄
6. 更新 UI 顯示

### 數據加載流程
1. NetworkService 請求數據
2. CacheService 提供本地緩存
3. StoreService 整合數據
4. ViewModel 處理數據
5. View 展示數據

## 錯誤處理

```swift
enum StoreError: Error {
    case insufficientFunds
    case itemNotFound
    case purchaseFailed
    
    var localizedDescription: String {
        switch self {
        case .insufficientFunds: return "餘額不足"
        case .itemNotFound: return "商品不存在"
        case .purchaseFailed: return "購買失敗"
        }
    }
}
```

## 開發規範

### 代碼規範
1. 使用 MVVM 架構分離關注點
2. 遵循 Swift API 設計準則
3. 使用 Combine 進行響應式編程
4. 保持視圖組件的可重用性

### 數據規範
1. 使用 Core Data 進行數據持久化
2. 實現數據緩存機制
3. 確保數據一致性
4. 處理所有可能的錯誤情況

### UI/UX 規範
1. 遵循 Ocean Theme 設計系統
2. 提供清晰的用戶反饋
3. 實現流暢的動畫效果
4. 支持無障礙功能

## 待優化項目

1. 性能優化
   - [ ] 實現圖片緩存
   - [ ] 優化數據加載速度
   - [ ] 減少內存使用

2. 功能擴展
   - [ ] 添加商品搜索
   - [ ] 實現商品推薦
   - [ ] 支持批量購買
   - [ ] 添加自定義音樂解鎖
   - [ ] 實現音樂包購買功能
   - [ ] 支持音樂收藏系統

3. 用戶體驗
   - [ ] 添加購買確認
   - [ ] 優化錯誤提示
   - [ ] 實現動態價格
