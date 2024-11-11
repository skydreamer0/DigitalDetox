import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    SettingsSection(title: "General") {
                        SettingsCard(
                            icon: "gearshape.fill",
                            title: "App Settings",
                            description: "Customize your experience"
                        )
                        
                        SettingsCard(
                            icon: "bell.fill",
                            title: "Notifications",
                            description: "Manage your alerts"
                        )
                    }
                    
                    SettingsSection(title: "Account") {
                        SettingsCard(
                            icon: "person.fill",
                            title: "Profile",
                            description: "View and edit your profile"
                        )
                        
                        SettingsCard(
                            icon: "lock.fill",
                            title: "Privacy",
                            description: "Manage privacy settings"
                        )
                    }
                    
                    SettingsSection(title: "Support") {
                        SettingsCard(
                            icon: "questionmark.circle.fill",
                            title: "Help Center",
                            description: "Get support and FAQ"
                        )
                        
                        SettingsCard(
                            icon: "info.circle.fill",
                            title: "About",
                            description: "App version and info"
                        )
                    }
                }
                .padding(.top)
            }
            .oceanBackground()
            .navigationBarSetup(title: "Ocean Settings")
        }
    }
}

private struct SettingsSection: View {
    let title: String
    let content: () -> any View
    
    init(title: String, @ViewBuilder content: @escaping () -> any View) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.oceanTheme.coral)
                .padding(.horizontal)
            
            AnyView(content())
        }
    }
}

private struct SettingsCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        NavigationLink {
            Text(title)
                .oceanBackground()
                .navigationBarSetup(title: title)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(Color.oceanTheme.coral)
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color.oceanTheme.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.oceanTheme.textSecondary)
                }
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(Color.oceanTheme.textSecondary)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.oceanTheme.deepBlue.opacity(0.6))
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    SettingsView()
} 