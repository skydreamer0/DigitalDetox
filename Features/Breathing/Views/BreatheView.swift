import SwiftUI

struct BreatheView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = BreatheSessionViewModel()
    let selectedPattern: BreathingPattern
    
    private var timeForCurrentPhase: TimeInterval {
        switch viewModel.currentPhase {
        case .inhale:
            return selectedPattern.inhaleTime
        case .hold:
            return selectedPattern.holdTime
        case .exhale:
            return selectedPattern.exhaleTime
        case .rest:
            return 2.0
        }
    }
    
    var body: some View {
        BreatheAnimationView(
            phase: viewModel.currentPhase,
            isBreathing: viewModel.isBreathing,
            progress: viewModel.progress,
            timeRemaining: timeForCurrentPhase,
            onStart: { viewModel.startBreathing() },
            onPause: { viewModel.pauseBreathing() },
            onStop: {
                viewModel.stopBreathing()
                dismiss()
            }
        )
        .onAppear {
            viewModel.updatePattern(selectedPattern)
        }
        .background(Color(UIColor.systemBackground))
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    BreatheView(selectedPattern: .defaultPattern)
} 