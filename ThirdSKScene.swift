//
//  ThirdSKScene.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 05/07/1444 AH.
//


import UIKit
import SpriteKit
import GameplayKit
import CoreMotion
import Firebase
import FirebaseFirestore
class ThirdSKScene: SKScene,SKPhysicsContactDelegate {
    let db = Firestore.firestore()
    
    var player:SKSpriteNode!
    var currentRockIMG:String!
    var xAcceration:CGFloat = 0
    var touchbegain : CGPoint?
    
    var winalert :SKSpriteNode!
    var faialert :SKSpriteNode!
    var points:Int!
    
    var  EarthPoints:Int!
    var Earthcpoints:Int!
    
    var   buttonnext :SKSpriteNode!
    var   hombutton :SKSpriteNode!
    var buttongo: SKNode! = nil
    
    var   buttotryagain :SKSpriteNode!
    var   tryHomebutton :SKSpriteNode!
    
    var failLabel:SKLabelNode!
    var successLabel:SKLabelNode!
    var starfiled:SKEmitterNode!
    var emptyArray:SKSpriteNode!
    var emptyLabel:SKLabelNode!
    var OkButton:SKSpriteNode!
    
    var arrayWithLabel = [String]()
    var indexLoop:Int!
        var indexcloseLoop:Int!
        var start:Int!
    var arrayLoop = [String]()
        var arrayBeforLoop = [String]()
        var arrayAfterLoop = [String]()
    
    var FailSound = SKAction.playSoundFileNamed("FailSound.mp3", waitForCompletion: false)
    var FailSound2 = SKAction.playSoundFileNamed("FailSound2.mp3", waitForCompletion: false)
    var SuccsusSound = SKAction.playSoundFileNamed("SuccsecSound.mp3", waitForCompletion: false)
    var SuccsusSound2 = SKAction.playSoundFileNamed("SuccsecSound3.mp3", waitForCompletion: false)
    
    var cnodtionArray = true
    var NormalSnario = true
       override func didMove(to view: SKView) {
           Global.shared.endgame = false
           super.didMove(to: view)
           print("didMove", frame)
           ///
           
           let background = SKSpriteNode(imageNamed: "thirdLevel")
           background.size = self.size
           background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
           background.zPosition = 0
           self.addChild(background)
           ///
           
          
           starfiled = SKEmitterNode(fileNamed: "Fiwin")
           starfiled.position = CGPoint(x: 500, y: 1500)
           //starfiled.advanceSimulationTime(10)
          // starfiled.zPosition = -1
                   
          
               player = SKSpriteNode(imageNamed: Global.shared.rocketImage)
           //Global.shared.rocketImage
         player.size = .init(width: 100, height: 190)
           player.position = CGPoint(x: frame.width * 0.20, y: frame.height * 0.15)
           self.addChild(player) //0.8
           
           
           
           //////////////////sucsses alert
           winalert = SKSpriteNode(imageNamed: "sucsses")
           winalert.size = .init(width: 850, height: 990)
           winalert .position = CGPoint(x: self.size.width/1.8, y: self.size.height/2.8)
        winalert .zPosition = 0
                       
        buttonnext = SKSpriteNode(imageNamed: "nextButto")
        buttonnext.name = "pressNext"
           buttonnext.size = .init(width: 280, height: 180)
        buttonnext.position = CGPoint(x: frame.width * 0.66, y: frame.height * 0.33)   //0.6   0.4   y in less be down , x in less go left
           

        hombutton = SKSpriteNode(imageNamed: "HomebuttonSu")
        hombutton.name = "pressHome"
        hombutton.size = .init(width: 280, height: 180)
        hombutton.position = CGPoint(x: frame.width * 0.35, y: frame.height * 0.370)
           
           
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
           emptyLabel.text = String("تأكد من وضع القطع امام الكاميرا ")
           emptyLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
           emptyLabel.fontSize = 40.0
           emptyLabel.horizontalAlignmentMode = .right
           emptyLabel.verticalAlignmentMode = .center
           emptyLabel.position = CGPoint(x: 680, y: 723)
           
           OkButton = SKSpriteNode(imageNamed: "OKButton")
           OkButton.name = "OkButton"
           OkButton.size = .init(width: 140, height: 50)
           OkButton.position = CGPoint(x: frame.width * 0.53, y: frame.height * 0.31)
           
           
           
           successLabel = SKLabelNode(fontNamed: "System")
           successLabel.text = String(" نجحت بالوصول إلى كوكب المريخ!")
           successLabel.fontColor = #colorLiteral(red: 0.4073491693, green: 0.3875578046, blue: 0.3836058378, alpha: 1)
           successLabel.fontSize = 36.0
           successLabel.horizontalAlignmentMode = .right
           successLabel.verticalAlignmentMode = .center
           successLabel.position = CGPoint(x: 660, y: 743)
           
           
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
        failLabel.position = CGPoint(x: 691, y: 730)  //more be in right
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
//               CameraOpen().stopTheCamera()
//               EmptyArrayFunc()
    
           }
           var actions: [SKAction] = []
           arraywithlabel()
           checkArray()
           
