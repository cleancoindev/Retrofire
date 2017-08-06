//
//  GameScene.swift
//  Retrofire
//
//  Created by Theo Turner on 04/08/2017.
//  Copyright © 2017 Turner Dhir LLP. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

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
    
    let sceneryCategory:UInt32 = 0x1 << 1 // Bitshift allows easy unique identifiers
    let bulletCategory:UInt32 = 0x1 << 0 // Different shift to keep uniqueness
    
    let motionManager = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        // ANCHOR POINT IS CENTER BOTTOM (x: center, y: 0.1 * screen height)
        // Determines player position and is defined in GameScene.sks
        
        sand = SKEmitterNode(fileNamed: "Sand")
        sand.position = CGPoint(x:0, y: 0.9 * self.size.height)
        sand.advanceSimulationTime(20)
        self.addChild(sand)
        sand.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player-green")
        player.texture!.filteringMode = .nearest // For pixelated look
        player.setScale(10) // Must scale sprites after physicsBody declarations
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -0.35 * self.size.width, y: 0.85 * self.size.height) // Change as wanted
        scoreLabel.fontName = "AmericanTypewriter-Bold" // Change as wanted
        scoreLabel.fontSize = 36 // Change as wanted
        scoreLabel.fontColor = UIColor.black // Change as wanted - if white (default), remove line
        score = 0
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addScenery), userInfo: nil, repeats: true) // Frequency of adding scenery (time interval in seconds), increase for higher difficulty
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = 0.75 * CGFloat(acceleration.x) + 0.25 * self.xAcceleration // Change as wanted
            }
        }
        
        }
    
    func addScenery () {
        
        possibleScenery = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleScenery) as! [String]
        let scenery = SKSpriteNode(imageNamed: possibleScenery[0])
        
        let generatePosition = GKRandomDistribution(lowestValue: -Int(self.size.width) / 2, highestValue: Int(self.size.width) / 2)
        let position = CGFloat(generatePosition.nextInt())
        scenery.position = CGPoint(x: position, y: 0.9 * self.size.height + 6 * scenery.size.height) // Multiplied by 6 as this declaration before setting scenery scale to 6
        
        scenery.physicsBody = SKPhysicsBody(rectangleOf: scenery.size)
        scenery.physicsBody?.isDynamic = true
        scenery.physicsBody?.categoryBitMask = sceneryCategory
        scenery.physicsBody?.contactTestBitMask = bulletCategory
        scenery.physicsBody?.collisionBitMask = 0
        
        scenery.texture!.filteringMode = .nearest // For pixelated look
        scenery.setScale(6) // Must scale sprites after physicsBody declarations
        
        self.addChild(scenery)
        
        let animationDuration:TimeInterval = 10 // Speed of scenery, decrease for higher difficulty - MUST MATCH BACKGROUND SPEED (animationDuration 10 == Sand.sks speed 152.8)
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -0.1 * self.size.height - scenery.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent()) // Removes once off screen to save memory - see that the number of nodes is not constantly increasing
        scenery.run(SKAction.sequence(actionArray))
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fireBullet()
        
    }
    
    func fireBullet() {
        
        self.run(SKAction.playSoundFileNamed("bullet", waitForCompletion: false))
        
        let bulletNode = SKSpriteNode(imageNamed: "bullet")
        
        bulletNode.position = player.position
        bulletNode.position.y += (player.size.height + bulletNode.size.height) / 2
        
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size) // BULLET HITBOX
        bulletNode.physicsBody?.isDynamic = true
        bulletNode.physicsBody?.categoryBitMask = bulletCategory
        bulletNode.physicsBody?.contactTestBitMask = sceneryCategory
        bulletNode.physicsBody?.collisionBitMask = 0
        bulletNode.physicsBody?.usesPreciseCollisionDetection = true
        
        bulletNode.setScale(8)
        
        self.addChild(bulletNode)
        
        let animationDuration:TimeInterval = 1 // Speed of bullet - possible improvement: calculate based on screensize
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: 0, y: 0.95 * self.size.height), duration: animationDuration)) // X must be player position, in this case it is 0 due to our anchor point
        actionArray.append(SKAction.removeFromParent()) // Removes once off screen to save memory - see that the number of nodes is not constantly increasing
        bulletNode.run(SKAction.sequence(actionArray))
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            secondBody = contact.bodyB
            firstBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask & bulletCategory != 0 && secondBody.categoryBitMask & sceneryCategory != 0 {
            bulletDidCollideWithScenery(bulletNode: firstBody.node as! SKSpriteNode, sceneryNode: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func bulletDidCollideWithScenery (bulletNode:SKSpriteNode, sceneryNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.position = sceneryNode.position
        
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: false))
        
        bulletNode.removeFromParent()
        sceneryNode.removeFromParent()
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 5 // Change as wanted
        
    }
    
    override func didSimulatePhysics() {
        
        player.position.x += 50 * xAcceleration // Change as wanted
        
        if player.position.x < -self.size.width / 2 - player.size.width {
            player.position = CGPoint(x: self.size.width / 2 + player.size.width, y: player.position.y)
        } else if player.position.x > self.size.width / 2 + player.size.width {
            player.position = CGPoint(x: -self.size.width / 2 - player.size.width, y: player.position.y)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
