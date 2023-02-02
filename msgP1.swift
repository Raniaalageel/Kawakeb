//
//  msgP1.swift
//  Kawakeb
//
//  Created by Rania Alageel on 09/07/1444 AH.
//

import UIKit
import AVFoundation

class msgP1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Global.shared.audioHomePage.pause()
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