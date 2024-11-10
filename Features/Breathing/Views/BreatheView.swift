import SwiftUI

struct BreatheView: View {
    @StateObject private var viewModel = BreatheViewModel()
    @State private var selectedPattern: BreathingPattern = .defaultPattern
    @State private var showPatternPicker = false
    @State private var isBreathing = false
    @State private var bubbleAnimation = false
    
    var body: some View {
        ZStack {
            // 背景
            Color.oceanTheme.backgroundGradient
                .ignoresSafeArea()
            
            // 氣泡背景
            BubbleEffect()
                .opacity(bubbleAnimation ? 1 : 0.3)
                .animation(.easeInOut(duration: 2).repeatForever(), value: bubbleAnimation)
            
            VStack(spacing: 30) {
                // 頂部導航欄
                HStack {
                    // 模式選擇按鈕
                    Menu {
                        ForEach([BreathingPattern.defaultPattern,
                                BreathingPattern.focusPattern,
                                BreathingPattern.sleepPattern], id: \.name) { pattern in
                            Button(action: {
                                selectedPattern = pattern
                                viewModel.selectedPattern = pattern
                            }) {
                                HStack {
                                    Text(pattern.name)
                                    if pattern.name == selectedPattern.name {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedPattern.name)
                                .font(.headline)
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                
                // 呼吸動畫
                BreatheAnimationView(
                    phase: viewModel.currentPhase,
                    isBreathing: isBreathing
                )
                .frame(height: 300)
                
                // 計時顯示
                VStack(spacing: 10) {
                    // 當前階段顯示
                    Text(phaseText)
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.9))
                        .transition(.opacity.combined(with: .scale))
                        .animation(.easeInOut(duration: 0.5), value: viewModel.currentPhase)
                    
                    // 計時顯示
                    HStack(spacing: 5) {
                        // 使用自定義的動畫計時器視圖
                        AnimatedTimeView(timeRemaining: viewModel.timeRemaining)
                        
                        Text("sec")
                            .font(.title2)
                            .offset(y: 4)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .scaleEffect(isBreathing ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isBreathing)
                    )
                }
                
                Spacer()
                
                // 底部控制欄
                HStack(spacing: 30) {
                    // 音效控制按鈕
                    Button(action: { viewModel.toggleBreathGuidance() }) {
                        Image(systemName: viewModel.breathGuidanceEnabled ? "waveform" : "waveform.slash")
                            .font(.title2)
                    }
                    .buttonStyle(AudioControlButtonStyle())
                    
                    // 重置按鈕
                    Button(action: {
                        withAnimation {
                            viewModel.resetSession()
                            isBreathing = false
                            bubbleAnimation = false
                        }
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title2)
                    }
                    .buttonStyle(AudioControlButtonStyle())
                    
                    // 開始/暫停按鈕
                    Button(action: {
                        withAnimation {
                            isBreathing.toggle()
                            bubbleAnimation.toggle()
                            if isBreathing {
                                viewModel.startSession()
                            } else {
                                viewModel.pauseSession()
                            }
                        }
                    }) {
                        Image(systemName: isBreathing ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.oceanTheme.coral)
                            .clipShape(Circle())
                    }
                    
                    // 背景音樂按鈕
                    Button(action: { viewModel.toggleBackgroundMusic() }) {
                        Image(systemName: viewModel.backgroundMusicEnabled ? "music.note" : "music.note.slash")
                            .font(.title2)
                    }
                    .buttonStyle(AudioControlButtonStyle())
                }
                .padding(.bottom, 50)
            }
        }
    }
    
    // 添加計算屬性
    private var phaseText: String {
        switch viewModel.currentPhase {
        case .inhale:
            return "Inhale"
        case .hold:
            return "Hold"
        case .exhale:
            return "Exhale"
        case .rest:
            return "Rest"
        }
    }
    
    private var phaseGuideText: String {
        switch viewModel.currentPhase {
        case .inhale:
            return "Breathe in slowly\nFeel the air filling your lungs"
        case .hold:
            return "Hold your breath\nStay calm and centered"
        case .exhale:
            return "Release slowly\nLet go of all tension"
        case .rest:
            return "Take a moment\nPrepare for next cycle"
        }
    }
}

// 呼吸模式選擇視圖
struct PatternPickerView: View {
    @Binding var selectedPattern: BreathingPattern
    @Environment(\.dismiss) var dismiss
    
    let patterns: [BreathingPattern] = [
        .defaultPattern,    // 4-7-8 放鬆呼吸
        .focusPattern,      // 4-4-4 專注呼吸
        .sleepPattern,      // 5-8-9 睡眠呼吸
    ]
    
    var body: some View {
        NavigationView {
            List(patterns, id: \.name) { pattern in
                Button(action: {
                    selectedPattern = pattern
                    dismiss()
                }) {
                    VStack(alignment: .leading) {
                        Text(pattern.name)
                            .font(.headline)
                        Text(pattern.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Choose Breathing Pattern")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Custom") {
                        // TODO: 實現自定義模式設置
                    }
                }
            }
        }
    }
}

// 海洋氣泡背景
struct OceanBubblesBackground: View {
    let isAnimating: Bool
    let bubbleCount = 20
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<bubbleCount, id: \.self) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.white.opacity(0.2), .white.opacity(0.1)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: CGFloat.random(in: 10...40))
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: isAnimating ? 
                            geometry.size.height + 100 : 
                            -100
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 8...15))
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...5)),
                        value: isAnimating
                    )
            }
        }
    }
}

// 音頻控制按鈕樣式
struct AudioControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(width: 44, height: 44)
            .background(Color.white.opacity(0.2))
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// 預覽
struct BreatheView_Previews: PreviewProvider {
    static var previews: some View {
        BreatheView()
    }
}

// 添加自定義的動畫計時器視圖
struct AnimatedTimeView: View {
    let timeRemaining: TimeInterval
    @State private var displayTime: TimeInterval
    
    init(timeRemaining: TimeInterval) {
        self.timeRemaining = timeRemaining
        self._displayTime = State(initialValue: timeRemaining)
    }
    
    var body: some View {
        Text(displayTime.formattedTime)
            .font(.system(size: 48, weight: .light))
            .contentTransition(.numericText(value: displayTime))
            .onChange(of: timeRemaining) { oldValue, newValue in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    displayTime = newValue
                }
            }
    }
} 