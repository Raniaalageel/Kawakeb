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
import Firebase
import FirebaseFirestore

class FirstSKScene: SKScene,SKPhysicsContactDelegate {
    
    let db = Firestore.firestore()
    
    var player:SKSpriteNode!
       
       var xAcceration:CGFloat = 0
       var touchbegain : CGPoint?
    
    var winalert :SKSpriteNode!
    var faialert :SKSpriteNode!
    var points:Int!
     
       var   buttonnext :SKSpriteNode!
       var   hombutton :SKSpriteNode!
    var buttongo: SKNode! = nil
    
    var   buttotryagain :SKSpriteNode!
    var   tryHomebutton :SKSpriteNode!
    
  var failLabel:SKLabelNode!
    var successLabel:SKLabelNode!
    var starfiled:SKEmitterNode!
    
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
           
          
           starfiled = SKEmitterNode(fileNamed: "Fiwin")
           starfiled.position = CGPoint(x: 500, y: 1500)
           //starfiled.advanceSimulationTime(10)
          // starfiled.zPosition = -1
                   
           
           player = SKSpriteNode(imageNamed: "rocket1")  //shuttle rocket1.png
           // player.position = CGPoint(x: 200, y: player.size.height + 100)
           player.size = .init(width: 200, height: 200)
           player.position = CGPoint(x: frame.width * 0.8, y: frame.height * 0.35)
           self.addChild(player)
           //////////////////sucsses alert
           winalert = SKSpriteNode(imageNamed: "sucsses")
           winalert.size = .init(width: 745, height: 550)
           winalert .position = CGPoint(x: self.size.width/1.8, y: self.size.height/2.2)
        winalert .zPosition = 0
                       
        buttonnext = SKSpriteNode(imageNamed: "nextButto")
        buttonnext.name = "pressNext"
           buttonnext.size = .init(width: 280, height: 180)
        buttonnext.position = CGPoint(x: frame.width * 0.66, y: frame.height * 0.33)   //0.6   0.4   y in less be down , x in less go left
           

        hombutton = SKSpriteNode(imageNamed: "HomebuttonSu")
        hombutton.name = "pressHome"
     hombutton.size = .init(width: 280, height: 180)
    hombutton.position = CGPoint(x: frame.width * 0.35, y: frame.height * 0.370)
           
    
           successLabel = SKLabelNode(fontNamed: "System")
           successLabel.text = String("نجحت بالوصول إلى كوكب الزهرة!")
           successLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
           successLabel.fontSize = 40.0
           successLabel.horizontalAlignmentMode = .right
           successLabel.verticalAlignmentMode = .center
           successLabel.position = CGPoint(x: 691, y: 743)
           
           
           ///// Fail alert
           faialert = SKSpriteNode(imageNamed: "fail")
            faialert.size = .init(width: 850, height: 580)
            faialert .position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            faialert .zPosition = 0
           
          buttotryagain = SKSpriteNode(imageNamed: "yes")
           buttotryagain.name = "buttotryagain"
           buttotryagain.size = .init(width: 280, height: 180)
           buttotryagain.position = CGPoint(x: frame.width * 0.75, y: frame.height * 0.323)

          tryHomebutton = SKSpriteNode(imageNamed: "HomebuttonSu")
           tryHomebutton.name = "tryHomebutton"
           tryHomebutton.size = .init(width: 280, height: 180)
                         // hombutton.position =  CGPoint(x: self.size.width/3, y: self.size.height/3)
           tryHomebutton.position = CGPoint(x: frame.width * 0.4, y: frame.height * 0.36)
           
           
      //  failLabel?.fontName? = "System"
       
           
           
           failLabel = SKLabelNode(fontNamed: "System")
        failLabel.text = String("لقد فشلت! هل تريد المحاولة مرة اخرى؟")
        failLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
           failLabel.fontSize = 40.0
        failLabel.horizontalAlignmentMode = .right
        failLabel.verticalAlignmentMode = .center
        failLabel.position = CGPoint(x: 691, y: 760)  //more be in right
           ///
        
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
                   self.addChild(successLabel)
                   self.addChild(starfiled)
                 //  self.addChild(buttongo)
                   
                   let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
                   player.run(actionplayer)
                   
                   calculatePoint()
                   
               } else {
                   print("not win")
                   self.addChild(faialert)
                   self.addChild(failLabel)
                   self.addChild(tryHomebutton)
                   self.addChild(buttotryagain)
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
                   else if touchedNode.name == "tryHomebutton" {
                       print("tryHomebutton")
                       let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                       let vcc = storyboardd.instantiateViewController(withIdentifier: "HomeVC") as! Gamespage
                       vcc.view.frame = (self.view?.frame)!
                       vcc.view.layoutIfNeeded()
                       UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                       self.view?.window?.rootViewController = vcc
                       }, completion: { completed in

                       })

                       }
                   else if touchedNode.name == "buttotryagain" {
                       print("buttotryagain")
                       let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                       let vcc = storyboardd.instantiateViewController(withIdentifier: "Firstautard") as! FirstGame
                       vcc.view.frame = (self.view?.frame)!
                       vcc.view.layoutIfNeeded()
                       UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                       self.view?.window?.rootViewController = vcc
                       }, completion: { completed in

                       })

                       }
                       
                       
                       
                       
                   }
                    }
    
    func calculatePoint(){
        db.collection("Child").whereField("email", isEqualTo: "shamma@gmail.com" ).getDocuments{
                    (snapshot, error) in
                    if let error = error {
                        print("FAIL")
                    }
                    else {
                        print("SUCCESS??")
            self.points = snapshot!.documents.first!.get("points") as! Int
                        print("??????points",self.points!)
                    }

   }
        Task{
        
        guard let childpoint = try await db.collection("Child").whereField("email", isEqualTo:  "shamma@gmail.com" ).getDocuments().documents.first?.documentID else {return}
            print("cureent point",self.points!)
            try await db.collection("Child").document(childpoint).setData([
                "points": self.points + 2 ,
                "Flower" : "open"
            ],merge: true) { err in
                if let err = err {
                    print("not Add points  : \(err)")
                } else {
                    print(" Add points sucsseful ")
                }
            }
        
            
            
            
            
            
            
        }
}
    
}
