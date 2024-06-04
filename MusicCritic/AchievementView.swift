// Alexis Murphy
// App Name: Music Critic
//
//  AchievementView.swift
//

import SwiftUI

// view for achievement under the bar graph
struct AchievementView: View {
    var achievement: Achievement

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // achievement title
                Text(achievement.title)
                    .font(.headline)
                // achievement description
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            // determines if achieved
            // if so it has a green circle with a check icon
            // if not it has a red circle with an x icon
            Image(systemName: achievement.achieved ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(achievement.achieved ? .green : .red)
        }
        .padding()
    }
}
