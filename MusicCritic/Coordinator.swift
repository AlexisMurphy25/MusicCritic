// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  Coordinator.swift
//

import SwiftUI

// a delegate for UIImagePickerController
class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let parent: ImagePicker
        
    init(_ parent: ImagePicker) {
        self.parent = parent
        super.init()
    }
    
    // handles when user picks an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            parent.selectedImage = pickedImage
        }
        parent.isPresented = false
    }
}

