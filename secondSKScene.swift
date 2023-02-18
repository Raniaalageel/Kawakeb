//
//  secondSKScene.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 01/07/1444 AH.
//


import UIKit
import SpriteKit
import GameplayKit
import CoreMotion
import Firebase
import FirebaseFirestore
class secondSKScene: SKScene,SKPhysicsContactDelegate {
    
    let db = Firestore.firestore()
    
    var player:SKSpriteNode!
    var currentRockIMG:String!
    var xAcceration:CGFloat = 0
    var touchbegain : CGPoint?
    
    var winalert :SKSpriteNode!
    var faialert :SKSpriteNode!
    var points:Int!
    
    var current: Int = 0
    var moves: [String] = []
    
    var   FlowerPoints:Int!
    var Flowcpoints:Int!
    
    var   buttonnext :SKSpriteNode!
    var   hombutton :SKSpriteNode!
    var buttongo: SKNode! = nil
    
    var   buttotryagain :SKSpriteNode!
    var   tryHomebutton :SKSpriteNode!
    var starfiled2:SKEmitterNode!
    var failLabel:SKLabelNode!
    var successLabel:SKLabelNode!
    var starfiled:SKEmitterNode!
    var emptyArray:SKSpriteNode!
    var emptyLabel:SKLabelNode!
    var OkButton:SKSpriteNode!
    var successLabelPoint:SKLabelNode!
    var arrayWithLabel = [String]()
    var add:SKSpriteNode!
    
    var FailSound = SKAction.playSoundFileNamed("FailSound.mp3", waitForCompletion: false)
    var FailSound2 = SKAction.playSoundFileNamed("FailSound2.mp3", waitForCompletion: false)
    var SuccsusSound = SKAction.playSoundFileNamed("sucessSound.mp3", waitForCompletion: false)
    var SuccsusSound2 = SKAction.playSoundFileNamed("suc.mp3", waitForCompletion: false)
    var emptySound = SKAction.playSoundFileNamed("emptySound.mp3", waitForCompletion: false)
    var FailTryagainSound = SKAction.playSoundFileNamed("TryagainSound.mp3", waitForCompletion: false)
    
    
    
    var outofgame = SKAction.playSoundFileNamed("outofgame.mp3", waitForCompletion: false)
    
