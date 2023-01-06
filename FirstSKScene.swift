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
    
    var winalert :SKSpriteNode!
     
       var   buttonnext :SKSpriteNode!
       var   hombutton :SKSpriteNode!
    var buttongo: SKNode! = nil
       
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
           
          
           
                   
           
           player = SKSpriteNode(imageNamed: "rocket1")  //shuttle rocket1.png
           // player.position = CGPoint(x: 200, y: player.size.height + 100)
           player.size = .init(width: 200, height: 200)
           player.position = CGPoint(x: frame.width * 0.8, y: frame.height * 0.35)
           self.addChild(player)
           
           winalert = SKSpriteNode(imageNamed: "Firstwin")
        winalert.size = .init(width: 600, height: 450)
        winalert .position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        winalert .zPosition = 0
                       
        buttonnext = SKSpriteNode(imageNamed: "nextButton")
        buttonnext.name = "pressNext"
        buttonnext.size = .init(width: 160, height: 90)
        buttonnext.position = CGPoint(x: frame.width * 0.7, y: frame.height * 0.4)

        hombutton = SKSpriteNode(imageNamed: "homeButton")
        hombutton.name = "pressHome"
     hombutton.size = .init(width: 160, height: 90)
                      // hombutton.position =  CGPoint(x: self.size.width/3, y: self.size.height/3)
    hombutton.position = CGPoint(x: frame.width * 0.27, y: frame.height * 0.4)
           
           
        
           buttongo = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 44))
   buttongo.name = "nextButton"
           buttongo.position = CGPoint(x: 120, y: 100);
  buttongo.position = CGPoint(x: frame.width * 0.7, y: frame.height * 0.4)
         //  buttongo(normalString: "انطلق", normalStringColor: UIColor.blueColor, size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: gobutton() )
                
           
           
           //        let action = SKAction.sequence([.move(by: .init(dx: -100, dy: 0), duration: 1), .rotate(byAngle: 10, duration: 1)]) action.timingMode = .easeOut
           
           if Global.shared.allLablels .isEmpty {
               print("charcter not move")
           }
           else {
               print("charcter move")
               var ch = Character(":")
               var alliteration = 0
               let moveDuration = 3
               var actions: [SKAction] = []
               for label in Global.shared.allLablels {
                 
        var result = Global.shared.allLablels[alliteration].split(separator: ch)
                            var resullabel = String(result[0])
                                
//                        print( resullabel, "in the for loop")
//                   print(label, "loop")
                   switch resullabel {
                   case "right":
                       print(" move right")
                       actions.append(SKAction.move(by: .init(dx: 300, dy: 0), duration: 2))
                   case "left":
                       print(" move left")
                       actions.append(SKAction.move(by: .init(dx: -195, dy: 0), duration: 3))
                   case "up":
                       print(" move up")
                       actions.append(SKAction.move(by: .init(dx: 0, dy: 200), duration: 3))
                   case "down":
                       print(" move down")
                       actions.append(SKAction.move(by: .init(dx: 0, dy: -100), duration: 2))
                   default: print("")
                   }
                   alliteration += 1
               }
               
               actions.append(.run({
                   self.winCondition()
               }))
               player.run(.sequence(actions))
            
               
           }
           
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
                   self.addChild(winalert )
                   self.addChild(buttonnext)
                   self.addChild(hombutton)
                 //  self.addChild(buttongo)
                   
                   let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
                   player.run(actionplayer)
               } else {
                   print("not win")
               }
           }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               for touch in touches {
                         let location = touch.location(in: self)
                         let touchedNode = atPoint(location)
                   
                         if touchedNode.name == "pressNext" {
                             print("pressNext")
                             let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                             let vcc = storyboardd.instantiateViewController(withIdentifier: "Secondg") as! SecondGame
                             vcc.view.frame = (self.view?.frame)!
                             vcc.view.layoutIfNeeded()
                             UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                             self.view?.window?.rootViewController = vcc
                             }, completion: { completed in

                             })
                         }
                   else if touchedNode.name == "pressHome" {
                       print("pressHome")
                       let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                       let vcc = storyboardd.instantiateViewController(withIdentifier: "HomeVC") as! Gamespage
                       vcc.view.frame = (self.view?.frame)!
                       vcc.view.layoutIfNeeded()
                       UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                       self.view?.window?.rootViewController = vcc
                       }, completion: { completed in

                       })

                       }
                       
                       
                       
                       
                       
                   }
                    }

    
}
