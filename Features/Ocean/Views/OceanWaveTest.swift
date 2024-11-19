// 單元測試 
// 波浪測試
// created  2024/11/11
// 測試結果：
// 頻率：3.2
// 振幅：25.3
// 透明度：0.13

import SwiftUI

struct OceanWaveTest: View {
    @State private var isAnimating = true
    @State private var waveOffset1 = 0.0
    @State private var waveOffset2 = 120.0
    @State private var waveOffset3 = 240.0
    @State private var opacity: Double = 0.13
    @State private var frequency: Double = 3.2
    @State private var amplitude: Double = 25.3
    @State private var isMovingRight = false
    
    // 波浪參數
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // 波浪預覽區域
            ZStack {
                Color.blue.opacity(0.3)
                    .ignoresSafeArea()
                
                // 波浪容器
                GeometryReader { geometry in
                    let waveWidth = geometry.size.width * 4
                    
                    ZStack {
                        // 第一層波浪（最底層）
                        TestWaveShape(offset: waveOffset1, amplitude: amplitude, frequency: frequency)
                            .fill(Color.blue.opacity(opacity))
                            .frame(width: waveWidth)
                            .offset(x: -waveOffset1)
                        
                        // 第二層波浪（中層）
                        TestWaveShape(offset: waveOffset2, amplitude: amplitude * 0.8, frequency: frequency * 1.2)
                            .fill(Color.blue.opacity(opacity * 0.8))
                            .frame(width: waveWidth)
                            .offset(x: -waveOffset2)
                        
                        // 第三層波浪（最上層）
                        TestWaveShape(offset: waveOffset3, amplitude: amplitude * 0.6, frequency: frequency * 1.4)
                            .fill(Color.blue.opacity(opacity * 0.6))
                            .frame(width: waveWidth)
                            .offset(x: -waveOffset3)
                    }
                    .frame(width: geometry.size.width)
                    .clipped()
                }
                .frame(height: 300)
            }
            .frame(height: 300)
            
            // 控制面板
            VStack(spacing: 20) {
                // 頻率控制
                HStack {
                    Text("頻率：\(String(format: "%.1f", frequency))")
                        .foregroundColor(.white)
                    Slider(value: $frequency, in: 1...10)
                }
                
                // 振幅控制
                HStack {
                    Text("振幅：\(String(format: "%.1f", amplitude))")
                        .foregroundColor(.white)
                    Slider(value: $amplitude, in: 5...50)
                }
                
                // 透明度控制
                HStack {
                    Text("透明度：\(String(format: "%.2f", opacity))")
                        .foregroundColor(.white)
                    Slider(value: $opacity, in: 0...1)
                }
                
                // 動畫控制按鈕
                Button(action: {
                    isAnimating.toggle()
                }) {
                    Text(isAnimating ? "停止動畫" : "開始動畫")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue.opacity(0.5))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(Color.black)
        .onReceive(timer) { _ in
            guard isAnimating else { return }
            withAnimation(.linear(duration: 0.02)) {
                let moveAmount: Double = isMovingRight ? -1 : 1
                
                waveOffset1 += moveAmount
                waveOffset2 += moveAmount * 1.1
                waveOffset3 += moveAmount * 1.2
                
                let maxOffset = UIScreen.main.bounds.width * 0.3
                
                if abs(waveOffset1) >= maxOffset {
                    isMovingRight.toggle()
                }
            }
        }
    }
}

// 預覽
struct OceanWaveTest_Previews: PreviewProvider {
    static var previews: some View {
        OceanWaveTest()
    }
}
