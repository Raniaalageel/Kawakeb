//
//  msgP2.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 09/07/1444 AH.
//

import UIKit
import AVFoundation

class msgP2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Global.shared.audioHomePage.pause()

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
