//
//  NewNotizenWatchAppApp.swift
//  NewNotizenWatchApp Watch App
//
//  Created by Wesley Lagarde on 5/25/25.
//

import SwiftUI

@main
struct NewNotizenWatchApp_Watch_AppApp: App {
    @StateObject private var appState = WatchAppState() // Create and manage the app state

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState) // Inject into the environment
        }
    }
}