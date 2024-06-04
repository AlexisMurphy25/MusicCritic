// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  ImagePicker.swift
//

import SwiftUI

// uses UIViewControllerRepresentable to allow Swift UI to use UIKit's image picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isPresented: Bool
    
    // creates UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    // creates a coordinator for communication between SwiftUI and the UIImagePickerController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // no updates handled here
    }
    
}
