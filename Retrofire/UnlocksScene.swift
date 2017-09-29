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
    var hsText:SKSpriteNode!
    var highScoreLabel:SKLabelNode!
    var menuButtonNode:SKSpriteNode!
    var unlocked:Int = 0
    var current:Int = 0
    var new:Int = 0
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(red: 230.0/255.0, green: 220.0/255.0, blue:175.0/255.0, alpha: 0)
        
        let userDefaults = UserDefaults.standard
        unlocked = userDefaults.integer(forKey: "highScore") / 2000
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.advanceSimulationTime(25)
        oneNode = self.childNode(withName: "one") as! SKSpriteNode
        oneNode.texture = SKTexture(imageNamed: "player-1")
        oneNode.texture!.filteringMode = .nearest
        oneNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.9 * self.size.height)
        oneNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.19375 * self.size.width)
        oneNode.zPosition = 1
        twoNode = self.childNode(withName: "two") as! SKSpriteNode
        twoNode.texture = SKTexture(imageNamed: "player-2")
        twoNode.texture!.filteringMode = .nearest
        twoNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.9 * self.size.height)
        twoNode.size = CGSize(width: 0.09375 * self.size.width, height: 0.175 * self.size.width)
        twoNode.zPosition = 1
        threeNode = self.childNode(withName: "three") as! SKSpriteNode
        threeNode.texture = SKTexture(imageNamed: "player-3")
        threeNode.texture!.filteringMode = .nearest
        threeNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.675 * self.size.height)
        threeNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        threeNode.zPosition = 1
        fourNode = self.childNode(withName: "four") as! SKSpriteNode
        fourNode.texture = SKTexture(imageNamed: "player-4")
        fourNode.texture!.filteringMode = .nearest
        fourNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.675 * self.size.height)
        fourNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.1625 * self.size.width)
        fourNode.zPosition = 1
        fiveNode = self.childNode(withName: "five") as! SKSpriteNode
        fiveNode.texture = SKTexture(imageNamed: "player-5")
        fiveNode.texture!.filteringMode = .nearest
        fiveNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.45 * self.size.height)
        fiveNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        fiveNode.zPosition = 1
        sixNode = self.childNode(withName: "six") as! SKSpriteNode
        sixNode.texture = SKTexture(imageNamed: "player-6")
        sixNode.texture!.filteringMode = .nearest
        sixNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.45 * self.size.height)
        sixNode.size = CGSize(width: 0.0875 * self.size.width, height: 0.14375 * self.size.width)
        sixNode.zPosition = 1
        oneButtonNode = self.childNode(withName: "oneButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 1 {
            oneButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 1
        }
        else {
            oneButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        oneButtonNode.texture!.filteringMode = .nearest
        oneButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.8 * self.size.height)
        oneButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        twoButtonNode = self.childNode(withName: "twoButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 2 {
            twoButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 2
        }
        else if unlocked >= 1 {
            twoButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        else {
            twoButtonNode.texture = SKTexture(imageNamed: "unlock-2")
        }
        twoButtonNode.texture!.filteringMode = .nearest
        twoButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.8 * self.size.height)
        twoButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        threeButtonNode = self.childNode(withName: "threeButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 3 {
            threeButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 3
        }
        else if unlocked >= 2 {
            threeButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        else {
            threeButtonNode.texture = SKTexture(imageNamed: "unlock-3")
        }
        threeButtonNode.texture!.filteringMode = .nearest
        threeButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.575 * self.size.height)
        threeButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fourButtonNode = self.childNode(withName: "fourButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 4 {
            fourButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 4
        }
        else if unlocked >= 3 {
            fourButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        else {
            fourButtonNode.texture = SKTexture(imageNamed: "unlock-4")
        }
        fourButtonNode.texture!.filteringMode = .nearest
        fourButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.575 * self.size.height)
        fourButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fiveButtonNode = self.childNode(withName: "fiveButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 5 {
            fiveButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 5
        }
        else if unlocked >= 4 {
            fiveButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        else {
            fiveButtonNode.texture = SKTexture(imageNamed: "unlock-5")
        }
        fiveButtonNode.texture!.filteringMode = .nearest
        fiveButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.35 * self.size.height)
        fiveButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        sixButtonNode = self.childNode(withName: "sixButton") as! SKSpriteNode
        if userDefaults.integer(forKey: "player") == 6 {
            sixButtonNode.texture = SKTexture(imageNamed: "ticked")
            current = 6
        }
        else if unlocked == 5 {
            sixButtonNode.texture = SKTexture(imageNamed: "goButton")
        }
        else {
            sixButtonNode.texture = SKTexture(imageNamed: "unlock-6")
        }
        sixButtonNode.texture!.filteringMode = .nearest
        sixButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.35 * self.size.height)
        sixButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.text = "HS  \(userDefaults.integer(forKey: "highScore"))"
        highScoreLabel.position = CGPoint(x: 0.5 * self.size.width, y: 0.235 * self.size.height)
        menuButtonNode = self.childNode(withName: "menuButton") as! SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "menuButton")
        menuButtonNode.texture!.filteringMode = .nearest
        menuButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.15 * self.size.height)
        menuButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let userDefaults = UserDefaults.standard
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "oneButton" && current != 1 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                oneButtonNode.texture = SKTexture(imageNamed: "ticked")
                oneButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(1, forKey: "player")
                new = 1
                untick()
            }
            else if nodesArray.first?.name == "twoButton" && unlocked >= 1 && current != 2 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                twoButtonNode.texture = SKTexture(imageNamed: "ticked")
                twoButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(2, forKey: "player")
                new = 2
                untick()
            }
            else if nodesArray.first?.name == "threeButton" && unlocked >= 2 && current != 3 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                threeButtonNode.texture = SKTexture(imageNamed: "ticked")
                threeButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(3, forKey: "player")
                new = 3
                untick()
            }
            else if nodesArray.first?.name == "fourButton" && unlocked >= 3 && current != 4 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                fourButtonNode.texture = SKTexture(imageNamed: "ticked")
                fourButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(4, forKey: "player")
                new = 4
                untick()
            }
            else if nodesArray.first?.name == "fiveButton" && unlocked >= 4 && current != 5 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                fiveButtonNode.texture = SKTexture(imageNamed: "ticked")
                fiveButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(5, forKey: "player")
                new = 5
                untick()
            }
            else if nodesArray.first?.name == "sixButton" && unlocked >= 5 && current != 6 {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                sixButtonNode.texture = SKTexture(imageNamed: "ticked")
                sixButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(6, forKey: "player")
                new = 6
                untick()
            }
            userDefaults.synchronize()
            if nodesArray.first?.name == "menuButton" {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
            
        }
        
    }
    
    func untick() {
        
        if current == 1 {
            oneButtonNode.texture = SKTexture(imageNamed: "goButton")
            oneButtonNode.texture!.filteringMode = .nearest
        }
        else if current == 2 {
            twoButtonNode.texture = SKTexture(imageNamed: "goButton")
            twoButtonNode.texture!.filteringMode = .nearest
        }
        else if current == 3 {
            threeButtonNode.texture = SKTexture(imageNamed: "goButton")
            threeButtonNode.texture!.filteringMode = .nearest
        }
        else if current == 4 {
            fourButtonNode.texture = SKTexture(imageNamed: "goButton")
            fourButtonNode.texture!.filteringMode = .nearest
        }
        else if current == 5 {
            fiveButtonNode.texture = SKTexture(imageNamed: "goButton")
            fiveButtonNode.texture!.filteringMode = .nearest
        }
        else if current == 6 {
            sixButtonNode.texture = SKTexture(imageNamed: "goButton")
            sixButtonNode.texture!.filteringMode = .nearest
        }
        current = new
        
    }
    
}
