import SwiftUI

struct WatchDashboardView: View {
    var body: some View {
        VStack {
            Text("Watch Dashboard")
                .font(.title)
            Text("Coming Soon...")
                .font(.caption)
        }
        .navigationTitle("Dashboard")
    }
}

#Preview {
    WatchDashboardView()
}