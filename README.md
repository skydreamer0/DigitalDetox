

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
- **基礎功能**：多種呼吸模式、計時系統、階段提示文字與控制面板。
- **視覺設計**：整合海洋主題動畫效果。
- **音頻系統**：提供呼吸引導音效及背景音樂支持，具備獨立音量控制。

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
1. **視圖層 (Views)**：包括 BreatheView 主視圖、動畫視圖和引導視圖。
2. **視圖模型 (ViewModels)**：使用 BreatheViewModel 管理狀態。
3. **模型層 (Models)**：包括呼吸模式、會話管理與記錄儲存。
4. **服務層 (Services)**：BreatheAudioService 管理音頻效果。

---