           if(!(arrayBeforLoop.isEmpty) ){
                          print("charcter move1")
                          var alliteration = 0
                          for label in arrayBeforLoop {
                              switch label {
                              case "right":
                            print(" move right")
                        actions.append(SKAction.move(by: .init(dx: 180, dy: 0), duration: 2))
                            case "left":
                            print(" move left")
                        actions.append(SKAction.move(by: .init(dx: -180, dy: 0), duration: 2))
                            case "up":
                            print(" move up")
                            actions.append(SKAction.move(by: .init(dx: 0, dy: 190), duration: 2))
                           case "down":
                            print(" move down")
                            actions.append(SKAction.move(by: .init(dx: 0, dy: -190), duration: 2))
                            default: print("")
                              }
                              alliteration += 1
                          }

                          
                      }
                      if(!(arrayLoop.isEmpty) ){
                           print("charcter move2")
                           var alliteration = 0
                          
                          var alliteration2 = 0

                         //  var actions: [SKAction] = []
                           for label in arrayLoop {
                               switch label {
                               case "right":
                             print(" move right")
                         actions.append(SKAction.move(by: .init(dx: 180, dy: 0), duration: 2))
                             case "left":
                             print(" move left")
                         actions.append(SKAction.move(by: .init(dx: -180, dy: 0), duration: 2))
                             case "up":
                             print(" move up")
                             actions.append(SKAction.move(by: .init(dx: 0, dy: 190), duration: 2))
                            case "down":
                             print(" move down")
                             actions.append(SKAction.move(by: .init(dx: 0, dy: -190), duration: 2))
                             default: print("")
                               
                               }
                               alliteration += 1
                           }
                          
                          ///second itartion:
                          for label in arrayLoop {
                              switch label {
                              case "right":
                            print(" move right")
                        actions.append(SKAction.move(by: .init(dx: 180, dy: 0), duration: 2))
                            case "left":
                            print(" move left")
                        actions.append(SKAction.move(by: .init(dx: -180, dy: 0), duration: 2))
                            case "up":
                            print(" move up")
                            actions.append(SKAction.move(by: .init(dx: 0, dy: 190), duration: 2))
                           case "down":
                            print(" move down")
                            actions.append(SKAction.move(by: .init(dx: 0, dy: -190), duration: 2))
                            default: print("")
                              
                              }
                              alliteration2 += 1
                          }

                       
                       }
                      if(!(arrayAfterLoop.isEmpty) ){
                           print("charcter move3")
                           var alliteration = 0
                           //var actions: [SKAction] = []
                           for label in arrayAfterLoop {
                               switch label {
                               case "right":
                             print(" move right")
                         actions.append(SKAction.move(by: .init(dx: 180, dy: 0), duration: 2))
                             case "left":
                             print(" move left")
                         actions.append(SKAction.move(by: .init(dx: -180, dy: 0), duration: 2))
                             case "up":
                             print(" move up")
                             actions.append(SKAction.move(by: .init(dx: 0, dy: 190), duration: 2))
                            case "down":
                             print(" move down")
                             actions.append(SKAction.move(by: .init(dx: 0, dy: -190), duration: 2))
                             default: print("")
                               
                               }
                               alliteration += 1
                           }

                          
                       }
           
           
           if(  NormalSnario == false ){
               print("charcter move3")
               var alliteration = 0
               for label in arrayWithLabel {
                   switch label {
                   case "right":
                 print(" move right")
             actions.append(SKAction.move(by: .init(dx: 180, dy: 0), duration: 2))
                 case "left":
                 print(" move left")
             actions.append(SKAction.move(by: .init(dx: -180, dy: 0), duration: 2))
                 case "up":
                 print(" move up")
                 actions.append(SKAction.move(by: .init(dx: 0, dy: 190), duration: 2))
                case "down":
                 print(" move down")
                 actions.append(SKAction.move(by: .init(dx: 0, dy: -190), duration: 2))
                 default: print("")
                   
                   }
                   alliteration += 1
               }
           }

           
                      actions.append(.run(    {
                          if(self.cnodtionArray == true && Global.shared.EmptyStopArray == true ){
                             self.winCondition() }
                          }))
           print(actions,"actions")
        
           
           print(player.position,"1player.position")

