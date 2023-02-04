//
//  msgP1.swift
//  Kawakeb
//
//  Created by Rania Alageel on 09/07/1444 AH.
//

import UIKit
import AVFoundation

class msgP1: UIViewController {

    @IBOutlet weak var hintButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var viewInstruction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Global.shared.audioHomePage.pause()
        
       hintButton.layer.cornerRadius =       hintButton.frame.width/2
        hintButton.layer.borderWidth = 6
       hintButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hintButton.clipsToBounds = true
        
        backButton.layer.cornerRadius =        backButton.frame.width/2
          backButton.layer.borderWidth = 6
          backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
          backButton.clipsToBounds = true
        
      viewInstruction.layer.cornerRadius =         viewInstruction.frame.width/2
        viewInstruction.layer.borderWidth = 6
        viewInstruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        viewInstruction.clipsToBounds = true
        
        playAlarm()
        
    }
    

    func playAlarm() {
            // need to declare local path as url
            let url = Bundle.main.url(forResource: "msgP1", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audiomsgP1 = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audiomsgP1 .play()
    }

}
