// Alexis Murphy
// App Name: Music Critic
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
