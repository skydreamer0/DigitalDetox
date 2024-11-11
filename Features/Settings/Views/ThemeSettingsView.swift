import SwiftUI

struct ThemeSettingsView: View {
    @EnvironmentObject private var themeManager: OceanThemeManager
    
    // 預設主題列表
    private let availableThemes: [ThemeOption] = [
        ThemeOption(name: "預設海洋", theme: DefaultOceanTheme()),
        ThemeOption(name: "深邃夜空", theme: DeepNightTheme()),
        ThemeOption(name: "珊瑚礁", theme: CoralReefTheme()),
        ThemeOption(name: "極光", theme: AuroraTheme())
    ]
    
    var body: some View {
        List {
            Section(header: Text("主題設定")) {
                ForEach(availableThemes) { option in
                    ThemeOptionRow(option: option)
                        .onTapGesture {
                            themeManager.currentTheme = option.theme
                        }
                }
            }
            
            Section(header: Text("主題預覽")) {
                ThemePreviewCard()
                    .frame(height: 200)
            }
        }
        .navigationTitle("視覺主題")
    }
}

// 主題選項模型
struct ThemeOption: Identifiable {
    let id = UUID()
    let name: String
    let theme: OceanThemeConfigurable
}

// 主題選項行
struct ThemeOptionRow: View {
    let option: ThemeOption
    @EnvironmentObject private var themeManager: OceanThemeManager
    
    var body: some View {
        HStack {
            Text(option.name)
            Spacer()
            if themeManager.currentTheme is DefaultOceanTheme {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

// 主題預覽卡片
struct ThemePreviewCard: View {
    @EnvironmentObject private var themeManager: OceanThemeManager
    
    var body: some View {
        ZStack {
            OceanThemeComponents.DeepOceanBackground()
            OceanWaveView()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
} 