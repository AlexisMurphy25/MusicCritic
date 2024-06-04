// Alexis Murphy
// App Name: Music Critic
//
// LibraryView.swift
//

import SwiftUI

// shows a list of reviews submitted in the review tab
struct LibraryView: View {
    @ObservedObject var reviewManager: ReviewManager

    var body: some View {
        NavigationView {
            List {
                // loops through each review
                ForEach(reviewManager.reviews.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            // album title
                            Text(reviewManager.reviews[index].title)
                                .foregroundColor(.white)
                                .font(.headline)
                            // rating
                            Text("Rating: \(reviewManager.reviews[index].rating)/5")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            // thoughts
                            Text(reviewManager.reviews[index].thoughts)
                                .foregroundColor(.white)
                                .font(.body)
                        }
                        Spacer()
                        // image
                        if let image = loadImage(named: reviewManager.reviews[index].imageName) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .listRowBackground(Color.indigo)
                }
                // functionality on moving and deleting tiems in the list
                .onDelete(perform: deleteReview)
                .onMove(perform: moveReview)
            }
            // title displayed at the top before the list
            .navigationTitle("Review Library")
        }
    }
    
    // gets the image from documents directory
    private func loadImage(named imageName: String) -> UIImage? {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        let imagePath = documentsDirectory.appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath.path), let image = UIImage(contentsOfFile: imagePath.path) {
            return image
        }
        return nil
    }
    
    // URL of documents directory
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    // removes a review
    private func deleteReview(at offsets: IndexSet) {
        for index in offsets {
            let reviewId = reviewManager.reviews[index].id
            reviewManager.removeReview(withId: reviewId)
        }
    }
    // handles reordering of reviews when user moves them in a list
    private func moveReview(from source: IndexSet, to destination: Int) {
            reviewManager.moveReview(from: source, to: destination)
    }
}
