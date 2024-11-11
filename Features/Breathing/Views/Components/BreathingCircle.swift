//  BreathingCircle.swift
//  Breathing
//  該檔案為深呼吸介面動畫視圖，用於模擬深呼吸介面動畫效果。
//  動畫為呼吸圓環，用於模擬呼吸時的圓環效果。
//  運用於深呼吸介面中。
//  Created by  on 2024/11.
//  

import SwiftUI

struct BreathingCircle: View {
    let phase: BreathingPhase
    let progress: CGFloat
    
    private var currentScale: CGFloat {
        let baseScale: CGFloat = 1.0
        let maxScale: CGFloat = 1.4
        
        switch phase {
        case .inhale:
            return baseScale + (maxScale - baseScale) * progress
        case .hold:
            return maxScale
        case .exhale:
            return maxScale - (maxScale - baseScale) * progress
        case .rest:
            return baseScale
        }
    }
    
    var body: some View {
        ZStack {
            // 進度圈背景
            Circle()
                .stroke(
                    Color.oceanTheme.lightBlue.opacity(0.3),
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
            
            // 進度指示器
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.oceanTheme.coral,
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            // 階段文字放在圓心
            Text(phase.rawValue)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(Color.oceanTheme.lightBlue)
        }
        .frame(width: 200, height: 200)
        .scaleEffect(currentScale)
        
    }
}


