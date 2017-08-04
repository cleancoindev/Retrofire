//
//  GameScene.swift
//  Retrofire
//
//  Created by Theo Turner on 04/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sand:SKEmitterNode!
    var player:SKSpriteNode!
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        sand = SKEmitterNode(fileNamed: "Sand")
        sand.position = CGPoint(x:0, y: 0.9 * self.size.height) // CHANGE BASED ON ANCHOR POINT
        sand.advanceSimulationTime(20)
        self.addChild(sand)
        
        sand.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player-green")
        player.texture!.filteringMode = .nearest // MUST SET FOR SCENERY ALSO FOR PIXELLATED LOOK
        player.setScale(10)
        
        // ANCHOR POINT IN GameScene.sks DETERMINES PLAYER POSITION
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -0.35 * self.size.width, y: 0.85 * self.size.height) // CHANGE APPROPRIATELY
        scoreLabel.fontName = "AmericanTypewriter-Bold" // CHANGE APPROPRIATELY
        scoreLabel.fontSize = 36 // CHANGE APPROPRIATELY
        scoreLabel.fontColor = UIColor.black // MAYBE DON'T NEED LINE - DEFAULT IS BLACK?
        score = 0
        
        self.addChild(scoreLabel)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
