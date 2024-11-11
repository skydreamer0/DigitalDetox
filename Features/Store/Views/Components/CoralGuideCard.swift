import SwiftUI

struct CoralGuideCard: View {
    let guide: CoralGuide
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(guide.title)
                        .font(.headline)
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    
                    Text(guide.description)
                        .font(.subheadline)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(Color.oceanTheme.coral)
                    Text("\(guide.reward)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.oceanTheme.coral)
                }
            }
            
            if !guide.requirements.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Requirements")
                        .font(.caption)
                        .foregroundColor(Color.oceanTheme.textSecondary)
                    
                    ForEach(guide.requirements, id: \.self) { requirement in
                        HStack {
                            Image(systemName: guide.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(guide.isCompleted ? Color.oceanTheme.coral : Color.oceanTheme.textSecondary)
                            Text(requirement)
                                .font(.caption)
                                .foregroundColor(Color.oceanTheme.textSecondary)
                        }
                    }
                }
            }
            
            Button(action: {
                // 執行任務的操作
            }) {
                Text(guide.isCompleted ? "Completed" : "Start Task")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(guide.isCompleted ? Color.oceanTheme.textSecondary : Color.oceanTheme.deepBlue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(guide.isCompleted ? Color.oceanTheme.deepBlue.opacity(0.3) : Color.oceanTheme.accent)
                    .cornerRadius(20)
            }
            .disabled(guide.isCompleted)
        }
        .padding()
        .background(Color.oceanTheme.cardBackground)
        .cornerRadius(12)
    }
} 