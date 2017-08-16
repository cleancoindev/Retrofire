//
//  MenuScene.swift
//  Retrofire
//
//  Created by Theo Turner on 08/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

// FOR SCALING: DEFINE SIZE OF ITEMS BY CODE IN TERMS OF SCREEN PROPORTIONS

import SpriteKit

class MenuScene: SKScene {
    
    var sand:SKEmitterNode!
    var titleNode:SKSpriteNode!
    var newGameButtonNode:SKSpriteNode!
    var difficultyButtonNode:SKSpriteNode!
    var difficultyLabelNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.advanceSimulationTime(25)
        titleNode = self.childNode(withName: "title") as! SKSpriteNode
        titleNode.texture = SKTexture(imageNamed: "title")
        titleNode.texture!.filteringMode = .nearest
        titleNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.8 * self.size.height)
        titleNode.size = CGSize(width: 0.8 * self.size.width, height: 0.0625 * self.size.width )
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        newGameButtonNode.texture!.filteringMode = .nearest
        newGameButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.585 * self.size.height)
        newGameButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        difficultyButtonNode = self.childNode(withName: "difficultyButton") as! SKSpriteNode
        difficultyButtonNode.texture = SKTexture(imageNamed: "difficultyButton")
        difficultyButtonNode.texture!.filteringMode = .nearest
        difficultyButtonNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.485 * self.size.height)
        difficultyButtonNode.size = CGSize(width: 0.8 * self.size.width, height: 0.1125 * self.size.width)
        difficultyLabelNode = self.childNode(withName: "difficultyLabel") as! SKSpriteNode
        difficultyLabelNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.4 * self.size.height)
        difficultyLabelNode.size = CGSize(width: 0.2875 * self.size.width, height: 0.0625 * self.size.width)
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.texture = SKTexture(imageNamed: "hard")
            difficultyLabelNode.texture!.filteringMode = .nearest
        }
        else {
            difficultyLabelNode.texture = SKTexture(imageNamed: "easy")
            difficultyLabelNode.texture!.filteringMode = .nearest
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
            else if nodesArray.first?.name == "difficultyButton" {
                changeDifficulty()
            }
        }
        
    }
    
    func changeDifficulty() {
        
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
        
    }
    
}
