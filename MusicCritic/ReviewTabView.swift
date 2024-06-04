// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  ReviewTabView.swift
//

import SwiftUI

// structure the view for the review tab
struct ReviewTabView: View {
    @ObservedObject var reviewManager: ReviewManager
    @State private var title = ""
    @State private var rating = 3
    @State private var thoughts = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack(alignment: .center) {
                        // displays image or blank placeholder if one has not been chosen
                        PlaceholderView(selectedImage: selectedImage)
                            .frame(width: 125, height: 150)
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.vertical, 8)
                    }
                    // button to add image
                    Button("Select Image") {
                        showingImagePicker = true
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.indigo)
                    .cornerRadius(8)
                    
                    Group {
                        // adds and labels album title text field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Album").foregroundColor(.black)
                            TextField("Album Title", text: $title)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(5)
                        }
                        // adds a segment picker for rating out of five
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Rate").foregroundColor(.black)
                            Picker("Rating", selection: $rating) {
                                ForEach(1...5, id: \.self) { Text("\($0)") }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.vertical, 8)
                            .background(Color.indigo)
                            .cornerRadius(8)
                        }
                        // adds and labels thoughts text field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Thoughts").foregroundColor(.black)
                            TextField("Your Thoughts", text: $thoughts)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(5)
                        }
                    }
                    // sets backgound to white
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    
                    // adds title of tab at the top
                    .navigationTitle("Review")
                    .navigationBarTitleDisplayMode(.inline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // adds submit button at the bottom
                    Button("Submit") {
                        submitReview()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(isFormValid ? Color.indigo : Color.gray)
                    .cornerRadius(8)
                    .disabled(!isFormValid)
                }
                .padding()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $selectedImage, isPresented: $showingImagePicker)
            }
        }
    }
    // checks if all fields have input
    private var isFormValid: Bool {
        !(title.isEmpty || thoughts.isEmpty || selectedImage == nil)
    }
    // adds review to review manager
    private func submitReview() {
        var imageName: String? = nil
        if let selectedImage = selectedImage {
            imageName = reviewManager.saveImage(selectedImage)
        }
        let newReview = AlbumReview(id: 0, title: title, rating: rating, thoughts: thoughts, imageName: imageName ?? "")
        reviewManager.addReview(newReview)
        resetForm()
    }
    // what the values are set to after clicking submit
    private func resetForm() {
        title = ""
        rating = 3
        thoughts = ""
        selectedImage = nil
    }
}
