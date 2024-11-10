import SwiftUI

struct AppIcon: View {
    var body: some View {
        ZStack {
            // 背景漸層
            LinearGradient(
                colors: [
                    Color.oceanTheme.deepBlue,
                    Color.oceanTheme.mediumBlue
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            // 珊瑚圖案
            VStack(spacing: -8) {
                HStack(spacing: -10) {
                    Image(systemName: "leaf.fill")
                        .rotationEffect(.degrees(45))
                    Image(systemName: "leaf.fill")
                        .rotationEffect(.degrees(-45))
                }
                Image(systemName: "leaf.fill")
                    .rotationEffect(.degrees(180))
            }
            .font(.system(size: 60, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        Color(hex: "FF9B71"),
                        Color(hex: "FF7D5C")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            // 氣泡效果
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: CGFloat([10, 15, 8][index]))
                    .offset(
                        x: CGFloat([-25, 20, 30][index]),
                        y: CGFloat([-30, -40, -20][index])
                    )
            }
        }
        .frame(width: 1024, height: 1024)
        .clipShape(RoundedRectangle(cornerRadius: 224))
    }
}

#Preview {
    AppIcon()
        .frame(width: 120, height: 120)
} 