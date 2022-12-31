//
//  FirstSKScene.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 05/06/1444 AH.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion


class FirstSKScene: SKScene,SKPhysicsContactDelegate  {

    var player:SKSpriteNode!

    var xAcceration:CGFloat = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        print("didMove", frame)
        ///
        
        let background = SKSpriteNode(imageNamed: "FirstGameWithOut")
            background.size = self.size
            background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            background.zPosition = 0
            self.addChild(background)
        ///
        //
//        let button = SKSpriteNode(imageNamed: "star11")
//        button.name = "btn"
//             button.size.height = 100
//             button.size.width = 100
//             button.position =  CGPoint(x: self.size.width/3, y: self.size.height/3)
//             self.addChild(button)
        
//        var buttongo: SKNode! = nil
//        buttongo = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 44))
//             //  buttongo.position = CGPoint(x:self.frame.midX, y:self.frame.midY);
//        buttongo.position = CGPoint(x: 120, y: 100);
//
////        buttongo(normalString: "انطلق", normalStringColor: UIColor.blueColor, size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: gobutton() )
//               self.addChild(buttongo)
        //
        player = SKSpriteNode(imageNamed: "rocket1")  //shuttle rocket1.png
       // player.position = CGPoint(x: 200, y: player.size.height + 100)
        player.size = .init(width: 200, height: 200)
        player.position = CGPoint(x: frame.width * 0.8, y: frame.height * 0.35)
        self.addChild(player)
        
//        let action = SKAction.sequence([.move(by: .init(dx: -100, dy: 0), duration: 1), .rotate(byAngle: 10, duration: 1)]) action.timingMode = .easeOut
        
        if Global.shared.allLablels .isEmpty {
            print("charcter not move")
        }
        else{
            print("charcter  move")
            var alliteration = 0
            let moveDuration = 3
            while alliteration < Global.shared.allLablels.count  {
                var ch = Character(":")
     var result = Global.shared.allLablels[alliteration].split(separator: ch)
                var resullabel = String(result[0])
                
                if(resullabel == "right"){
                    print(" move right")
                    let actionplayer = SKAction.move(by: .init(dx: 300, dy: 0), duration: 2)
                    
                    player.run(actionplayer)
                   
                    
                   // let actionplayer =    SKAction.move(to: CGPoint(x: 100, y: 0), duration: 0.1)
                }
                else if(resullabel == "left"){
                    print(" move left")
                    let actionplayer = SKAction.move(by: .init(dx: -195, dy: 0), duration: 3)
                    
                   player.run(actionplayer)
                    
                
                               
                               
                }else if(resullabel == "stop"){
                    let actionplayer = SKAction.rotate(byAngle: 10, duration: 2)
                    
                    player.run(actionplayer)
                }
               else  if(resullabel == "start"){
                    
                }
                else if(resullabel == "up"){
                    print(" move up")
                    let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
                    
                    //player.run(actionplayer)
                    player.run(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(moveDuration)),actionplayer]),completion:{
                        
                     print("done left")
                    })
                    
                }else if(resullabel == "down"){
                    print(" move down")
                    let actionplayer = SKAction.move(by: .init(dx: 0, dy: -100), duration: 2)
                    
                    player.run(actionplayer)
                    
                }
                alliteration += 1
            }
           
        }
             //player.zPosition = -1
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    
    func gobutton(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
