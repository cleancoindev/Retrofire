//
//  GameScene.swift
//  Retrofire
//
//  Created by Theo Turner on 04/08/2017.
//  Copyright © 2018 Theo Turner. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var music = try? AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "wav")!) as URL)
    
    var sand:SKEmitterNode!
    var player:SKSpriteNode!
    var playerType:Double = 0
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    var bossLives:Int = 0
    
    var enemyTimer:Timer!
    var sceneryTimer:Timer!
    var bossTimer:Timer!
    
    var enemyList = ["enemy-1", "enemy-2", "enemy-3", "enemy-4", "enemy-5", "enemy-6", "enemy-7", "enemy-8"]
    var sceneryList = ["scenery-1", "scenery-2", "scenery-3", "scenery-4", "scenery-5", "scenery-6", "scenery-7", "scenery-8"]
    var bossList = ["boss-1", "boss-2"]
    
    let bulletCategory:UInt32 = 0x1 << 0
    let enemyCategory:UInt32 = 0x1 << 1
    let bossCategory:UInt32 = 0x1 << 2
    let playerCategory:UInt32 = 0x1 << 3
    let sceneryCategory:UInt32 = 0x1 << 4
    
    let motionManger = CMMotionManager()
    var xAcceleration:CGFloat = 0
    
    var livesArray:[SKSpriteNode]!
    
    override func didMove(to view: SKView) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideAd"), object: nil)
        
        self.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.backgroundColor = SKColor(red: 230.0/255.0, green: 220.0/255.0, blue:175.0/255.0, alpha: 0)
        
        music?.numberOfLoops = -1
        music?.play()
        
        let userDefaults = UserDefaults.standard
        playerType = userDefaults.double(forKey: "player")
        playerType == 0 ? playerType = 1 : ()
        let playerName = "player-" + String(playerType)
        
        addLives()
        
        sand = SKEmitterNode(fileNamed: "Sand")
        sand.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height)
        sand.zPosition = -1
        sand.advanceSimulationTime(25)
        self.addChild(sand)
        
        player = SKSpriteNode(imageNamed: playerName)
        player.position = CGPoint(x: 0.5 * self.size.width, y: 0.1 * self.size.height)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = sceneryCategory
        player.physicsBody?.collisionBitMask = 0
        player.texture!.filteringMode = .nearest
        player.setScale(2.5)
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position = CGPoint(x: 0.08 * self.size.width, y: 0.912 * self.size.height)
        scoreLabel.zPosition = 4
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.black
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        score = 0
        self.addChild(scoreLabel)
        
        var timeInterval = 1.25
        if userDefaults.bool(forKey: "hard") {
            timeInterval = 0.75
        }
        enemyTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(addEnemy), userInfo: nil, repeats: true)
        sceneryTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(addScenery), userInfo: nil, repeats: true)
        bossTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(addBoss), userInfo: nil, repeats: true)
        
        motionManger.accelerometerUpdateInterval = 0.2
        motionManger.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAcceleration = CGFloat(((userDefaults.double(forKey: "player") + 6) / 30) * acceleration.x)
            }
        }
        
    }
    
    func addLives() {
        
        livesArray = [SKSpriteNode]()
        
        for lives in 1 ... 3 {
            
            let lifeNode = SKSpriteNode(imageNamed: "heart")
            lifeNode.texture!.filteringMode = .nearest
            lifeNode.setScale(5)
            lifeNode.position = CGPoint(x: 0.88 * self.size.width - 1.15 * CGFloat(3 - lives) * lifeNode.size.width, y: 0.93 * self.size.height) // Must be defined after setScale
            lifeNode.zPosition = 4
            self.addChild(lifeNode)
            
            livesArray.append(lifeNode)
            
        }
        
    }
    
    @objc func addEnemy() {
        
        enemyList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemyList) as! [String]
        let enemy = SKSpriteNode(imageNamed: enemyList[0])
        let generateEnemyPosition = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.size.width))
        let position = CGFloat(generateEnemyPosition.nextInt())
        
        enemy.position = CGPoint(x: position, y: self.size.height + 2.5 * enemy.size.height) // Multiplier must match enemy.setScale below
        enemy.zPosition = 1
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = enemyCategory
        enemy.physicsBody?.contactTestBitMask = bulletCategory
        enemy.physicsBody?.collisionBitMask = 0
        enemy.texture!.filteringMode = .nearest
        enemy.setScale(2.5)
        self.addChild(enemy)
        
        let animationDuration:TimeInterval = 7
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -enemy.size.height), duration: animationDuration))
        actionArray.append(SKAction.run(lifeLost))
        actionArray.append(SKAction.removeFromParent())
        enemy.run(SKAction.sequence(actionArray))
        
    }
    
    @objc func addScenery() {
        
        sceneryList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: sceneryList) as! [String]
        let scenery = SKSpriteNode(imageNamed: sceneryList[0])
        let generateSceneryPosition = GKRandomDistribution(lowestValue: 0, highestValue: Int(self.size.width))
        let position = CGFloat(generateSceneryPosition.nextInt())
        
        scenery.position = CGPoint(x: position, y: self.size.height + 2.5 * scenery.size.height) // Multiplier must match scenery.setScale below
        scenery.physicsBody = SKPhysicsBody(rectangleOf: scenery.size)
        scenery.physicsBody?.isDynamic = true
        scenery.physicsBody?.categoryBitMask = sceneryCategory
        scenery.physicsBody?.contactTestBitMask = playerCategory
        scenery.physicsBody?.collisionBitMask = 0
        scenery.texture!.filteringMode = .nearest
        scenery.setScale(2.5)
        self.addChild(scenery)
        
        let animationDuration:TimeInterval = 0.0369 * Double(self.size.height) // Matches Sand.sks speed, defined in terms of screen height for consistency across devices
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -scenery.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        scenery.run(SKAction.sequence(actionArray))
        
    }

    @objc func addBoss() {
        
        bossLives = 10
        bossList = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: bossList) as! [String]
        let boss = SKSpriteNode(imageNamed: bossList[0])
        
        boss.position = CGPoint(x: 0.5 * self.size.width, y: self.size.height + 5 * boss.size.height) // Multiplier must match boss.setScale below
        boss.zPosition = 2
        boss.physicsBody = SKPhysicsBody(rectangleOf: boss.size)
        boss.physicsBody?.isDynamic = true
        boss.physicsBody?.categoryBitMask = bossCategory
        boss.physicsBody?.contactTestBitMask = bulletCategory
        boss.physicsBody?.collisionBitMask = 0
        boss.texture!.filteringMode = .nearest
        boss.setScale(5)
        self.addChild(boss)
        
        let animationDuration:TimeInterval = 14
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: 0.5 * self.size.width, y: -boss.size.height), duration: animationDuration))
        actionArray.append(SKAction.run(lifeLost))
        actionArray.append(SKAction.removeFromParent())
        boss.run(SKAction.sequence(actionArray))
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fireBullet()
        
    }
    
    func fireBullet() {
        
        self.run(SKAction.playSoundFileNamed("fire", waitForCompletion: false))
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        
        bullet.position = player.position
        bullet.position.y += 0.5 * player.size.height
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = enemyCategory | bossCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        bullet.texture!.filteringMode = .nearest
        bullet.setScale(5)
        self.addChild(bullet)
        
        let animationDuration:TimeInterval = 0.5
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.size.height + bullet.size.height), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        bullet.run(SKAction.sequence(actionArray))
        
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
        
        if firstBody.node != nil && secondBody.node != nil {
            if firstBody.categoryBitMask & bulletCategory != 0 && secondBody.categoryBitMask & enemyCategory != 0 {
                bulletHitEnemy(bulletNode: firstBody.node as! SKSpriteNode, enemyNode: secondBody.node as! SKSpriteNode)
            }
            else if firstBody.categoryBitMask & bulletCategory != 0 && secondBody.categoryBitMask & bossCategory != 0 {
                bulletHitBoss(bulletNode: firstBody.node as! SKSpriteNode, bossNode: secondBody.node as! SKSpriteNode)
            }
            else if firstBody.categoryBitMask & playerCategory != 0 && secondBody.categoryBitMask & sceneryCategory != 0 {
                playerHitScenery(playerNode: firstBody.node as! SKSpriteNode, sceneryNode: secondBody.node as! SKSpriteNode)
            }
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
        
        score += 10
        
    }
    
    func bulletHitBoss(bulletNode:SKSpriteNode, bossNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.zPosition = 3
        
        if bossLives < 2 {
            explosion.position = bossNode.position
            explosion.setScale(2)
            bossNode.removeFromParent()
            self.run(SKAction.playSoundFileNamed("bossexplosion", waitForCompletion: false))
            score += 500
        }
        else {
            explosion.position = bulletNode.position
            explosion.setScale(0.75)
            self.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: false))
            bossLives -= 1
        }
        
        self.addChild(explosion)
        
        bulletNode.removeFromParent()
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
    }
    
    func playerHitScenery(playerNode:SKSpriteNode, sceneryNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.position = sceneryNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("collision", waitForCompletion: false))
        
        sceneryNode.removeFromParent()
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        lifeLost()
        
    }
    
    func lifeLost() {
        
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
                music?.stop()
                self.view?.presentScene(gameOver, transition: transition)
                self.run(SKAction.playSoundFileNamed("gameover", waitForCompletion: true))
            }
        }
        
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
    
}
