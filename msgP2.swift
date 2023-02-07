//
//  msgP2.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 09/07/1444 AH.
//

import UIKit
import AVFoundation

class msgP2: UIViewController {

    @IBOutlet weak var viewInstruction: UIButton!
    
    @IBOutlet weak var hintbutton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(Global.shared.audioHomePage == nil){
            print("Global.shared.audioHomePage = ", Global.shared.audioHomePage)
            
        }else{
            Global.shared.audioHomePage.pause()

        }
        
        
        
        
        viewInstruction.layer.cornerRadius =      viewInstruction.frame.width/2
       viewInstruction.layer.borderWidth = 6
       viewInstruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
       viewInstruction.clipsToBounds = true
        
        hintbutton.layer.cornerRadius =        hintbutton.frame.width/2
        hintbutton.layer.borderWidth = 6
        hintbutton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
      hintbutton.clipsToBounds = true
        
      backButton.layer.cornerRadius =        backButton.frame.width/2
        backButton.layer.borderWidth = 6
        backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        backButton.clipsToBounds = true
        
        
        playAlarm()
    }
    

    func playAlarm() {
            // need to declare local path as url
            let url = Bundle.main.url(forResource: "msgP2", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audiomsgP2 = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audiomsgP2 .play()
    }

}
