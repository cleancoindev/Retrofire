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
    
    var gameTimer:Timer!
    
    var possibleScenery = ["destructible-1", "destructible-2", "destructible-3", "destructible-4", "destructible-5", "destructible-6", "indestructible-1", "indestructible-2", "indestructible-3", "indestructible-4"]
    
    let sceneryCategory:UInt32 = 0x1 << 1 // gives each category a unique identifier to detect collisions
    let tankShellCategory:UInt32 = 0x1 << 0 // diff type of bit shift
    
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
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addScenery), userInfo: nil, repeats: true)
        
        }
    
    func addScenery () {
        possibleScenery = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleScenery) as! [String]
        let scenery = SKSpriteNode(imageNamed: possibleScenery[0])
        scenery.texture!.filteringMode = .nearest
        scenery.setScale(6)
        let generatePosition = GKRandomDistribution(lowestValue: -Int(self.size.width) / 2, highestValue: Int(self.size.width) / 2) // check if works
        let position = CGFloat(generatePosition.nextInt())
        scenery.position = CGPoint(x: position, y: 0.9 * self.size.height + scenery.size.height) //gen on screen? maybe remove +
        scenery.physicsBody = SKPhysicsBody(rectangleOf: scenery.size)
        scenery.physicsBody?.isDynamic = true
        
        scenery.physicsBody?.categoryBitMask = sceneryCategory
        scenery.physicsBody?.contactTestBitMask = tankShellCategory
        scenery.physicsBody?.collisionBitMask = 0
        
        self.addChild(scenery)
        
        let animationDuration:TimeInterval = 10 // MAKE RANDOM TO MAKE GAME MORE DIFFICULT, DECREASE FOR HIGHER DIFFICULTY. MUST MATCH BACKGROUND SPEED: animationDuration 10 == Sand.sks speed 152.8
        
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -0.1 * self.size.height - scenery.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent()) // removes to prevent constantly adding more to memory - look at number of nodes
        
        scenery.run(SKAction.sequence(actionArray))
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
