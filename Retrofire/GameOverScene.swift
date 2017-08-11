//
//  GameOverScene.swift
//  Retrofire
//
//  Created by Theo Turner on 08/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

// FOR SCALING: DEFINE POSITIONS OF ITEMS BY CODE IN TERMS OF SCREEN PROPORTIONS

import SpriteKit

class GameOverScene: SKScene {
    
    var sand:SKEmitterNode!
    var score:Int = 0
    var scoreLabel:SKLabelNode!
    var newGameButtonNode:SKSpriteNode!
    
    override func didMove(to view:SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.advanceSimulationTime(25)
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let node = self.nodes(at: location)
            if node[0].name == "newGameButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
        
    }
    
}
