//
//  GameOverScene.swift
//  Retrofire
//
//  Created by Theo Turner on 08/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

// FOR SCALING: DEFINE SIZE OF ITEMS BY CODE IN TERMS OF SCREEN PROPORTIONS

import SpriteKit

class GameOverScene: SKScene {
    
    var sand:SKEmitterNode!
    var gameOver:SKSpriteNode!
    var scoreText:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var score:Int = 0
    var newGameButtonNode:SKSpriteNode!
    
    override func didMove(to view:SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.advanceSimulationTime(25)
        gameOver = self.childNode(withName: "gameOver") as! SKSpriteNode
        gameOver.texture = SKTexture(imageNamed: "gameOver")
        gameOver.texture!.filteringMode = .nearest
        gameOver.position = CGPoint(x: 0.5 * self.size.width, y: 0.8 * self.size.height)
        gameOver.size = CGSize(width: 0.8 * self.size.width, height: 0.0625 * self.size.width)
        scoreText = self.childNode(withName: "scoreText") as! SKSpriteNode
        scoreText.texture = SKTexture(imageNamed: "scoreText")
        scoreText.texture!.filteringMode = .nearest
        scoreText.position = CGPoint(x: 0.5 * self.size.width, y: 0.625 * self.size.height)
        scoreText.size = CGSize(width: 0.3625 * self.size.width, height: 0.0625 * self.size.width)
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        scoreLabel.position = CGPoint(x: 0.5 * self.size.width, y: 0.54 * self.size.height)
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        newGameButtonNode.texture!.filteringMode = .nearest
        newGameButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.415 * self.size.height)
        newGameButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        
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