    var notallPath = SKAction.playSoundFileNamed("notallPath.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        Global.shared.endgame = false
        super.didMove(to: view)
        print("didMove", frame)
        ///
        
        let background = SKSpriteNode(imageNamed: "secondGame-1")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        ///
        
        
        starfiled = SKEmitterNode(fileNamed: "Fiwin")
        starfiled.position = CGPoint(x: -50, y: 1500)
        //starfiled.advanceSimulationTime(10)
        // starfiled.zPosition = -1
        starfiled2 = SKEmitterNode(fileNamed: "my")
        starfiled2.position = CGPoint(x: 400, y: 1500)
        
        player = SKSpriteNode(imageNamed: Global.shared.rocketImage)
        //Global.shared.rocketImage
        player.size = .init(width: 100, height: 190)
        player.position = CGPoint(x: frame.width * 0.8, y: frame.height * 0.7)
        self.addChild(player)
        
        
        
        //////////////////sucsses alert
        winalert = SKSpriteNode(imageNamed: "sucsses3")
                   winalert.size = .init(width: 830, height: 715)
                   winalert .position = CGPoint(x: self.size.width/2.1, y: self.size.height/2)
                winalert .zPosition = 0
                               
                buttonnext = SKSpriteNode(imageNamed: "nextButton2")
                buttonnext.name = "pressNext"
                   buttonnext.size = .init(width: 305, height: 150)
                buttonnext.position = CGPoint(x: frame.width * 0.68, y: frame.height * 0.341)
                 
                   add = SKSpriteNode(imageNamed: "add6")
                   add.size = .init(width: 350, height: 180)
                   add.position = CGPoint(x: frame.width * 0.80, y: frame.height * 0.10)
                   //0.6   0.4   y in less be down , x in less go left
                   

                hombutton = SKSpriteNode(imageNamed: "HomebuttonSu")
                hombutton.name = "pressHome"
                hombutton.size = .init(width: 280, height: 180)
                hombutton.position = CGPoint(x: frame.width * 0.35, y: frame.height * 0.35)
        
        
        //           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
        
        //           emptyArray = SKSpriteNode(imageNamed: "emptyAlert")
        //           emptyArray.size = .init(width: 620, height: 430)
        //           emptyArray .position = CGPoint(x: self.size.width/1.90, y: self.size.height/2.2)
        //           emptyArray .zPosition = 0
        emptyArray = SKSpriteNode(imageNamed: "emptyAlert")
        emptyArray.size = .init(width: 620, height: 430)
        emptyArray .position = CGPoint(x: self.size.width/1.90, y: self.size.height/2.2)
        emptyArray .zPosition = 0
        
        
        emptyLabel = SKLabelNode(fontNamed: "System")
        emptyLabel.text = String("تأكد من وضع القطع أمام الكاميرا")
        emptyLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
        emptyLabel.fontSize = 40.0
        emptyLabel.horizontalAlignmentMode = .right
        emptyLabel.verticalAlignmentMode = .center
        emptyLabel.position = CGPoint(x: 680, y: 723)
        
        OkButton = SKSpriteNode(imageNamed: "OKButton2")
        OkButton.name = "OkButton"
        OkButton.size = .init(width: 280, height: 130)
        OkButton.position = CGPoint(x: frame.width * 0.54, y: frame.height * 0.32)
        
        
        
        successLabel = SKLabelNode(fontNamed: "System")
        successLabel.text = String("نجحت بالوصول إلى كوكب الأرض!")
        successLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
        successLabel.fontSize = 38.0
        successLabel.horizontalAlignmentMode = .right
        successLabel.verticalAlignmentMode = .center
        successLabel.position = CGPoint(x: 630, y: 760)

        
        
        successLabelPoint = SKLabelNode(fontNamed: "System")
        successLabelPoint.text = String(" ربحت ١٠ نقاط")
        successLabelPoint.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
        successLabelPoint.fontSize = 38.0
        successLabelPoint.horizontalAlignmentMode = .right
        successLabelPoint.verticalAlignmentMode = .center
        successLabelPoint.position = CGPoint(x: 500, y: 90)
        
        
        ///// Fail alert
        faialert = SKSpriteNode(imageNamed: "fail")
        faialert.size = .init(width: 850, height: 800)
        faialert .position = CGPoint(x: self.size.width/2, y: self.size.height/2.47)
        faialert .zPosition = 0
        
        buttotryagain = SKSpriteNode(imageNamed: "yes")
        buttotryagain.name = "buttotryagain"
        buttotryagain.size = .init(width: 280, height: 180)
        buttotryagain.position = CGPoint(x: frame.width * 0.75, y: frame.height * 0.3)
        
        tryHomebutton = SKSpriteNode(imageNamed: "HomebuttonSu")
        tryHomebutton.name = "tryHomebutton"
        tryHomebutton.size = .init(width: 280, height: 180)
        // hombutton.position =  CGPoint(x: self.size.width/3, y: self.size.height/3)
        tryHomebutton.position = CGPoint(x: frame.width * 0.37, y: frame.height * 0.342)
        
        
        //  failLabel?.fontName? = "System"
        
        
        
        failLabel = SKLabelNode(fontNamed: "System")
        failLabel.text = String("لم تتمكن من الوصول! هل تريد المحاولة مرة اخرى؟")
        failLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
        failLabel.fontSize = 33.0
        failLabel.horizontalAlignmentMode = .right
        failLabel.verticalAlignmentMode = .center
        failLabel.position = CGPoint(x: 715, y: 730)  //more be in right
        ///
        
        buttongo = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 44))
        buttongo.name = "nextButton"
        buttongo.position = CGPoint(x: 120, y: 100);
        buttongo.position = CGPoint(x: frame.width * 0.7, y: frame.height * 0.4)
        //  buttongo(normalString: "انطلق", normalStringColor: UIColor.blueColor, size: CGSizeMake(200, 40), cornerRadius: 10.0, buttonFunc: gobutton() )
        
        
        
        //        let action = SKAction.sequence([.move(by: .init(dx: -100, dy: 0), duration: 1), .rotate(byAngle: 10, duration: 1)]) action.timingMode = .easeOut
        
        if Global.shared.allLablels .isEmpty {
            print("charcter not move")
            Global.shared.EmptyStopArray = false
            self.addChild(emptyArray)
            self.addChild(emptyLabel)
            self.addChild(OkButton)
            playSound2(sound: emptySound)
            playSound1(sound: FailSound)
        }
        else {
            print("charcter move")
            var ch = Character(":")
            var alliteration = 0
            let moveDuration = 3
            var actions: [SKAction] = []
            
            moves = Global.shared.allLablels.map {
                String($0.split(separator: ":").first!)
            }
//            let label = Global.shared.allLablels[current].split(separator: ":").first!
            doMove(label: moves[current])
            
            return
            
//            for label in Global.shared.allLablels {
//                //let direction = label.split(separator: ":")
//                //let direction = label.split(separator: ":")
//
//                var result = Global.shared.allLablels[alliteration].split(separator: ch)
//                var resullabel = String(result[0])
//                arrayWithLabel.append(resullabel)
//                //                        print( resullabel, "in the for loop")
//                //                   print(label, "loop")
//                switch resullabel {
//                case "right":
//                    print(" move right")
//                    if (player.position.x + 300) < scene!.size.width {
//                        actions.append(SKAction.move(by: .init(dx: 300, dy: 0), duration: 2))
//                    } else {
//                        print("not allowed")
//                    }
//
//                case "left":
//                    print(" move left")
//                    if (player.position.x - 210) > 0 {
//                        actions.append(SKAction.move(by: .init(dx: -210, dy: 0), duration: 2))
//                    } else {
//                        print("not allowed")
//                    }
//
//                case "up":
//                    print(" move up")
//                    if (player.position.y + 200) < scene!.size.height {
//                        actions.append(SKAction.move(by: .init(dx: 0, dy: 200), duration: 2))
//                    } else {
//                        print("not allowed")
//                    }
//
//                case "down":
//                    print(" move down")
//                    if (player.position.y - 230) > 0 {
//                        actions.append(SKAction.move(by: .init(dx: 0, dy: -230), duration: 2))
//                    } else {
//                        print("not allowed")
//                    }
//
//                default: print("")
//                }
//                alliteration += 1
//            }
            
//            actions.append(.run({
//                self.winCondition()
//            }))
//            player.run(.sequence(actions))
//
            
        }
        print("arrawithLabel:",arrayWithLabel)
        
    }
    
    
    
    func doMove(label: String) {
        var actions: [SKAction] = []
        switch label {
        case "right":
            if (player.position.x + 300) < scene!.size.width {
                actions.append(SKAction.move(by: .init(dx: 300, dy: 0), duration: 2))
            } else {
                current = moves.count - 1
                OutOfrange()
                return
            }
            
        case "left":
            if (player.position.x - 210) > 0 {
                actions.append(SKAction.move(by: .init(dx: -210, dy: 0), duration: 2))
            }else {
                current = moves.count - 1
                OutOfrange()
                return
            }
            
        case "up":
            if (player.position.y + 200) < scene!.size.height {
                actions.append(SKAction.move(by: .init(dx: 0, dy: 200), duration: 2))
            }else {
                current = moves.count - 1
                OutOfrange()
                return
            }
            
        case "down":
            if (player.position.y - 230) > 0 {
                actions.append(SKAction.move(by: .init(dx: 0, dy: -230), duration: 2))
            }else {
                current = moves.count - 1
                OutOfrange()
                return
            }
            
        default: print("")
        }
        
        actions.append(.run({
            if self.current + 1 < self.moves.count {
                self.current += 1
                self.doMove(label: self.moves[self.current])
            } else {
                self.winCondition()
            }
        }))
        player.run(.sequence(actions))
    }
    
    
    func OutOfrange(){
        failLabel.text = String(" خرجت من منطقة اللعب!هل تريد المحاولة مرة اخرى؟")
        print("win on another path")
        self.addChild(faialert)
        self.addChild(failLabel)
        self.addChild(tryHomebutton)
        self.addChild(buttotryagain)
        playSound2(sound: FailSound)
        playSound1(sound:outofgame )
         let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1000), duration: 1)
         player.run(actionplayer)
        
    }
    
    
    
    
    func winCondition() {
        if(Global.shared.winAlertSecondGame == moves){
            if(player.position.x >= 450.0 && player.position.x <= 665.0   && player.position.y >= 330.0 && player.position.y <= 450.5){
                print("is win")
                self.addChild(winalert )
                self.addChild(buttonnext)
                self.addChild(hombutton)
                self.addChild(successLabel)
//                self.addChild(starfiled)
                self.addChild(starfiled2)
                playSound1(sound: SuccsusSound)
                playSound2(sound: SuccsusSound2)
             self.addChild(successLabelPoint)
               // let action = SKAction.sequence([.move(by: .init(dx: -520, dy: 950), duration: 1), .rotate(byAngle: 10, duration: 1)]);
                let action = SKAction.sequence([.move(by: .init(dx:30, dy: 400), duration: 1)])
                             
                         successLabelPoint.run(action)
                
                //  self.addChild(buttongo)
                
                //                   let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
                //                   player.run(actionplayer)
                
                
                calculatePoint()
            }
        }
        
        else if(player.position.x >= 450.0 && player.position.x <= 665.0   && player.position.y >= 330.0 && player.position.y <= 450.5)
                && (Global.shared.winAlertSecondGame != moves){
            //            self.addChild(winfailalert)
            //            self.addChild(OkButton)
            //            self.addChild(failLabelelse)
            failLabel.text = String("لم تعبر من المسار الصحيح!هل تريدالمحاولة مرة اخرى")
            print("win on another path")
            self.addChild(faialert)
            self.addChild(failLabel)
            self.addChild(tryHomebutton)
            self.addChild(buttotryagain)
            playSound2(sound: FailSound)
            playSound1(sound:notallPath )
            let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1500), duration: 1)
            player.run(actionplayer)
            
        } else {
            print("not win")
            self.addChild(faialert)
            self.addChild(failLabel)
            self.addChild(tryHomebutton)
            self.addChild(buttotryagain)
            playSound3(sound: FailTryagainSound)
            playSound4(sound: FailSound)
            let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1500), duration: 1)
            player.run(actionplayer)
        }
        
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            print("location",location)
            print("touchedNode",touchedNode)
            
            if touchedNode.name == "pressNext" {
                print("pressNext")
                let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                let vcc = storyboardd.instantiateViewController(withIdentifier: "msgP3") as! msgP3
                vcc.view.frame = (self.view?.frame)!
                vcc.view.layoutIfNeeded()
                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                    self.view?.window?.rootViewController = vcc
                }, completion: { completed in
                    
                })
            }
            else if touchedNode.name == "pressHome" {
                print("pressHome")
                //                       Global.shared.GoBackHomeStopCamera = false
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
                //                       Global.shared.GoBackHomeStopCamera = false
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
                let vcc = storyboardd.instantiateViewController(withIdentifier: "Secondg") as! SecondGame
                vcc.view.frame = (self.view?.frame)!
                vcc.view.layoutIfNeeded()
                UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                    self.view?.window?.rootViewController = vcc
                }, completion: { completed in
                    
                })
                
            }
            
            else if touchedNode.name == "OkButton" {
                print("OkButton")
                Global.shared.EmptyStopArray = true
                let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                let vcc = storyboardd.instantiateViewController(withIdentifier: "Secondg") as! SecondGame
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
        
        
        
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
            (snapshot, error) in
            if let error = error {
                print("FAIL")
            }
            else {
                print("SUCCESS??")
                
                self.FlowerPoints = snapshot!.documents.first!.get("FlowerPoints") as! Int
                print("??????FlowerPoints",self.FlowerPoints!)
                
                self.Flowcpoints = self.FlowerPoints!
                print("self33,",self.Flowcpoints!)
                
                self.points = snapshot!.documents.first!.get("points") as! Int
                print("??????points",self.points!)
            }
            
            let student_docID = snapshot!.documents.first!.documentID
            
            
            if(self.Flowcpoints! == 0 ){
                self.db.collection("Child").document(student_docID).setData([
                    "points": self.points + 10 ,
                    "Earth" : "open" ,
                    "FlowerPoints": 1
                ],merge:true) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
            }else{
                print("already win ")
            }
        }
        
    }
    
    func playSound1(sound : SKAction)
        {
            run(sound)
           // runAction(sound)
        }
    func playSound2(sound : SKAction)
        {
            run(sound)
           // runAction(sound)
        }
    func playSound3(sound : SKAction)
        {
            run(sound)
           // runAction(sound)
        }
    func playSound4(sound : SKAction)
        {
            run(sound)
           // runAction(sound)
        }
    
}
