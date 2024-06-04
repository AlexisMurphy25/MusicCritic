// Alexis Murphy
// App Name: Music Critic
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
