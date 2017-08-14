//
//  MenuScene.swift
//  Retrofire
//
//  Created by Theo Turner on 08/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

// FOR SCALING: DEFINE POSITIONS OF ITEMS BY CODE IN TERMS OF SCREEN PROPORTIONS

import SpriteKit

class MenuScene: SKScene {
    
    var sand:SKEmitterNode!
    var titleNode:SKSpriteNode!
    var newGameButtonNode:SKSpriteNode!
    var difficultyButtonNode:SKSpriteNode!
    var difficultyLabelNode:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.advanceSimulationTime(25)
        
        titleNode = self.childNode(withName: "title") as! SKSpriteNode
        titleNode.texture = SKTexture(imageNamed: "title")
        titleNode.texture!.filteringMode = .nearest
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "newGameButton")
        newGameButtonNode.texture!.filteringMode = .nearest
        difficultyButtonNode = self.childNode(withName: "difficultyButton") as! SKSpriteNode
        difficultyButtonNode.texture = SKTexture(imageNamed: "difficultyButton")
        difficultyButtonNode.texture!.filteringMode = .nearest
        difficultyLabelNode = self.childNode(withName: "difficultyLabel") as! SKLabelNode
        
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.text = "Hard"
        }
        else {
            difficultyLabelNode.text = "Easy"
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
        
        if difficultyLabelNode.text == "Easy" {
            difficultyLabelNode.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        }
        else {
            difficultyLabelNode.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
        
        userDefaults.synchronize()
        
    }
    
}
