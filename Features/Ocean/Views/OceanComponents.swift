//
//  OceanComponents.swift
//  Ocean
//  該檔案為波浪視圖，用於模擬海洋波浪的動畫效果。
//  運用於深呼吸呼吸動畫中。
//  Created by  on 2024/11.
//  測試結果：
//  頻率：3.2
//  振幅：25.3
//  透明度：0.13

import SwiftUI

// 將 WavePath 移到外部
struct WavePath: Shape {
    var offset: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        let midHeight = height / 2
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let sine = sin((relativeX * .pi * 2 * frequency) + offset)
            let y = midHeight + sine * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}
