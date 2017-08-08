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
    var enemyList = ["enemy-1", "enemy-2", "enemy-3", "enemy-4", "enemy-5", "enemy-6", "enemy-7", "enemy-8"]
    
    let enemyCategory:UInt32 = 0x1 << 1
    let bulletCategory:UInt32 = 0x1 << 0
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    var livesArray:[SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = SKColor(colorLiteralRed: 230/255, green: 220/255, blue: 175/255, alpha: 0)
        
        addLives()
        
        sand = SKEmitterNode(fileNamed: "Sand")
        sand.position = CGPoint(x: self.size.width / 2, y: self.size.height)
        sand.advanceSimulationTime(25)
        
        self.addChild(sand)
        
        sand.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player-green")
        player.position = CGPoint(x: self.size.width / 2, y: 0.1 * self.size.height)
        player.texture!.filteringMode = .nearest
        player.setScale(5)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: 0.225 * self.size.width, y: 0.935 * self.size.height)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 28
        scoreLabel.fontColor = UIColor.black
        score = 0
        
        self.addChild(scoreLabel)
        
        scoreLabel.zPosition = 1
        
        var timeInterval = 0.75
        
        if UserDefaults.standard.bool(forKey: "hard") {
            timeInterval = 0.3
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.75 + self.xAcceleration * 0.25
            }
        }
        
    }
    
    func addLives() {
        
        livesArray = [SKSpriteNode]()
        
        for lives in 1 ... 3 {
            
            let lifeNode = SKSpriteNode(imageNamed: "heart")
            
            lifeNode.texture!.filteringMode = .nearest
            lifeNode.setScale(5)
            
            lifeNode.position = CGPoint(x: self.size.width - 1.1 * CGFloat(4 - lives) * lifeNode.size.width, y: 0.95 * self.size.height)
            
            self.addChild(lifeNode)
            
            lifeNode.zPosition = 1
            
            livesArray.append(lifeNode)
            
        }
        
    }
    
    func addEnemy() {
        
        enemyList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemyList) as! [String]
        let enemy = SKSpriteNode(imageNamed: enemyList[0])
        let generateEnemyPosition = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.size.width))
        let position = CGFloat(generateEnemyPosition.nextInt())
        
        enemy.position = CGPoint(x: position, y: self.size.height + 5 * enemy.size.height) // Multiplier must match enemy.setScale below
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = enemyCategory
        enemy.physicsBody?.contactTestBitMask = bulletCategory
        enemy.physicsBody?.collisionBitMask = 0
        enemy.texture!.filteringMode = .nearest
        enemy.setScale(5)
        
        self.addChild(enemy)
        
        let animationDuration:TimeInterval = 7 // Match Sand.sks speed if using scenery
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -enemy.size.height), duration: animationDuration))
        actionArray.append(SKAction.run {
            self.run(SKAction.playSoundFileNamed("lifelost", waitForCompletion: false))
            if self.livesArray.count > 0 {
                let lifeNode = self.livesArray.first
                lifeNode!.removeFromParent()
                self.livesArray.removeFirst()
                if self.livesArray.count == 0 {
                    let transition = SKTransition.fade(with: SKColor.white, duration: 0.5)
                    transition.pausesOutgoingScene = false
                    transition.pausesIncomingScene = false
                    let gameOver = SKScene(fileNamed: "GameOverScene") as! GameOverScene
                    gameOver.score = self.score
                    self.view?.presentScene(gameOver, transition: transition)
                }
            }
        })
        actionArray.append(SKAction.removeFromParent())
        enemy.run(SKAction.sequence(actionArray))
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fireBullet()
        
    }
    
    func fireBullet() {
        
        self.run(SKAction.playSoundFileNamed("bullet", waitForCompletion: false))
        
        let bulletNode = SKSpriteNode(imageNamed: "bullet")
        
        bulletNode.position = player.position
        bulletNode.position.y += player.size.height / 2
        bulletNode.physicsBody = SKPhysicsBody(rectangleOf: bulletNode.size)
        bulletNode.physicsBody?.isDynamic = true
        bulletNode.physicsBody?.categoryBitMask = bulletCategory
        bulletNode.physicsBody?.contactTestBitMask = enemyCategory
        bulletNode.physicsBody?.collisionBitMask = 0
        bulletNode.physicsBody?.usesPreciseCollisionDetection = true
        bulletNode.texture!.filteringMode = .nearest // Remove line if keeping art a uniform colour rectangle
        bulletNode.setScale(5)
        
        self.addChild(bulletNode)
        
        let animationDuration:TimeInterval = 0.3
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.size.height + bulletNode.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        bulletNode.run(SKAction.sequence(actionArray))
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node != nil && secondBody.node != nil && firstBody.categoryBitMask & bulletCategory != 0 && secondBody.categoryBitMask & enemyCategory != 0 {
            bulletHitEnemy(bulletNode: firstBody.node as! SKSpriteNode, enemyNode: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    
    func bulletHitEnemy(bulletNode:SKSpriteNode, enemyNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.position = enemyNode.position
        
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: false))
        
        bulletNode.removeFromParent()
        enemyNode.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 5
        
    }
    
    override func didSimulatePhysics() {
        
        player.position.x += xAcceleration * 50
        
        if player.position.x < -player.size.width {
            player.position = CGPoint(x: self.size.width + player.size.width, y: player.position.y)
        }
        else if player.position.x > self.size.width + player.size.width {
            player.position = CGPoint(x: -player.size.width, y: player.position.y)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
