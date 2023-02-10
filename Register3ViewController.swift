//
//  Register3ViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 19/07/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia

class Register3ViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var boy: UIButton!
    @IBOutlet weak var Charactervalidation: UILabel!
    @IBOutlet weak var ThirdButton: UIButton!
    
    
    var Character = ""

    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    var whatCharacterPressed = ""
    
    @IBAction func ThirdButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        Charactervalidation.isHidden = true
        Charactervalidation.text = "* الرجاء اختيار الشخصية"
        Character = whatCharacterPressed
        Global.shared.usercharacter = Character
        print(" Character : " , Character)

        if isPressed {
        
//            if (whatCharacterPressed == "girl"){
//                selectedImage.image = UIImage(named:"girl.png")
//            }else{
//                selectedImage.image = UIImage(named:"boy.png")
//            }
            
        self.performSegue(withIdentifier: "goToCharacterName", sender: self)
//            if (Character == "girl"){
//            let imageName = "girl.png"
//            let image = UIImage(named: imageName)
//            let imageView = UIImageView(image: image!)
//            imageView.frame = CGRect(x: 293, y: 611, width: 246, height: 210)
//            view.addSubview(imageView)
//            }else if (Character == "boy"){
//                let imageName = "boy.png"
//                let image = UIImage(named: imageName)
//                let imageView = UIImageView(image: image!)
//                imageView.frame = CGRect(x: 293, y: 611, width: 246, height: 210)
//                view.addSubview(imageView)
//            }
        }else{
        Charactervalidation.isHidden = false
        }

    }
    
    
    var isPressed = false
    @IBAction func GirlPressed(_ sender: UIButton) {
        
    Charactervalidation.isHidden = true
    isPressed = true
//    girl.isHidden = true
    girl.backgroundColor = UIColor.lightGray
    boy.backgroundColor = UIColor.white
    print("Girl pressed")
    whatCharacterPressed = "girl"
    }
    
    @IBAction func BoyPressed(_ sender: UIButton) {
    
      Charactervalidation.isHidden = true
      isPressed = true
        girl.backgroundColor = UIColor.white
        boy.backgroundColor = UIColor.lightGray
//      boy.isHidden = true
      print("Boy pressed")
      whatCharacterPressed = "boy"
    }
}
