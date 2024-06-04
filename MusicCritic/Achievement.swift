// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  Achievement.swift
//

import Foundation

// used to store details about an achievement
struct Achievement: Codable, Hashable {
    var id: Int
    var title: String
    var description: String
    var achieved: Bool
}
