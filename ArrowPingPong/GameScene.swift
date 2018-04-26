//
//  GameScene.swift
//  JustJump
//
//  Created by Abhishek Suryawanshi on 28/08/17.
//  Copyright © 2017 iOSDevelopment. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var ball1 = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        
        ball1 = self.childNode(withName: "ball1") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        
        
        let border =  SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
    }
    
    
    
    
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[0])"
        btmLbl.text = "\(score[1])"
        ball1.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
    }
    
    
    
    
    
    func addScore(playerWhoWon : SKSpriteNode) {
        
        ball1.position = CGPoint(x: 0, y: 0)
        ball1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball1.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 15))
            
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball1.physicsBody?.applyImpulse(CGVector(dx: -15, dy: -15))
        }
        
        topLbl.text = "\(score[0])"
        btmLbl.text = "\(score[1])"
        
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
           
            
        }
    }
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 0.1))
            
            break
        case .player2:
            

            break
        default:


            break
        }
        
        
        
        if ball1.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: main)
        }
        else if ball1.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: enemy)
        }
        
    }
}
