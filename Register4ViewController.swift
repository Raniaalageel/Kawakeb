//
//  Register4ViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 19/07/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia


class Register4ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var CharacterNamevalidation: UILabel!
    @IBOutlet weak var CreateAccountButton: UIButton!

    
    
    var CharacterName = ""
    var points = 0
    var currentRocket = "الصاروخ الأبيض"
    var currentRockIMG = "rocket2.png"
    var Mercury = "open"
    var Flower = "close"
    var Earth = "close"
    var Mars = "close"
    var MercuryPoints = 0
    var  FlowerPoints = 0
    var  EarthPoints = 0
    var MarsPoints = 0
    var rockets = ["الصاروخ الأبيض"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        nameTextField.text = Global.shared.usercharacterName
        
    }
    

    @IBAction func CreateAccountButton(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = true
        CharacterNamevalidation.isHidden = true
        
//        if (Character == "girl"){
//         selectedImage.image = UIImage(named:"girl.png")
//         }else if (Character == "boy"){
//         selectedImage.image = UIImage(named:"boy.png")
//         }else{
//             selectedImage.image = UIImage(named:"LOGO")
//         }
//        ___________________________________________________________________
//        if (Global.shared.usercharacter == "girl"){
//        let imageName = "girl.png"
//        let image = UIImage(named: imageName)
//        let imageView = UIImageView(image: image!)
//        imageView.frame = CGRect(x: 293, y: 700, width: 246, height: 210)
//        view.addSubview(imageView)
//        }else if (Global.shared.usercharacter == "boy"){
//            let imageName = "boy.png"
//            let image = UIImage(named: imageName)
//            let imageView = UIImageView(image: image!)
//            imageView.frame = CGRect(x: 293, y: 700, width: 246, height: 210)
//            view.addSubview(imageView)
//        }
//        ___________________________________________________________________

               let validationResult = isValidName()
               if validationResult.0 == false {return}
       
               let name = validationResult.1
       
               CharacterName = name
               Global.shared.usercharacterName = name
               print("CharacterName : " , CharacterName)
        
        
               
               print("Global email : " , Global.shared.useremailshare )
               print("Global password : ", Global.shared.userpasswordshare )
               print("Global birthday : ", Global.shared.userbirthday )
               print(" Global character : " , Global.shared.usercharacter)
               print("Global character name : " , Global.shared.usercharacterName)
         
        
        


         
        Auth.auth().createUser(withEmail: Global.shared.useremailshare, password: Global.shared.userpasswordshare) { authResult , error in
            guard let userId  = authResult?.user.uid else {return}
            self.storeUserInformation(id: userId)
        if let e = error {
        print(e.localizedDescription)
        }else {
        // Go to our home screen
        self.performSegue(withIdentifier: "goToHomePage", sender: self)
           }
        }
        
    }
    

    
    func isValidName() -> (Bool, String, String) {
        
        guard let Name = nameTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !Name.isEmpty
        else {
            CharacterNamevalidation.isHidden = false
            CharacterNamevalidation.text = "* الرجاء إدخال اسم الشخصية"
            return (false, "", "")
           }
        if !isValidCharacterName(nameText: Name) {
            CharacterNamevalidation.isHidden = false
            CharacterNamevalidation.text = "* الرجاء إدخال اسم شخصية صحيح"
            return (false, "", "")
        }
        return (true, Name , "")
    }
    
    
    func isValidCharacterName(nameText:String) -> Bool {
        
        let NameRegEx = "\\w{2,12}"
        let NameTest = NSPredicate(format:"SELF MATCHES %@", NameRegEx)
        return NameTest.evaluate(with: nameText)
    }
    
    
    
    func storeUserInformation(id: String)  {
            
            let post = ["email": Global.shared.useremailshare,
                        "password": Global.shared.userpasswordshare,
                        "dob": Global.shared.userbirthday,
                        "character": Global.shared.usercharacter,
                        "name": Global.shared.usercharacterName,
                        "points" : points ,
                        "currentRocket": currentRocket ,
                        "currentRockIMG": currentRockIMG ,
                        "Mercury" : Mercury ,
                        "Flower" : Flower ,
                        "Earth" : Earth ,
                        "Mars" : Mars ,
                        "MercuryPoints" : MercuryPoints ,
                        "FlowerPoints" : FlowerPoints ,
                        "EarthPoints" : FlowerPoints ,
                        "MarsPoints" : MarsPoints ,
                        "rockets" : rockets ,
                        "FirstGameHintIsUsed" : false ,
                        "SecondGameHintIsUsed" : false ,
                        "ThirdGameHintIsUsed" : false
            ] as [String : Any]
            let db = Firestore.firestore()
                   do {
                    try db.collection("Child").document(id).setData(post)
                   } catch {
                       print(error.localizedDescription)
                   }
        print("add the user into the firebafe firestore")
        }
    
    

}
