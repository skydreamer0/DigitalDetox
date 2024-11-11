//  NoisePattern.swift
//  Breathing
//  該檔案為深呼吸介面動畫視圖。
//  動畫為噪音圖案，用於模擬呼吸時的噪音圖案效果。
//  運用於深呼吸介面中。
//  Created by  on 2024/11.
//  

import SwiftUI

// MARK: - 噪音圖案
struct NoisePattern: View {
    @State private var phase = 0.0
    
    var body: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.5, color: .white))
            context.addFilter(.blur(radius: 8))
            
            context.drawLayer { ctx in
                for _ in 0..<50 {
                    let x = CGFloat.random(in: 0...size.width)
                    let y = CGFloat.random(in: 0...size.height)
                    let rect = CGRect(x: x, y: y, width: 1, height: 1)
                    ctx.fill(Path(rect), with: .color(.white.opacity(0.5)))
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                phase = 1
            }
        }
    }
} 