import SwiftUI

struct BreatheGuideView: View {
    @State private var selectedPattern: BreathingPattern = .defaultPattern
    @State private var showBreatheView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(BreathingPattern.allPatterns, id: \.name) { pattern in
                        PatternCard(
                            pattern: pattern,
                            isSelected: selectedPattern.name == pattern.name
                        ) {
                            withAnimation {
                                selectedPattern = pattern
                                showBreatheView = true
                            }
                        }
                    }
                }
                .padding()
            }
            .oceanBackground()
            .navigationBarSetup(title: "Ocean Breeze")
        }
        .fullScreenCover(isPresented: $showBreatheView) {
            BreatheView(selectedPattern: selectedPattern)
        }
    }
}

// 呼吸模式卡片組件
private struct PatternCard: View {
    let pattern: BreathingPattern
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(pattern.name)
                        .font(.headline)
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.oceanTheme.coral)
                    }
                }
                
                Text(pattern.description)
                    .font(.subheadline)
                    .foregroundColor(Color.oceanTheme.textSecondary)
                
                Text("\(Int(pattern.inhaleTime))-\(Int(pattern.holdTime))-\(Int(pattern.exhaleTime)) • \(pattern.cycles) 循環")
                    .font(.caption)
                    .foregroundColor(Color.oceanTheme.coral)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.oceanTheme.deepBlue.opacity(0.6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected ? Color.oceanTheme.coral : Color.clear,
                        lineWidth: 2
                    )
            )
        }
    }
}

#Preview {
    BreatheGuideView()
}
