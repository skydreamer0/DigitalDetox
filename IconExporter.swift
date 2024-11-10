import SwiftUI
import UniformTypeIdentifiers
import Photos

struct IconExporter: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss
    
    // 定義所有需要的圖標尺寸
    private let iconSizes: [(name: String, size: CGFloat, scale: Int)] = [
        // iPhone
        ("icon_20pt@2x", 40, 1),     // 20pt@2x = 40x40
        ("icon_20pt@3x", 60, 1),     // 20pt@3x = 60x60
        ("icon_29pt@2x", 58, 1),     // 29pt@2x = 58x58
        ("icon_29pt@3x", 87, 1),     // 29pt@3x = 87x87
        ("icon_40pt@2x", 80, 1),     // 40pt@2x = 80x80
        ("icon_40pt@3x", 120, 1),    // 40pt@3x = 120x120
        ("icon_60pt@2x", 120, 1),    // 60pt@2x = 120x120
        ("icon_60pt@3x", 180, 1),    // 60pt@3x = 180x180
        
        // iPad
        ("icon_20pt", 20, 1),        // 20pt = 20x20
        ("icon_20pt@2x", 40, 1),     // 20pt@2x = 40x40
        ("icon_29pt", 29, 1),        // 29pt = 29x29
        ("icon_29pt@2x", 58, 1),     // 29pt@2x = 58x58
        ("icon_40pt", 40, 1),        // 40pt = 40x40
        ("icon_40pt@2x", 80, 1),     // 40pt@2x = 80x80
        ("icon_76pt", 76, 1),        // 76pt = 76x76
        ("icon_76pt@2x", 152, 1),    // 76pt@2x = 152x152
        ("icon_83.5pt@2x", 167, 1),  // 83.5pt@2x = 167x167
        
        // App Store
        ("Icon", 1024, 1)            // 1024x1024
    ]
    
    // 檢查是否在模擬器上運行
    private var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.oceanTheme.backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // 預覽
                    IconGenerator()
                        .frame(width: 512, height: 512)
                        .clipShape(RoundedRectangle(cornerRadius: 112))
                        .shadow(color: Color.oceanTheme.deepBlue.opacity(0.3), radius: 10)
                    
                    // 導出按鈕
                    VStack(spacing: 15) {
                        ExportButton(
                            title: "導出所有尺寸",
                            subtitle: "生成所有尺寸的圖標並保存到相簿",
                            action: exportAllSizes
                        )
                        
                        ExportButton(
                            title: "導出 App Store 版本",
                            subtitle: "1024×1024",
                            action: { exportSingleIcon(name: "Icon", size: 1024, scale: 1) }
                        )
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("圖標生成器")
            .alert("提示", isPresented: $showingAlert) {
                Button("確定", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // 請求相簿訪問權限
    private func requestPhotoLibraryAccess(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        case .restricted, .denied:
            DispatchQueue.main.async {
                alertMessage = "請在設定中允許存取相簿，以儲存圖示"
                showingAlert = true
                completion(false)
            }
        case .authorized, .limited:
            completion(true)
        @unknown default:
            completion(false)
        }
    }
    
    // 生成圖標
    private func generateIcon(size: CGFloat, scale: Int = 1) -> UIImage? {
        // 確保在主線程上生成圖標
        if !Thread.isMainThread {
            var result: UIImage?
            DispatchQueue.main.sync {
                result = generateIcon(size: size, scale: scale)
            }
            return result
        }
        
        let renderer = ImageRenderer(content:
            IconGenerator()
                .frame(width: size, height: size)
        )
        
        renderer.scale = 1
        
        if let uiImage = renderer.uiImage {
            let expectedSize = CGSize(width: size, height: size)
            if uiImage.size != expectedSize {
                UIGraphicsBeginImageContextWithOptions(expectedSize, false, 1.0)
                uiImage.draw(in: CGRect(origin: .zero, size: expectedSize))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                if let pngData = resizedImage?.pngData(),
                   let finalImage = UIImage(data: pngData) {
                    return finalImage
                }
            }
            
            if let pngData = uiImage.pngData(),
               let pngImage = UIImage(data: pngData) {
                return pngImage
            }
        }
        return nil
    }
    
    // 修改保存路徑函數
    private func getIconSavePath() -> URL? {
        // 獲取桌面路徑
        let desktopPath = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first?
            .appendingPathComponent("DigitalDetoxIcons")
        
        // 如果無法獲取桌面路徑，則使用文檔目錄
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("DigitalDetoxIcons")
        
        let savePath = desktopPath ?? documentsPath
        
        // 創建目錄（如果不存在）
        if let path = savePath {
            try? FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
        }
        
        return savePath
    }
    
    // 修改 exportSingleIcon 函數
    private func exportSingleIcon(name: String, size: CGFloat, scale: Int) {
        guard let image = generateIcon(size: size, scale: scale) else {
            alertMessage = "圖標生成失敗"
            showingAlert = true
            return
        }
        
        if isSimulator {
            guard let savePath = getIconSavePath() else {
                alertMessage = "無法創建保存目錄"
                showingAlert = true
                return
            }
            
            let filename = "\(name).png"
            let fileURL = savePath.appendingPathComponent(filename)
            
            if let pngData = image.pngData() {
                do {
                    try pngData.write(to: fileURL)
                    DispatchQueue.main.async {
                        let finalSize = Int(size)
                        alertMessage = """
                        圖標已保存到：
                        \(savePath.path)
                        
                        文件：\(filename)
                        大小：\(finalSize)×\(finalSize)
                        
                        請到上述路徑查看生成的圖標
                        """
                        showingAlert = true
                    }
                } catch {
                    alertMessage = "保存失敗：\(error.localizedDescription)"
                    showingAlert = true
                }
            }
        } else {
            // 真機環境，使用相簿
            requestPhotoLibraryAccess { granted in
                if granted {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    DispatchQueue.main.async {
                        let finalSize = Int(size)
                        alertMessage = "圖標已保存到相簿: \(name).png (\(finalSize)×\(finalSize))"
                        showingAlert = true
                    }
                }
            }
        }
    }
    
    // 修改 exportAllSizes 函數
    private func exportAllSizes() {
        if isSimulator {
            guard let savePath = getIconSavePath() else {
                DispatchQueue.main.async {
                    alertMessage = "無法創建保存目錄"
                    showingAlert = true
                }
                return
            }
            
            // 在主線程上生成所有圖標
            let icons = iconSizes.compactMap { (name, size, scale) -> (String, UIImage)? in
                if let image = generateIcon(size: size, scale: scale) {
                    return (name, image)
                }
                return nil
            }
            
            // 在背景線程上保存圖標
            DispatchQueue.global(qos: .userInitiated).async {
                var savedCount = 0
                var savedFiles: [String] = []
                var errors: [String] = []
                
                for (name, image) in icons {
                    if let pngData = image.pngData() {
                        let filename = "\(name).png"
                        let fileURL = savePath.appendingPathComponent(filename)
                        
                        do {
                            try pngData.write(to: fileURL)
                            savedCount += 1
                            savedFiles.append("\(filename)")
                        } catch {
                            errors.append("\(filename): \(error.localizedDescription)")
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    var message = """
                    已保存 \(savedCount) 個圖標到：
                    \(savePath.path)
                    
                    已生成的檔案：
                    \(savedFiles.joined(separator: "\n"))
                    """
                    
                    if !errors.isEmpty {
                        message += "\n\n失敗的檔案：\n\(errors.joined(separator: "\n"))"
                    }
                    
                    alertMessage = message
                    showingAlert = true
                }
            }
        } else {
            // 真機環境
            requestPhotoLibraryAccess { granted in
                if granted {
                    // 在主線程上生成所有圖標
                    let icons = iconSizes.compactMap { (name, size, scale) -> (String, UIImage)? in
                        if let image = generateIcon(size: size, scale: scale) {
                            return (name, image)
                        }
                        return nil
                    }
                    
                    // 保存到相簿
                    var savedCount = 0
                    var savedFiles: [String] = []
                    
                    for (name, image) in icons {
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        savedCount += 1
                        savedFiles.append("\(name).png")
                    }
                    
                    DispatchQueue.main.async {
                        alertMessage = """
                        已成功保存 \(savedCount) 個圖標到相簿
                        所有圖標均為 PNG 格式
                        
                        已生成的檔案：
                        \(savedFiles.joined(separator: "\n"))
                        """
                        showingAlert = true
                    }
                }
            }
        }
    }
}

struct ExportButton: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.oceanTheme.cardBackground)
            .cornerRadius(12)
            .overlay(
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(Color.oceanTheme.coral)
                    .padding(.trailing)
                , alignment: .trailing
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    IconExporter()
} 