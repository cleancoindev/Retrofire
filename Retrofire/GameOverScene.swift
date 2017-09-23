//
//  GameOverScene.swift
//  Retrofire
//
//  Created by Theo Turner on 08/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var sand:SKEmitterNode!
    var gameOver:SKSpriteNode!
    var scoreText:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var highScoreText:SKSpriteNode!
    var highScoreLabel:SKLabelNode!
    var score:Int = 0
    var newGameButtonNode:SKSpriteNode!
    var menuButtonNode:SKSpriteNode!
    
    override func didMove(to view:SKView) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showAd"), object: nil)
        
        self.backgroundColor = SKColor(red: 230.0/255.0, green: 220.0/255.0, blue:175.0/255.0, alpha: 0)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.integer(forKey: "highScore") < score {
            userDefaults.set(score, forKey: "highScore")
        }
        userDefaults.synchronize()
        
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
        scoreText.position = CGPoint(x: 0.5 * self.size.width, y: 0.7 * self.size.height)
        scoreText.size = CGSize(width: 0.3625 * self.size.width, height: 0.0625 * self.size.width)
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "\(score)"
        scoreLabel.position = CGPoint(x: 0.5 * self.size.width, y: 0.6195 * self.size.height)
        highScoreText = self.childNode(withName: "highScoreText") as! SKSpriteNode
        highScoreText.texture = SKTexture(imageNamed: "highScoreText")
        highScoreText.texture!.filteringMode = .nearest
        highScoreText.position = CGPoint(x: 0.5 * self.size.width, y: 0.55 * self.size.height)
        highScoreText.size = CGSize(width: 0.3625 * self.size.width, height: 0.1375 * self.size.width)
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.text = "\(userDefaults.integer(forKey: "highScore"))"
        highScoreLabel.position = CGPoint(x: 0.5 * self.size.width, y: 0.45 * self.size.height)
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        newGameButtonNode.texture!.filteringMode = .nearest
        newGameButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.35 * self.size.height)
        newGameButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        menuButtonNode = self.childNode(withName: "menuButton") as! SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "menuButton")
        menuButtonNode.texture!.filteringMode = .nearest
        menuButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.25 * self.size.height)
        menuButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        
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
            else if node[0].name == "menuButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
        
    }
    
}
