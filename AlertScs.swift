//
//  AlertScs.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 10/06/1444 AH.
//

import UIKit
import SpriteKit

class AlertScs: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func nextbutton(_ sender: UIButton) {
    }
    
    @IBAction func homebage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! Gamespage
        present(vc, animated: false, completion: nil)
    }
    
}
