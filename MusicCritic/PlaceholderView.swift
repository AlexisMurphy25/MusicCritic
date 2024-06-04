// Alexis Murphy
// App Name: Music Critic
//
//  SpriteKitContainer.swift
//

import SwiftUI
import SpriteKit

// swift UI wrapper to display SpriteKit scene
struct PlaceholderView: UIViewRepresentable {
    var selectedImage: UIImage?
    
    // transparent SKView created
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.allowsTransparency = true
        return view
    }
    
    // used to display new scene when needed
    func updateUIView(_ uiView: SKView, context: Context) {
        let scene = PlaceholderScene(size: uiView.bounds.size)
        scene.scaleMode = .resizeFill
        uiView.presentScene(scene)
        scene.setupPlaceholder(withImage: selectedImage)
    }
}

