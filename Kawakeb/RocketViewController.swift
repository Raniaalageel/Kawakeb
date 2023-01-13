//
//  RocketViewController.swift
//  Kawakeb
//
//  Created by SHAMMA  on 20/06/1444 AH.
//

import UIKit
var Simage:UIImageView = UIImageView()
var Sname:String=""
var Sprice:Int=0


class RocketViewController: UIViewController {

    @IBOutlet weak var selectedIMG: UIImageView!
    
    
    @IBOutlet weak var selectedName: UILabel!
    
    @IBOutlet weak var selectedPrice: UILabel!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "firstbg.png")!)
        selectedIMG.image = Simage.image
        view.addSubview(selectedIMG)
        selectedName.text = Sname
        selectedPrice.text = String(Sprice)
        // Do any additional setup after loading the view.
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
