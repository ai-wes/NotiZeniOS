import SwiftUI
import Foundation

// Simple WatchAppState for testing
class WatchAppState: ObservableObject {
    @Published var shouldShowDigestPreviewSheet = false
    
    init() {
        print("WatchAppState initialized")
    }
}