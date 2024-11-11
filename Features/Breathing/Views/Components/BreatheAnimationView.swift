//  BreatheAnimationView.swift
//  Breathing
//  動畫效果為整體動畫，包含波浪、呼吸環、氣泡等效果。
//  運用於深呼吸介面中。
//  Created by  on 2024/11.
//  

import SwiftUI

struct BreatheAnimationView: View {
    let phase: BreathingPhase
    let isBreathing: Bool
    let progress: CGFloat
    let timeRemaining: TimeInterval
    let onStart: () -> Void
    let onPause: () -> Void
    let onStop: () -> Void
    @State private var showMusicPicker = false
    @StateObject private var audioService = BreatheAudioService.shared
    
    var body: some View {
        ZStack {
            // 確保背景完全覆蓋
            OceanThemeComponents.DeepOceanBackground()
                .ignoresSafeArea(edges: .all)
            
            // 波浪效果
            OceanWaveView()
                .scaleEffect(isBreathing ? 1.1 : 1.0)
                .animation(
                    .easeInOut(duration: 2)
                    .repeatForever(autoreverses: true),
                    value: isBreathing
                )
                .ignoresSafeArea(edges: .bottom)
            
            VStack {
                Spacer()
                
                // 呼吸圓環
                BreathingCircle(
                    phase: phase,
                    progress: progress
                )
                
                Spacer()
                    .frame(height: 100)
                
                // 控制按鈕和音樂名稱
                VStack(spacing: 16) {
                    // 控制按鈕
                    HStack(spacing: 40) {
                        if isBreathing {
                            Button(action: onPause) {
                                Image(systemName: "pause.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.oceanTheme.coral)
                            }
                        } else {
                            Button(action: onStart) {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(Color.oceanTheme.coral)
                            }
                        }
                        
                        // 音樂切換按鈕 - 使用與其他按鈕相同的風格
                        Button(action: { showMusicPicker = true }) {
                            Image(systemName: "headphones.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.oceanTheme.lightBlue)
                        }
                        
                        Button(action: onStop) {
                            Image(systemName: "stop.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.oceanTheme.lightBlue)
                        }
                    }
                    
                    // 當前音樂名稱顯示 - 移到按鈕下方
                    if let currentMusic = audioService.currentMusic {
                        Text(currentMusic.name)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color.oceanTheme.lightBlue)
                    }
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // 氣泡效果
            OceanThemeComponents.BubbleCluster(isAnimating: isBreathing)
                .ignoresSafeArea(edges: .bottom)
        }
        .background(Color(UIColor.systemBackground))
        .ignoresSafeArea(edges: .all)
        .sheet(isPresented: $showMusicPicker) {
            MusicPickerView(audioService: audioService)
        }
    }
}

// 音樂選擇器視圖
struct MusicPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var audioService: BreatheAudioService
    
    var body: some View {
        NavigationView {
            List(audioService.musicOptions) { option in
                Button(action: {
                    audioService.playMusic(option)
                    dismiss()
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(option.name)
                                .font(.headline)
                                .foregroundColor(Color.oceanTheme.textPrimary)
                            
                            Spacer()
                            
                            if option.name == audioService.currentMusic?.name {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color.oceanTheme.coral)
                            }
                        }
                        
                        Text(option.description)
                            .font(.caption)
                            .foregroundColor(Color.oceanTheme.textSecondary)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("選擇背景音樂")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("關閉") {
                        dismiss()
                    }
                }
            }
        }
        .oceanBackground()
    }
}

#Preview {
    BreatheAnimationView(
        phase: .inhale,
        isBreathing: true,
        progress: 0.5,
        timeRemaining: 10,
        onStart: {},
        onPause: {},
        onStop: {}
    )
} 