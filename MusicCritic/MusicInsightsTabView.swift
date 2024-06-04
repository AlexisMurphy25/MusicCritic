// Alexis Murphy
// App Name: Music Critic
//
//  MusicInsightsTabView.swift
//

import SwiftUI

// structures the view for the insights tab
struct MusicInsightsTabView: View {
    @ObservedObject var reviewManager: ReviewManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // bar graph and title
                    Text("Distribution of Ratings")
                        .font(.headline)
                        .padding(.top)
                    BarGraphView(ratingsProportions: reviewManager.ratingDistribution())
                        .frame(height: 220)
                    
                    // achievements section
                    Text("Achievements")
                        .font(.headline)
                        .padding([.top, .bottom])
                    ForEach(reviewManager.achievements, id: \.id) { achievement in
                        AchievementView(achievement: achievement)
                    }
                }
                .padding()
            }
            // tab title
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
