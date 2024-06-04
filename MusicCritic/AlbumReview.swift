// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  AlbumReview.swift
//

import Foundation

// used to store details about an album review
struct AlbumReview: Codable, Hashable {
    var id: Int
    var title: String
    var rating: Int
    var thoughts: String
    var imageName: String
}
