import SwiftUI

struct ThemeSettingsView: View {
    @StateObject private var themeService = ThemeService.shared
    @State private var showPurchaseAlert = false
    @State private var selectedTheme: (any ThemeConfigurable)?
    
    var body: some View {
        List {
            Section(header: Text("當前主題")) {
                ThemePreviewCard(theme: themeService.currentTheme)
            }
            
            Section(header: Text("可用主題")) {
                ForEach(Array(themeService.availableThemes), id: \.id) { theme in
                    ThemeRowView(theme: theme) {
                        selectedTheme = theme
                        if !theme.isPurchased {
                            showPurchaseAlert = true
                        } else {
                            themeService.setTheme(theme)
                        }
                    }
                }
            }
        }
        .navigationTitle("主題設置")
        .alert("購買主題", isPresented: $showPurchaseAlert) {
            Button("確認購買") {
                if let theme = selectedTheme {
                    themeService.setTheme(theme)
                }
            }
            Button("取消", role: .cancel) {}
        } message: {
            if let theme = selectedTheme {
                Text("是否購買 \(theme.name) 主題？\n價格：\(theme.price ?? 0) 珊瑚幣")
            }
        }
    }
}

struct ThemeRowView: View {
    let theme: any ThemeConfigurable
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(theme.previewImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(theme.name)
                        .font(.headline)
                    Text(theme.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if !theme.isPurchased {
                    Text("\(theme.price ?? 0)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Image(systemName: "lock.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .disabled(!theme.isPurchased)
    }
} 