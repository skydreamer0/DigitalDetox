//
//  DigitalDetoxApp.swift
//  DigitalDetox
//  此檔案為App的進入點，負責初始化App的狀態和環境。
//  主要是初始化主題管理器，並將其設為環境物件，供App內的各個視圖使用。
//  Created by George on 2024/11/8.
//

import SwiftUI

@main
struct DigitalDetoxApp: App {
    @StateObject private var themeManager = OceanThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}