                      player.run(.sequence(actions))
           print(player.position,"player.position")
           print("arrawithLabel:",arrayWithLabel)
                  }
           
        
           
           
       
       
     func EmptyArrayFunc(){
         
         self.addChild(emptyArray)
                       self.addChild(emptyLabel)
                       self.addChild(OkButton)
                       CameraOpen().stopTheCamera()
        
    }

    func arraywithlabel(){
            var ch = Character(":")
            var alliteration = 0
            for label in Global.shared.allLablels {
     var result = Global.shared.allLablels[alliteration].split(separator: ch)
                         var resullabel = String(result[0])
               arrayWithLabel.append(resullabel)
                alliteration += 1
            }
            print("arrawithLabel:",arrayWithLabel)
        }
        func  checkArray(){
            var local = 0
       // if(arrayWithLabel.contains("loop2") || arrayWithLabel.contains("loop3") && (arrayWithLabel.contains("loop")) ){
            if(arrayWithLabel.contains("loop") && arrayWithLabel.contains("loop2") || arrayWithLabel.contains("loop3")){
        print("loop end close are exist")
                print("loop2 exist")
                indexLoop = arrayWithLabel.firstIndex(of: "loop2")!
                 local = indexLoop!
                print("locawl",local)
                print("close loop exist")
                indexcloseLoop = arrayWithLabel.firstIndex(of: "loop")!
            print("index close loop",indexcloseLoop! )
                ///
            if(indexLoop! <= indexcloseLoop!){
                print("indexLoop! <= indexcloseLoop!")
            appneArrayLoop(local: local)   //3 array
                appendArraybefore(before: indexcloseLoop)}
            
            else if(indexLoop! >= indexcloseLoop!) {
                print("indexLoop! >= indexcloseLoop!")
                cnodtionArray = false
                failLabel.text = String("قم بوضع تكرار اولاً !هل تريد المحاولة مرة اخرى؟")
                self.addChild(faialert)
                self.addChild(failLabel)
                self.addChild(tryHomebutton)
                self.addChild(buttotryagain)
            }
            }
        else if(arrayWithLabel.contains("loop2") || arrayWithLabel.contains("loop3") && !(arrayWithLabel.contains("loop")) ) {
                print("close loop please")
            cnodtionArray = false
            failLabel.text = String("قم ب انهاء التكرار !هل تريد المحاولة مرة اخرى؟")
            print("win on another path")
            self.addChild(faialert)
            self.addChild(failLabel)
            self.addChild(tryHomebutton)
            self.addChild(buttotryagain)
            
            }
            else if ( !(arrayWithLabel.contains("loop2")) && arrayWithLabel.contains("loop") ) {
                      //|| !(arrayWithLabel.contains("loop3") ) && arrayWithLabel.contains("loop") ){
                print("put starter loop please")
                cnodtionArray = false
                failLabel.text = String("قم بوضع بداية التكرار !هل تريد المحاولة مرة اخرى؟")
                print("win on another path")
                self.addChild(faialert)
                self.addChild(failLabel)
                self.addChild(tryHomebutton)
                self.addChild(buttotryagain)
                
            }
            else if(!(arrayWithLabel.isEmpty)) {  //normal array
                print("normal array")
                NormalSnario = false
            }
            
        }
        func  appneArrayLoop( local:Int ){
        var i = 0
            start = local+1
            print("starta",start!)
            while start < indexcloseLoop  {
           var label = arrayWithLabel[start!]
                print("label",label)
                
                arrayLoop.append(arrayWithLabel[start!])
                start+=1
        }
            ///// arrayloop
            if(local != 0){
                while i < local {
                    arrayBeforLoop.append(arrayWithLabel[i])
                    i+=1
                }
            }
            ///array before loop
            print("arrayBeforLoop", arrayBeforLoop)
            print(" arrayLoop", arrayLoop)
        }
        
        func appendArraybefore(before:Int){
            var befo = before + 1
            var count = arrayWithLabel.count - 1
            while befo <= count {
                arrayAfterLoop.append(arrayWithLabel[befo])
            befo+=1
            }
            print("arrayAfterLoop", arrayAfterLoop)

        }

       
       
       
       
    func winCondition() {
        if(Global.shared.WinAlertThirdGame == arrayWithLabel){
            if(player.position.x >= 480.0 && player.position.x <= 670.0   && player.position.y >= 900.5 && player.position.y <= 980.5){
                   print("is win")
                   self.addChild(winalert )
                   self.addChild(buttonnext)
                   self.addChild(hombutton)
                   self.addChild(successLabel)
                   self.addChild(starfiled)
                playSound1(sound: SuccsusSound)
                playSound2(sound: SuccsusSound2)
                 //  self.addChild(buttongo)
                   
                   let actionplayer = SKAction.move(by: .init(dx: 0, dy: 200), duration: 3)
                   player.run(actionplayer)
                   
                   
                   calculatePoint()
               }
            }
        
    else if(player.position.x >= 480.0 && player.position.x <= 670.0   && player.position.y >= 900.5 && player.position.y <= 980.5)
        && (Global.shared.WinAlertThirdGame != arrayWithLabel){
        //            self.addChild(winfailalert)
        //            self.addChild(OkButton)
        //            self.addChild(failLabelelse)
                    failLabel.text = String("لم تعبر جميع الطريق!هل تريد المحاولة مرة اخرى؟")
                    print("win on another path")
                    self.addChild(faialert)
                    self.addChild(failLabel)
                    self.addChild(tryHomebutton)
                    self.addChild(buttotryagain)
                    playSound3(sound: FailSound)
                    playSound4(sound: FailSound2)
                     let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1500), duration: 1)
                     player.run(actionplayer)
                   
               }
        else if(player.position.x >= 480.0 && player.position.x <= 670.0   && player.position.y >= 900.5 && player.position.y <= 980.5)
            && ( arrayWithLabel == ["up","up","right","up","up","right"] ){
            //            self.addChild(winfailalert)
            //            self.addChild(OkButton)
            //            self.addChild(failLabelelse)
                        failLabel.text = String("قم باستخدام التكرار!هل تريد المحاولة مرة اخرى؟")
                        print("win on another path")
                        self.addChild(faialert)
                        self.addChild(failLabel)
                        self.addChild(tryHomebutton)
                        self.addChild(buttotryagain)
                        playSound3(sound: FailSound)
                        playSound4(sound: FailSound2)
                         let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1500), duration: 1)
                         player.run(actionplayer)
                       
                   }
        else {
                   print("not win")
                   self.addChild(faialert)
                   self.addChild(failLabel)
                   self.addChild(tryHomebutton)
                   self.addChild(buttotryagain)
                   let actionplayer = SKAction.move(by: .init(dx: 0, dy: -1500), duration: 1)
                   player.run(actionplayer)
               }
           }
            

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
               for touch in touches {
                         let location = touch.location(in: self)
                         let touchedNode = atPoint(location)
                   print("location",location)
                         if touchedNode.name == "pressNext" {
                             print("pressNext")
//                             let storyboardd = UIStoryboard(name: "Main", bundle: nil)
//                             let vcc = storyboardd.instantiateViewController(withIdentifier: "Thirddg") as! ThirdGame
//                             vcc.view.frame = (self.view?.frame)!
//                             vcc.view.layoutIfNeeded()
//                             UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
//                             self.view?.window?.rootViewController = vcc
//                             }, completion: { completed in
//
//                             })
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
                       let vcc = storyboardd.instantiateViewController(withIdentifier: "Thirddg") as! ThirdGame
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
                       let vcc = storyboardd.instantiateViewController(withIdentifier: "Thirddg") as! ThirdGame
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
                        
            self.EarthPoints = snapshot!.documents.first!.get("EarthPoints") as! Int
                print("??????FlowerPoints",self.EarthPoints!)
                            
            self.Earthcpoints = self.EarthPoints!
            print("self33,",self.Earthcpoints!)
                            
                self.points = snapshot!.documents.first!.get("points") as! Int
                            print("??????points",self.points!)
                        }
            
            let student_docID = snapshot!.documents.first!.documentID
        
            
            if(self.Earthcpoints! == 0 ){
            self.db.collection("Child").document(student_docID).setData([
                "points": self.points + 6 ,
                "Mars" : "open" ,
                "EarthPoints": 1
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

    
    
    
    

