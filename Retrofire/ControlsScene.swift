//
//  ControlsScene.swift
//  Retrofire
//
//  Created by Theo Turner on 11/09/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import SpriteKit

class ControlsScene: SKScene {
    
    var sand:SKEmitterNode!
    var controlsNode:SKSpriteNode!
    var menuButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(red: 230.0/255.0, green: 220.0/255.0, blue:175.0/255.0, alpha: 0)
        
        sand = self.childNode(withName: "sand") as! SKEmitterNode
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.advanceSimulationTime(25)
        controlsNode = self.childNode(withName: "controls") as! SKSpriteNode
        controlsNode.texture = SKTexture(imageNamed: "controls")
        controlsNode.texture!.filteringMode = .nearest
        controlsNode.position = CGPoint(x: 0.5 * self.size.width, y: 0.6 * self.size.height)
        controlsNode.size = CGSize(width: 0.8 * self.size.width, height: 0.8 * self.size.width )
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
            if node[0].name == "menuButton" {
                self.run(SKAction.playSoundFileNamed("tap", waitForCompletion: false))
                let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                transition.pausesOutgoingScene = false
                transition.pausesIncomingScene = false
                let menuScene = MenuScene(fileNamed: "MenuScene")
                self.view?.presentScene(menuScene!, transition: transition)
            }
        }
        
    }
    
}

