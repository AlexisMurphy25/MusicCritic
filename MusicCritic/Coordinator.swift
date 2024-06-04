// Alexis Murphy
// App Name: Music Critic
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

