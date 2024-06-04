// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  ReviewManager.swift
//
import Foundation
import UIKit

// manages album reviews and achievements through codable
class ReviewManager: ObservableObject {
    
    // stores album reviews
    var reviews: [AlbumReview] = []
    var myReviews: [AlbumReview] {
        get {
            return reviews
        }
        set(newReviews) {
            objectWillChange.send()
            reviews = newReviews
            saveReviews()
        }
    }
    
    // stores achievements
    var achievements: [Achievement] = []
    var myAchievements: [Achievement] {
        get {
            return achievements
        }
        set {
            objectWillChange.send()
            achievements = newValue
        }
    }
    
    // loads existing reviews
    init() {
        loadReviews()
        loadReviews()
        loadAchievements()
    }
    
    // calculates distribution of ratings
    func ratingDistribution() -> [CGFloat] {
        var distribution = [Int](repeating: 0, count: 5)
        for review in reviews {
            if review.rating >= 1 && review.rating <= 5 {
                distribution[review.rating - 1] += 1
            }
        }
        let totalReviews = distribution.reduce(0, +)
        return distribution.map { CGFloat($0) / CGFloat(totalReviews) }
    }
    
    // directory
    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // URL for reviews
    private var archiveURL: URL {
        documentsDirectory.appendingPathComponent("reviews.plist")
    }
    
    // loads reviews from persistent storage
    func loadReviews() {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: archiveURL)
            reviews = try decoder.decode([AlbumReview].self, from: data)
            objectWillChange.send()
        } catch {
            print("Error loading reviews: \(error)")
            reviews = []
        }
        updateAchievements()
        saveAchievements()
    }
    
    // saves reviews to persistent storage
    func saveReviews() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(reviews)
            try data.write(to: archiveURL, options: .atomic)
        } catch {
            print("Error saving reviews: \(error)")
        }
    }
    
    // adds new review and saves
    func addReview(_ review: AlbumReview) {
        objectWillChange.send()
        let newId = (reviews.map { $0.id }.max() ?? 0) + 1
        var newReview = review
        newReview.id = newId
        reviews.append(newReview)
        saveReviews()
        updateAchievements()
        saveAchievements()
    }
    
    
    // removes review by its id and saves
    func removeReview(withId id: Int) {
        objectWillChange.send()
        reviews.removeAll { $0.id == id }
        saveReviews()
        updateAchievements()
        saveAchievements()
    }
    
    // image URL
    private var imageCounterURL: URL {
        return documentsDirectory.appendingPathComponent("imageCounter.plist")
    }
    
    // loads image counter from storage
    func loadImageCounter() -> Int {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: imageCounterURL)
            let imageCounter = try decoder.decode(ImageCounter.self, from: data)
            return imageCounter.count
        } catch {
            print("Error loading image counter: \(error)")
            return 0
        }
    }
    
    // saves an image to persistent storage
    func saveImageCounter(_ count: Int) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(ImageCounter(count: count))
            try data.write(to: imageCounterURL, options: .atomic)
        } catch {
            print("Error saving image counter: \(error)")
        }
    }
    
    // save image to document directory
    func saveImage(_ image: UIImage) -> String? {
        let currentCount = loadImageCounter()
        saveImageCounter(currentCount + 1)
        let filename = "image_\(currentCount + 1).jpg"
        let path = documentsDirectory.appendingPathComponent(filename)
        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
                try data.write(to: path, options: .atomic)
                return filename
            } catch {
                print("Error saving image: \(error)")
                return nil
            }
        }
        return nil
    }
    
    // calculates which achievements have been earned based on criteria of amount of reviews and type of rating.
    func updateAchievements() {
        let totalReviews = reviews.count
        let highRatingCount = reviews.filter { $0.rating == 5 }.count
        let toughCriticCount = reviews.filter { $0.rating <= 2 }.count
        let ratingsSet = Set(reviews.map { $0.rating })
        let diverseRatingsAchieved = ratingsSet.count == 5
        
        achievements = [
            Achievement(id: 1, title: "Beginner", description: "1 review", achieved: totalReviews >= 1),
            Achievement(id: 2, title: "Acclaimed", description: "10 reviews", achieved: totalReviews >= 10),
            Achievement(id: 3, title: "Master", description: "50 reviews", achieved: totalReviews >= 50),
            Achievement(id: 4, title: "Aficionado", description: "100 reviews", achieved: totalReviews >= 100),
            Achievement(id: 5, title: "Anthony Fantano?", description: "500 reviews", achieved: totalReviews >= 500),
            Achievement(id: 6, title: "Tough Crowd", description: "10 reviews with a rating of 2 or less", achieved: toughCriticCount >= 10),
            Achievement(id: 7, title: "Five Stars All Around", description: "five 5-star reviews", achieved: highRatingCount >= 5),
            Achievement(id: 8, title: "Diverse Reviewer", description: "have reviews with each possible rating", achieved: diverseRatingsAchieved)
            
        ]
    }
    
    // URL for storing achievements
    private var achievementsURL: URL {
        documentsDirectory.appendingPathComponent("achievements.plist")
    }
    
    // saves current achievements to persistent storage
    func saveAchievements() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(achievements)
            try data.write(to: achievementsURL, options: .atomic)
        } catch {
            print("Error saving achievements: \(error)")
        }
    }
    
    // load achievements from persistent storage
    func loadAchievements() {
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: achievementsURL)
            achievements = try decoder.decode([Achievement].self, from: data)
        } catch {
            print("Error loading achievements: \(error)")
            updateAchievements()
            saveAchievements()
        }
        
    }
    // saves rearrangement of reviews
    func moveReview(from source: IndexSet, to destination: Int) {
            objectWillChange.send()
            reviews.move(fromOffsets: source, toOffset: destination)
            saveReviews()
    }
}
