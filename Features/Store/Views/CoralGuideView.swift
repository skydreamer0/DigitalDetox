import SwiftUI

struct CoralGuideView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CoralGuideViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.guides) { guide in
                        CoralGuideCard(guide: guide)
                    }
                }
                .padding()
            }
            .navigationBarSetup(title: "Earn Coral Coins")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
} 