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
        sand.zPosition = -1
        sand.advanceSimulationTime(25)
        oneNode = self.childNode(withName: "one") as! SKSpriteNode
        oneNode.texture = SKTexture(imageNamed: "player-1")
        oneNode.texture!.filteringMode = .nearest
        oneNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.875 * self.size.height)
        oneNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.19375 * self.size.width)
        twoNode = self.childNode(withName: "two") as! SKSpriteNode
        twoNode.texture = SKTexture(imageNamed: "player-2")
        twoNode.texture!.filteringMode = .nearest
        twoNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.875 * self.size.height)
        twoNode.size = CGSize(width: 0.09375 * self.size.width, height: 0.175 * self.size.width)
        threeNode = self.childNode(withName: "three") as! SKSpriteNode
        threeNode.texture = SKTexture(imageNamed: "player-3")
        threeNode.texture!.filteringMode = .nearest
        threeNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.625 * self.size.height)
        threeNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        fourNode = self.childNode(withName: "four") as! SKSpriteNode
        fourNode.texture = SKTexture(imageNamed: "player-4")
        fourNode.texture!.filteringMode = .nearest
        fourNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.625 * self.size.height)
        fourNode.size = CGSize(width: 0.10625 * self.size.width, height: 0.1625 * self.size.width)
        fiveNode = self.childNode(withName: "five") as! SKSpriteNode
        fiveNode.texture = SKTexture(imageNamed: "player-5")
        fiveNode.texture!.filteringMode = .nearest
        fiveNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.375 * self.size.height)
        fiveNode.size = CGSize(width: 0.11875 * self.size.width, height: 0.2 * self.size.width)
        sixNode = self.childNode(withName: "six") as! SKSpriteNode
        sixNode.texture = SKTexture(imageNamed: "player-6")
        sixNode.texture!.filteringMode = .nearest
        sixNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.375 * self.size.height)
        sixNode.size = CGSize(width: 0.0875 * self.size.width, height: 0.14375 * self.size.width)
        oneButtonNode = self.childNode(withName: "oneButton") as! SKSpriteNode
        userDefaults.integer(forKey: "player") == 1 ? (oneButtonNode.texture = SKTexture(imageNamed: "ticked")) : (oneButtonNode.texture = SKTexture(imageNamed: "goOneButton"))
        oneButtonNode.texture!.filteringMode = .nearest
        oneButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.775 * self.size.height)
        oneButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        twoButtonNode = self.childNode(withName: "twoButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 1000 ? (twoButtonNode.texture = SKTexture(imageNamed: "goTwoButton")) : (twoButtonNode.texture = SKTexture(imageNamed: "unlock-2"))
        userDefaults.integer(forKey: "player") == 2 ? twoButtonNode.texture = SKTexture(imageNamed: "ticked") : ()
        twoButtonNode.texture!.filteringMode = .nearest
        twoButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.775 * self.size.height)
        twoButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        threeButtonNode = self.childNode(withName: "threeButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 2500 ? (threeButtonNode.texture = SKTexture(imageNamed: "goThreeButton")) : (threeButtonNode.texture = SKTexture(imageNamed: "unlock-3"))
        userDefaults.integer(forKey: "player") == 3 ? threeButtonNode.texture = SKTexture(imageNamed: "ticked") : ()
        threeButtonNode.texture!.filteringMode = .nearest
        threeButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.525 * self.size.height)
        threeButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fourButtonNode = self.childNode(withName: "fourButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 5000 ? (fourButtonNode.texture = SKTexture(imageNamed: "goFourButton")) : (fourButtonNode.texture = SKTexture(imageNamed: "unlock-4"))
        userDefaults.integer(forKey: "player") == 4 ? fourButtonNode.texture = SKTexture(imageNamed: "ticked") : ()
        fourButtonNode.texture!.filteringMode = .nearest
        fourButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.525 * self.size.height)
        fourButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        fiveButtonNode = self.childNode(withName: "fiveButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 8000 ? (fiveButtonNode.texture = SKTexture(imageNamed: "goFiveButton")) : (fiveButtonNode.texture = SKTexture(imageNamed: "unlock-5"))
        userDefaults.integer(forKey: "player") == 5 ? fiveButtonNode.texture = SKTexture(imageNamed: "ticked") : ()
        fiveButtonNode.texture!.filteringMode = .nearest
        fiveButtonNode.position = CGPoint(x: 0.25 * self.size.width, y: 0.275 * self.size.height)
        fiveButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        sixButtonNode = self.childNode(withName: "sixButton") as! SKSpriteNode
        userDefaults.integer(forKey: "highScore") >= 10000 ? (sixButtonNode.texture = SKTexture(imageNamed: "goSixButton")) : (sixButtonNode.texture = SKTexture(imageNamed: "unlock-6"))
        userDefaults.integer(forKey: "player") == 6 ? sixButtonNode.texture = SKTexture(imageNamed: "ticked") : ()
        sixButtonNode.texture!.filteringMode = .nearest
        sixButtonNode.position = CGPoint(x: 0.75 * self.size.width, y: 0.275 * self.size.height)
        sixButtonNode.size = CGSize(width: 0.4 * self.size.width, height: 0.1125 * self.size.width)
        menuButtonNode = self.childNode(withName: "menuButton") as! SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "menuButton")
        menuButtonNode.texture!.filteringMode = .nearest
        menuButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.125 * self.size.height)
        menuButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        menuButtonNode.zPosition = -1
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let userDefaults = UserDefaults.standard
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "goOneButton" {
                oneButtonNode.texture = SKTexture(imageNamed: "ticked")
                oneButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(1, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "goTwoButton" {
                twoButtonNode.texture = SKTexture(imageNamed: "ticked")
                twoButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(2, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "goTheeButton" {
                threeButtonNode.texture = SKTexture(imageNamed: "ticked")
                threeButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(3, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "goFourButton" {
                fourButtonNode.texture = SKTexture(imageNamed: "ticked")
                fourButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(4, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "goFiveButton" {
                fiveButtonNode.texture = SKTexture(imageNamed: "ticked")
                fiveButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(5, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "goSixButton" {
                sixButtonNode.texture = SKTexture(imageNamed: "ticked")
                sixButtonNode.texture!.filteringMode = .nearest
                userDefaults.set(6, forKey: "player")
                userDefaults.synchronize()
            }
            else if nodesArray.first?.name == "menuButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
            
        }
        
    }
    
}
