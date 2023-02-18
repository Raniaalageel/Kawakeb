//
//  loopViewController.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 17/07/1444 AH.
//

import UIKit
import AVFoundation
class loopViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var dire: UIButton!
    @IBOutlet weak var hint: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Global.shared.loopif = true

        // Do any additional setup after loading the view.
        
       back.layer.cornerRadius =        back.frame.width/2
        back.layer.borderWidth = 6
        back.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        back.clipsToBounds = true
        
        dire.layer.cornerRadius =     dire.frame.width/2
        dire.layer.borderWidth = 6
        dire.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        dire.clipsToBounds = true
        
        
        hint.layer.cornerRadius =       hint.frame.width/2
        hint.layer.borderWidth = 6
        hint.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hint.clipsToBounds = true
        
        
        if(Global.shared.audiomsgP3 == nil)
        {
            print("Global.shared.audiomsgP2 = ", Global.shared.audiomsgP3)
        }else{
            Global.shared.audiomsgP3.pause()
        }
        
        
        
        
        playAlarm()
        if(Global.shared.loopif == true){

            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
      print("2.5")
            UIView.animate(withDuration: 0.2, animations: {
                self.arrow.frame.origin.y -= -180
            },completion: nil)
            if(Global.shared.loopif == true){
                self.playAlarm2()}
            
    }
        }
        if(Global.shared.loopif == true){

        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            print("4.5")
            UIView.animate(withDuration: 0.2, animations: {
                self.arrow.frame.origin.y -= -180
            },completion: nil)
            if(Global.shared.loopif == true){
                self.playAlarm3()}
    }
        }
        
        
        
    }
    

    
    func playAlarm() {
            let url = Bundle.main.url(forResource: "loopviewcon2", withExtension: "mp3")
            Global.shared.audioloopviewCont = AVPlayer.init(url: url!)
        Global.shared.audioloopviewCont .play()
    }
    
    func playAlarm2() {
            let url = Bundle.main.url(forResource: "rpeat2", withExtension: "mp3")
            Global.shared.audiorpeat2 = AVPlayer.init(url: url!)
        Global.shared.audiorpeat2  .play()
    }
    func playAlarm3() {
            let url = Bundle.main.url(forResource: "rpeat3", withExtension: "mp3")
            Global.shared.audiorpeat3 = AVPlayer.init(url: url!)
        Global.shared.audiorpeat3  .play()
    }
    

}
