import SwiftUI

struct PatternPickerView: View {
    @Binding var selectedPattern: BreathingPattern
    @Environment(\.dismiss) private var dismiss
    
    private let patterns: [BreathingPattern] = [
        .defaultPattern,
        .focusPattern,
        .sleepPattern
    ]
    
    var body: some View {
        NavigationView {
            List(patterns, id: \.name) { pattern in
                Button(action: {
                    selectedPattern = pattern
                    dismiss()
                }) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(pattern.name)
                            .font(.headline)
                            .foregroundColor(Color.oceanTheme.textPrimary)
                        
                        Text(pattern.description)
                            .font(.subheadline)
                            .foregroundColor(Color.oceanTheme.textSecondary)
                        
                        Text("\(Int(pattern.inhaleTime))-\(Int(pattern.holdTime))-\(Int(pattern.exhaleTime)) • \(pattern.cycles) 循環")
                            .font(.caption)
                            .foregroundColor(Color.oceanTheme.coral)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("選擇呼吸模式")
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
    PatternPickerView(selectedPattern: .constant(.defaultPattern))
} 