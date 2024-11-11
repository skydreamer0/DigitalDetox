# DigitalDetox iOS App

DigitalDetox 是一款專注於幫助用戶管理數位使用時間的 iOS 應用程式，提供全方位的數位健康管理解決方案。

---

## 已完成功能

### 1. UI 框架與視覺設計
- **海洋主題設計系統**：包含配色方案、統一視覺風格、自定義動畫效果。
- **應用圖標設計**：支援所有尺寸與海洋主題圖標，包含動態波浪效果和珊瑚圖案設計。

### 2. 主要頁面
- **主頁面（Home）**：提供使用時間概覽、使用趨勢圖表及應用使用排行。
- **深呼吸頁面（Breathe）**：包含基礎介面設計和波浪動畫效果。
- **商城系統（Store）**：提供珊瑚幣顯示、商品分類、限時特惠功能等。
- **社群功能（Community）**：含有排行榜和挑戰系統介面。
- **設定頁面（Settings）**：包括使用限制設置、應用分類管理、通知提醒設定。

### 3. 動畫效果
- 包括卡片載入、數據更新、波紋、滾動、轉場、圖標波浪和氣泡漂浮等動畫效果。

### 4. 核心服務實現
- **通知服務（NotificationService）**：通知權限請求及自定義提醒。
- **商店服務（StoreService）**：管理珊瑚幣邏輯與購買記錄。
- **數據持久化（DigitalDetoxModel）**：使用 Core Data 設計並儲存使用記錄。

### 5. 深呼吸功能實現
- **基礎功能**：
  - [x] 4-7-8、4-4-4、5-8-9 三種呼吸模式
  - [x] 完整的呼吸階段控制（吸氣、屏息、呼氣、休息）
  - [x] 會話管理與計時系統
  - [x] 循環次數追蹤
- **視覺設計**：整合海洋主題動畫效果
- **音頻系統**：
  - [x] 背景白噪音（ocean_waves）支持
  - [x] 音量控制
  - [x] 自動暫停/恢復功能

---

## 開發中功能

### 1. 深呼吸功能擴展
- [ ] 自定義呼吸模式界面。
- [ ] 練習數據統計與成就系統整合。

### 2. 數據分析功能
- [ ] 練習歷史圖表、使用時間統計及進度追蹤。

### 3. 社群功能擴展
- [ ] 用戶資料管理、排行榜數據更新、挑戰任務及社交分享功能。

### 4. 商城系統擴展
- [ ] 珊瑚幣交易邏輯、商品解鎖及限時特惠計時。

### 5. 性能優化
- [ ] 數據緩存、動畫性能、內存管理及電池使用優化。

### 6. 測試與部署
- [ ] 單元測試、UI 測試自動化及性能測試。

---

## 下一步開發計劃

1. **深呼吸功能優化**：添加自定義模式設置界面、引導語音及放鬆音樂。
2. **數據分析擴展**：實現週報、月報生成及數據可視化展示。
3. **優化用戶體驗**：添加使用引導、動畫優化及錯誤處理。
4. **增強社交功能**：好友系統、群組挑戰及成就分享。

### 主題系統改進計劃

1. **主題持久化**
   - [x] 實現主題偏好本地存儲
   - [ ] 添加主題切換歷史記錄
   - [ ] 支援 iCloud 同步主題設定

2. **主題自定義**
   - [x] 新增主題編輯器介面
   - [x] 支援自定義顏色選擇
   - [x] 提供主題預設模板
   - [ ] 實現主題分享功能

3. **主題動畫優化**
   - [x] 優化主題切換過渡動畫
   - [x] 添加主題預覽動態效果
   - [x] 實現主題漸變切換

4. **主題管理功能**
   - [x] 支援主題收藏
   - [x] 添加主題分類管理
   - [ ] 實現主題搜索功能
   - [ ] 支援主題評分系統

5. **效能優化**
   - [x] 主題資源按需加載
   - [x] 主題切換性能優化
   - [ ] 主題資源緩存管理

6. **可訪問性支援**
   - [ ] 支援動態字型大小
   - [ ] 適配深色模式
   - [ ] 支援視覺障礙輔助

---

## 專案結構
- `/Features` - 功能模組
  - `/Store` - 商城相關功能
  - `/Breathing` - 呼吸相關功能
- `/Views` - 共用視圖元件
- `/Theme` - 主題系統
- `/Utils` - 工具類

## 開發指南
1. 視圖開發規範
2. 服務層使用說明
3. 主題系統擴展指南

---

## 技術堆疊

- SwiftUI
- Core Data
- Combine
- UserNotifications
- HealthKit（待整合）

---

## 開發規範

- **代碼風格**：遵循 Swift 風格指南，使用 SwiftLint 進行檢查並包含完整代碼註釋。
- **版本控制**：採用 Git Flow 工作流，提供清晰的提交信息與代碼審查。
- **文檔維護**：更新 README、API 文檔及更新日誌。

---

## 技術實現細節

### 深呼吸功能架構
1. **視圖層 (Views)**：包括 BreatheView 主視圖、動畫視圖和引導視圖
2. **視圖模型 (ViewModels)**：
   - [x] BreatheViewModel 完整實現
   - [x] 狀態管理（呼吸階段、進度、循環）
   - [x] 計時器控制
   - [x] 音頻整合
3. **模型層 (Models)**：
   - [x] BreathingPhase 枚舉（吸氣、屏息、呼氣、休息）
   - [x] BreathingPattern 結構（預設三種模式）
   - [x] BreathingSession 會話管理
4. **服務層 (Services)**：
   - [x] BreatheAudioService 白噪音管理
   - [x] 音頻會話配置
   - [x] 背景音樂控制

---