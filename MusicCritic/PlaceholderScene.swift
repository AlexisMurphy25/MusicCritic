// Alexis Murphy alenmurp@iu.edu
// Briana Flores briflore@iu.edu
// App Name: Music Critic
// Submission Date: 4/24/2024
//
//  PlaceHolderScene.swift
//

import SpriteKit
// chose SpriteKit for one of the frameworks to create moving album image in review tab when the user selects an album

class PlaceholderScene: SKScene {
    var contentNode: SKSpriteNode?
    
    // called when scene is presented by a view to initialize it
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        setupPlaceholder()
    }
    
    
    func setupPlaceholder(withImage image: UIImage? = nil) {
        contentNode?.removeFromParent()
        
        if let image = image {
            let texture = SKTexture(image: image)
            contentNode = SKSpriteNode(texture: texture)
            let aspectRatio = image.size.width / image.size.height
            var nodeWidth = 125.0
            var nodeHeight = 125.0
            if aspectRatio > 1 {
                nodeHeight = nodeWidth / aspectRatio
            } else {
                nodeWidth = nodeHeight * aspectRatio
            }
            contentNode?.size = CGSize(width: nodeWidth, height: nodeHeight)
        } else {
            // makes the animation not visible by making it white if no image is provided yet
            contentNode = SKSpriteNode(color: .white, size: CGSize(width: 125, height: 125))
        }
        
        guard let contentNode = contentNode else { return }
            contentNode.position = CGPoint(x: frame.midX, y: frame.midY - 10)
            addChild(contentNode)
        
        // action sequence that allows the image to move up and down continuously
        let moveUp = SKAction.moveBy(x: 0, y: 20, duration: 1)
        let moveDown = moveUp.reversed()
        let sequence = SKAction.sequence([moveUp, moveDown])
        let repeatAction = SKAction.repeatForever(sequence)
        contentNode.run(repeatAction)
    }
}
