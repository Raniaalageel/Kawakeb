//
//  updateRocketViewController.swift
//  Kawakeb
//
//  Created by SHAMMA  on 21/06/1444 AH.
//

import UIKit
var Uimage:UIImageView = UIImageView()
var Uname:String=""
class updateRocketViewController: UIViewController {

    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var newName: UILabel!
    @IBOutlet weak var newRoc: UIImageView!
    override func viewDidLoad() {
    
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "firstbg.png")!)
        newRoc.image = Uimage.image
        view.addSubview(newRoc)
        newName.text = Uname
       
      
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
