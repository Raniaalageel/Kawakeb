//
//  AlertScsFai.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 10/06/1444 AH.
//

import UIKit

class AlertScs: UIViewController {

    @IBOutlet weak var imageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let fireworks = UIImage.gifImageWithName("fireworks")
        imageview.image = fireworks
        // Do any additional setup after loading the view.
    }
    

    

}
