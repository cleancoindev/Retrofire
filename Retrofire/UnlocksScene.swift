//
//  UnlocksScene.swift
//  Retrofire
//
//  Created by Theo Turner on 15/09/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import SpriteKit

class UnlocksScene: SKScene {
    
    var sand:SKEmitterNode!
    var oneNode:SKSpriteNode!
    var twoNode:SKSpriteNode!
    var threeNode:SKSpriteNode!
    var fourNode:SKSpriteNode!
    var fiveNode:SKSpriteNode!
    var sixNode:SKSpriteNode!
    var oneButtonNode:SKSpriteNode!
    var twoButtonNode:SKSpriteNode!
    var threeButtonNode:SKSpriteNode!
    var fourButtonNode:SKSpriteNode!
    var fiveButtonNode:SKSpriteNode!
    var sixButtonNode:SKSpriteNode!
    var menuButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        let userDefaults = UserDefaults.standard
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.advanceSimulationTime(25)
        
        oneNode = self.childNode(withName: "one") as! SKSpriteNode
        oneNode.texture = SKTexture(imageNamed: "player-1")
        oneNode.texture!.filteringMode = .nearest
        oneNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.85 * self.size.height)
        oneNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.19375 * self.size.width)
        twoNode = self.childNode(withName: "two") as! SKSpriteNode
        twoNode.texture = SKTexture(imageNamed: "player-2")
        twoNode.texture!.filteringMode = .nearest
        twoNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.85 * self.size.height)
        twoNode.size = CGSize(width: 0.09375 * self.size.width, height: 0.175 * self.size.width)
        threeNode = self.childNode(withName: "three") as! SKSpriteNode
        threeNode.texture = SKTexture(imageNamed: "player-3")
        threeNode.texture!.filteringMode = .nearest
        threeNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.65 * self.size.height)
        threeNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        fourNode = self.childNode(withName: "four") as! SKSpriteNode
        fourNode.texture = SKTexture(imageNamed: "player-4")
        fourNode.texture!.filteringMode = .nearest
        fourNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.65 * self.size.height)
        fourNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.1625 * self.size.width)
        fiveNode = self.childNode(withName: "five") as! SKSpriteNode
        fiveNode.texture = SKTexture(imageNamed: "player-5")
        fiveNode.texture!.filteringMode = .nearest
        fiveNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.45 * self.size.height)
        fiveNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        sixNode = self.childNode(withName: "six") as! SKSpriteNode
        sixNode.texture = SKTexture(imageNamed: "player-6")
        sixNode.texture!.filteringMode = .nearest
        sixNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.45 * self.size.height)
        sixNode.size = CGSize(width: 0.0875 * self.size.width, height: 0.14375 * self.size.width)
        
        oneButtonNode = self.childNode(withName: "oneButton") as! SKSpriteNode
        oneButtonNode.texture = SKTexture(imageNamed: "goButton")
        oneButtonNode.texture!.filteringMode = .nearest
        oneButtonNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.75 * self.size.height)
        oneButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        twoButtonNode = self.childNode(withName: "twoButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 1000 ? (twoButtonNode.texture = SKTexture(imageNamed: "goButton")) : (twoButtonNode.texture = SKTexture(imageNamed: "unlock-2"))
        twoButtonNode.texture!.filteringMode = .nearest
        twoButtonNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.75 * self.size.height)
        twoButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        threeButtonNode = self.childNode(withName: "threeButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 2500 ? (threeButtonNode.texture = SKTexture(imageNamed: "goButton")) : (threeButtonNode.texture = SKTexture(imageNamed: "unlock-3"))
        threeButtonNode.texture!.filteringMode = .nearest
        threeButtonNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.55 * self.size.height)
        threeButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fourButtonNode = self.childNode(withName: "fourButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 5000 ? (fourButtonNode.texture = SKTexture(imageNamed: "goButton")) : (fourButtonNode.texture = SKTexture(imageNamed: "unlock-4"))
        fourButtonNode.texture!.filteringMode = .nearest
        fourButtonNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.55 * self.size.height)
        fourButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fiveButtonNode = self.childNode(withName: "fiveButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 8000 ? (fiveButtonNode.texture = SKTexture(imageNamed: "goButton")) : (fiveButtonNode.texture = SKTexture(imageNamed: "unlock-5"))
        fiveButtonNode.texture!.filteringMode = .nearest
        fiveButtonNode.position = CGPoint(x: 0.225 * self.size.width, y: 0.35 * self.size.height)
        fiveButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        sixButtonNode = self.childNode(withName: "sixButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 10000 ? (sixButtonNode.texture = SKTexture(imageNamed: "goButton")) : (sixButtonNode.texture = SKTexture(imageNamed: "unlock-6"))
        sixButtonNode.texture!.filteringMode = .nearest
        sixButtonNode.position = CGPoint(x: 0.775 * self.size.width, y: 0.35 * self.size.height)
        sixButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        
        menuButtonNode = self.childNode(withName: "menuButton") as! SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "menuButton")
        menuButtonNode.texture!.filteringMode = .nearest
        menuButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.2 * self.size.height)
        menuButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        
        /*let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.texture = SKTexture(imageNamed: "hard")
            difficultyLabelNode.texture!.filteringMode = .nearest
        }
        else {
            difficultyLabelNode.texture = SKTexture(imageNamed: "easy")
            difficultyLabelNode.texture!.filteringMode = .nearest
        }*/
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "menuButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let controlsScene = ControlsScene(fileNamed: "MenuScene")
                self.view?.presentScene(controlsScene!, transition: transition)
            }
            /*else if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }*/
        }
        
    }
    
    /*func changeDifficulty() {
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.texture = SKTexture(imageNamed: "easy")
            difficultyLabelNode.texture!.filteringMode = .nearest
            userDefaults.set(false, forKey: "hard")
        }
        else {
            difficultyLabelNode.texture = SKTexture(imageNamed: "hard")
            difficultyLabelNode.texture!.filteringMode = .nearest
            userDefaults.set(true, forKey: "hard")
        }
        
        userDefaults.synchronize()
        
    }*/
    
}
