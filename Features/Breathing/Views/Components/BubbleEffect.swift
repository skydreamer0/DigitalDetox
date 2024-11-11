//  BubbleEffect.swift
//  Breathing
//  該檔案為深呼吸介面動畫視圖，用於模擬深呼吸介面動畫效果。
//  動畫為氣泡效果，用於模擬呼吸時的氣泡效果。
//  運用於深呼吸介面中。
//  Created by  on 2024/11.
//  

import SwiftUI

// MARK: - 氣泡效果
struct BubbleEffect: View {
    let bubbleCount = 20
    @State private var isAnimating = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<bubbleCount, id: \.self) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.3),
                                .white.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: CGFloat.random(in: 5...20))
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? -20 : geometry.size.height + 20
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 4...8))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...3)),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
} 