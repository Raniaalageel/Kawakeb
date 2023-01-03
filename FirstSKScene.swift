//
//  FirstSKScene.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 10/06/1444 AH.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

class FirstSKScene: SKScene,SKPhysicsContactDelegate {

    var player:SKSpriteNode!
       
       var xAcceration:CGFloat = 0
       var touchbegain : CGPoint?
       
       
       override func didMove(to view: SKView) {
           Global.shared.endgame = false
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
           else {
               print("charcter  move")
               var alliteration = 0
               let moveDuration = 3
               var actions: [SKAction] = []
               for label in Global.shared.allLablels {
                   print(label, "loop")
                   switch label {
                   case "right": actions.append(SKAction.move(by: .init(dx: 300, dy: 0), duration: 2))
                   case "left": actions.append(SKAction.move(by: .init(dx: -195, dy: 0), duration: 3))
                   case "up": actions.append(SKAction.move(by: .init(dx: 0, dy: 200), duration: 3))
                   case "down": actions.append(SKAction.move(by: .init(dx: 0, dy: -100), duration: 2))
                   default: print("")
                   }
               }
               
               actions.append(.run({
                   self.winCondition()
               }))
               player.run(.sequence(actions))
               
   ////            while alliteration < Global.shared.allLablels.count  {
   //                print("LOOP")
   //                var ch = Character(":")
   //                var result = Global.shared.allLablels[alliteration].split(separator: ch)
   //                var resullabel = String(result[0])
   //
   //                if(resullabel == "right"){
   //                    print(" move right")
   //                    actions.append(SKAction.move(by: .init(dx: 300, dy: 0), duration: 2))
   //                    // let actionplayer =    SKAction.move(to: CGPoint(x: 100, y: 0), duration: 0.1)
   //                }
   //                else if(resullabel == "left"){
   //                    print(" move left")
   //                    let actionplayer = SKAction.move(by: .init(dx: -195, dy: 0), duration: 3)
   //
   //                    player.run(actionplayer)
   //
   //                }else if(resullabel == "stop"){
   //                    let actionplayer = SKAction.rotate(byAngle: 10, duration: 2)
   //
   //                    player.run(actionplayer)
   //                }
   //                else  if(resullabel == "start"){
   //
   //                }
   //                else if(resullabel == "up"){
   //                    print(" move up")
   //                    let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
   //
   //                    //player.run(actionplayer)
   //                    player.run(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(moveDuration)),actionplayer]),completion:{
   //
   //                        print("done left")
   //                    })
   //
   //                }else if(resullabel == "down"){
   //                    print(" move down")
   //                    let actionplayer = SKAction.move(by: .init(dx: 0, dy: -100), duration: 2)
   //
   //                    player.run(actionplayer)
   //
   //                }
   //                alliteration += 1
   //            }
               
               
               
           }
           
           
           //player.zPosition = -1
           //        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
           
       }
       
       
       
       
       func alertSucsses() -> AlertScs {
           let storyboard = UIStoryboard(name: "Main", bundle: .main)
           let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertSF") as! AlertScs
           
           return alertVC
       }
       
       func alertFail() -> AlertFail {
           let storyboard = UIStoryboard(name: "Main", bundle: .main)
           let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertFail") as! AlertFail
           return alertVC
       }
       
       
       func winCondition() {
           if(player.position.x >= 270.0 && player.position.x <= 298.0   && player.position.y >= 600.5 && player.position.y <= 620.5){
               
               print("is win")
             let alervc =  alertSucsses()
               view?.window?.rootViewController?.present(alervc, animated: true)
               let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
               player.run(actionplayer)
               Global.shared.endgame = true
           } else {
               print("not win")
               let alervc =  alertFail()
                 view?.window?.rootViewController?.present(alervc, animated: true,completion: nil)
//               DispatchQueue.main.async { [weak self] in
//                   self?.present(alervc, animated: true, completion: nil)
//               }
               
               
           }
       }
       

   //    override func update(_ currentTime: TimeInterval) {
   //
   //
   //    }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           guard let touch = touches.first else { return }
           print("touch",touch)
           let location = touch.location(in: self)
           print("location",location)
           touchbegain = touch.location(in: self)
           print(" touchbegain ",touchbegain)
           let tappedNodes = nodes(at: location)
           print("tappedNodes",tappedNodes)
           
           
       }

    
}
