// Alexis Murphy
// App Name: Music Critic
//
// MusicCriticApp.swift
//

import SwiftUI

// main entry point
@main
struct MusicCriticApp: App {
    var reviewManager = ReviewManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                // library view
                LibraryView(reviewManager: reviewManager)
                    .tabItem {
                        // library view tab
                        Label("Library", systemImage: "list.dash")
                    }
                // review view
                ReviewTabView(reviewManager: reviewManager)
                    .tabItem {
                        // review view tab
                        Label("Review", systemImage: "square.and.pencil")
                    }
                // insights view
                MusicInsightsTabView(reviewManager: reviewManager)
                    .tabItem {
                        // insights view tab
                        Label("Insights", systemImage: "eye")
                }
            }
        }
    }
}
