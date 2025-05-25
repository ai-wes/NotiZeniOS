import SwiftUI

struct SettingsMenuView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
            Text("Coming Soon...")
                .font(.caption)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsMenuView()
}